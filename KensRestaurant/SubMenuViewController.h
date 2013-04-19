//
//  SubMenuViewController.h
//  Kens
//
//  Created by Andrew on 4/19/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunctions.h"
#import "SubMenuItemCell.h"

@interface SubMenuViewController : UITableViewController{
    NSURLConnection *connection;
    NSMutableData *receivedData;
}

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSString *identifier;

@end
