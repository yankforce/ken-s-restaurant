//
//  ReachUsViewController.m
//  Kens
//
//  Created by Mac Mini on 4/19/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import "ReachUsViewController.h"

@interface ReachUsViewController ()

@end

@implementation ReachUsViewController {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - API CALL - Connection Related Functions
 
// Connection Recieved..
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    receivedData = [[NSMutableData alloc]init];
    [receivedData appendData:data];
    
    
}

// Connection failed
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //Oops! handle failure here
    [CommonFunctions showError:@"Connection Failed" message:@"Failed to connect to server. Please try again."];
}


// Connection loaded
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError* error = nil;
    responseBody = [NSJSONSerialization JSONObjectWithData:receivedData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    
    // Reload table data... after the content loads
    if(responseBody){
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
    }
}

#pragma mark - Map View Delegates
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"Ken's Restaurant";
    
    if ([annotation isKindOfClass:[MKMapAnnotation class]]) {
        MKMapAnnotation *annotationLocation = (MKMapAnnotation *) annotation;
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [[self mapView] dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotationLocation reuseIdentifier:identifier];
        } else {
            [annotationView setAnnotation:annotationLocation];
        }
        
        [annotationView setEnabled:YES];
        [annotationView setCanShowCallout:YES];
        [annotationView setAnimatesDrop:YES];
        [annotationView setPinColor:MKPinAnnotationColorPurple];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fork-and-knife-white.png"]];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self action:@selector(showMoreInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        [annotationView setLeftCalloutAccessoryView:imageView];
        [annotationView setRightCalloutAccessoryView:button];
         
        imageView = nil;
        
        
        return annotationView;
    } else {
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    // we want to make sure that our pin is selected automatically. If we have to have multiple pins at some point,
    // we'll have to determine the one closest to the user's current location.
    [mapView selectAnnotation:[[mapView annotations] objectAtIndex:0] animated:YES];
}

@end
