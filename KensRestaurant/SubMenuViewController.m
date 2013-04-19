//
//  SubMenuViewController.m
//  Kens
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import "SubMenuViewController.h"

@interface SubMenuViewController ()

@end

@implementation SubMenuViewController{
    id responseBody;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
        NSLog(@"got identifier.. %@", _identifier );
    [_titleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_identifier]]];

    // Making API Call
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [CommonFunctions urlFor:[NSString stringWithFormat:@"menu/%@",_identifier]]];
    
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
#pragma mark - API CALL - Connection Related Functions

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
    [CommonFunctions showError:@"Connection Failed" message:@"Failed to connect to server. Please try again."];
}


// Connection loaded
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error = nil;
    responseBody = [NSJSONSerialization JSONObjectWithData:receivedData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    
    // Reload table data... after the content loads
    if(responseBody) {
        NSLog(@"got count.. %i", [responseBody count] );

        [self.tableView reloadData];
         }
    
    NSLog(@"In Connection loaded... %@" , responseBody);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [responseBody count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubMenuItemCell *cell = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"subMenuItem"];
    if(!cell)
    {
        cell = [[SubMenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuItem"];
    }
    
    id rowObject = [responseBody objectAtIndex:indexPath.row];
    cell.itemName.text = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"name"]];
    cell.itemPrice.text = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"description"]];
    
    return cell;
} 

@end
