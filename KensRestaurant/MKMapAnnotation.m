//
//  MKMapAnnotation.m
//  YourRestaurant
//
//  Created by Lee Machin on 13/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MKMapAnnotation.h"

@implementation MKMapAnnotation

@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate {
  if (self = [super init]) {
    _name = [name copy];
    _address = [address copy];
    _coordinate = coordinate;
  }
  return self;
}

- (NSString *)title {
  return [self name];
}

- (NSString *)subtitle {
  return [self address];
}

- (void)dealloc {
  [_name release];
  _name = nil;
  [_address release];
  _address = nil;
  
  [super dealloc];  
}

@end
