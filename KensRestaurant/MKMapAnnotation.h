//
//  MKMapAnnotation.h
//  YourRestaurant
//
//  Created by Lee Machin on 13/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapAnnotation : NSObject <MKAnnotation> {
  NSString *_name;
  NSString *_address;
  CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end
