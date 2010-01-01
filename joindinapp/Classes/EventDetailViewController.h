//
//  EventDetailViewController.h
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"
#import "EventDetailViewCell.h"

@interface EventDetailViewController : UITableViewController {
	EventDetailModel *event;
	IBOutlet EventDetailViewCell *tblCell;
}

@property (nonatomic, retain) EventDetailModel *event;

@end
