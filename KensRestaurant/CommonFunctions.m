//
//  CommonFunctions.m
//  Kens
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import "CommonFunctions.h"

@implementation CommonFunctions

+ (NSURL*)urlFor: (NSString*)urlString
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ApplicationApiRootUrl"], urlString]];
}

+ (void) showError:(NSString*) title message:(NSString*) message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: title
                          message: message
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}
@end
