//
//  ReachUsViewController.h
//  Kens
//
//  Created by Mac Mini on 4/19/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CommonFunctions.h"
#import "MKMapAnnotation.h"
@interface ReachUsViewController : UIViewController<MKMapViewDelegate> {
    NSURLConnection *connection;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
