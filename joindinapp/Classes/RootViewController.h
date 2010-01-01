//
//  RootViewController.h
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EventListModel.h"

@interface RootViewController : UITableViewController {
	EventListModel *confListData;
}

@property(nonatomic, retain) EventListModel *confListData;

@end
