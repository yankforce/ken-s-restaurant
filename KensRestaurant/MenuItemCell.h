//
//  MenuItemCell.h
//  Kens
//
//  Created by Andrew on 4/18/13.
//  Copyright (c) 2013 restaurant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UILabel *menuDescription;
@property (nonatomic, copy) NSString *menuIdentifier;
@end
