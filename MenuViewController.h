//
//  MenuViewController.h
//  KensRestaurant
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    NSURLConnection *connection;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
