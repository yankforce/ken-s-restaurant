//
//  ReachOutViewController.m
//  Kens
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import "ReachOutViewController.h"
#import "MKMapAnnotation.h"

@interface ReachOutViewController ()

@end

@implementation ReachOutViewController{
    id responseBody;
    MKMapAnnotation *addAnnotation;
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
    
    [CommonFunctions setNavTitle:self];
    // Making API Call
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[CommonFunctions urlFor:@"about"]];
    
    NSString *get = @""; // get string, if any.. mostly used for post
    NSData *getData = [get dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [request setValue:[NSString stringWithFormat:@"%d", [getData length]] forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval: 15];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:getData];
    
    NSURLConnection *_urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_urlConnection start];
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
    /*
        CLLocationCoordinate2D coord = {
            .latitude = [[responseBody objectForKey:@"latitude"] doubleValue],
            .longitude = [[responseBody objectForKey:@"longitude"] doubleValue]
        };
        
        MKCoordinateSpan span = {.latitudeDelta = 0.1, .longitudeDelta = 0.1};
        MKCoordinateRegion region = {coord, span};
        
        [[self mapView] removeAnnotations:[[self mapView] annotations]];
        
        
        MKMapAnnotation *annotation = [[MKMapAnnotation alloc]
                                       initWithName:[responseBody objectForKey:@"name"]
                                       address:[responseBody objectForKey:@"area"]
                                       coordinate:coord];
        [[self mapView] addAnnotation:annotation];
        [[self mapView] setRegion:region animated: YES];
      */   
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
@end
