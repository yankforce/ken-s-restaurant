//
//  MKMapAnnotation.m
//  Kens
//
//  Created by Mac Mini on 4/19/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import "MKMapAnnotation.h"

@implementation MKMapAnnotation

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
}

@end
