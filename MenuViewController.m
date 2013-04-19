//
//  MenuViewController.m
//  KensRestaurant
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemCell.h"

@interface MenuViewController ()

@end

@implementation MenuViewController {
    id responseBody;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    // Making API Call
    NSMutableURLRequest *request = nil;
    request = [NSMutableURLRequest requestWithURL:[MenuViewController urlFor:@"menu"]];
    
    NSString *get = @""; // get string, if any.. mostly used for post
    NSData *getData = [get dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [request setValue:[NSString stringWithFormat:@"%d", [getData length]] forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval: 15];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:getData];
    
    NSURLConnection *_urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_urlConnection start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


                                                    /* API CALL - Connection Related Functions.. [STARTS]*/
// Connection Recieved..
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    receivedData = [[NSMutableData alloc]init];
    [receivedData appendData:data];
    NSLog(@"In COnnection recieved...");
    
    
}

// Connection failed
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //Oops! handle failure here
    NSLog(@"In COnnection failed...%@", [error localizedDescription]);
    [MenuViewController showError:@"Connection Failed" message:@"Failed to connect to server. Please try again."];
}


// Connection loaded
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error = nil;
    responseBody = [NSJSONSerialization JSONObjectWithData:receivedData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&error];

    // Reload table data... after the content loads
    if(responseBody)
        [self.tableView reloadData];
    
    NSLog(@"In Connection loading...");
}

                                                    /* API CALL - Connection Related Functions.. [ENDS] */


                                                    /* TABLE VIEW - Render(UITableViewDelegate) Related Functions.. [STARTS] */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"responsecount %d", [responseBody count]);
    return [responseBody count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItemCell *cell = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"menuItem"];
    if(!cell)
    {
        cell = [[MenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuItem"];
    }
    
    id rowObject = [responseBody objectAtIndex:indexPath.row];
    cell.menuTitle.text = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"name"]];
    cell.menuDescription.text = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"description"]];
    cell.menuIdentifier = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"identifier"]];
    
    return cell;
}

                                            /* TABLE VIEW - Render(UITableViewDelegate) Related Functions.. [ENDS] */



+ (NSURL*)urlFor: (NSString*)urlString
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ApplicationApiRootUrl"], urlString]];
}

+ (void) showError:(NSString*) title message:(NSString*) message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: title
                          message: message
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}


@end
