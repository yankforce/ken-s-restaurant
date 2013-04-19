//
//  ReachOutViewController.h
//  Kens
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunctions.h"

#import <MapKit/MapKit.h>

@interface ReachOutViewController : UIViewController {
    NSURLConnection *connection;
    NSMutableData *receivedData;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
