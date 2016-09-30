//
//  EventListItemTableViewCell.h
//  joindinapp
//
//  Created by Rich Sage on 30/09/2016.
//  Copyright © 2016 joind.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventListItemTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *eventIcon;

@end
