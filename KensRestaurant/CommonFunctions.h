//
//  CommonFunctions.h
//  Kens
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunctions : NSObject
+ (NSURL*)urlFor: (NSString*)urlString;
+ (void) showError:(NSString*) title message:(NSString*) message;
@end
