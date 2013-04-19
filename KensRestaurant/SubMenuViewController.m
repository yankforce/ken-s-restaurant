//
//  SubMenuViewController.m
//  Kens
//
//  Created by Andrew on 4/19/13.
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
    
    [CommonFunctions setNavTitle:self];

    [_titleImage setImage:[UIImage imageNamed: [NSString stringWithFormat: @"%@.jpg",_identifier]]];
    // Making API Call
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[CommonFunctions urlFor:[NSString stringWithFormat:@"menu/%@",_identifier]]];
    
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
        [self.tableView reloadData];
    } 
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    // Return the number of rows in the section.
    return [responseBody count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    static NSString *cellIdentifier = @"subMenuItem";
    SubMenuItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if(!cell)
    {
        cell = [[SubMenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    
    id rowObject = [responseBody objectAtIndex:indexPath.row];
    cell.itemName.text = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"name"]]; 
    cell.itemPrice.text = [NSString stringWithFormat:@"%@",[rowObject valueForKey:@"price"]];
    
    return cell;
}
 

@end
