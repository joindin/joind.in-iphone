//
//  EventListViewController.h
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EventListModel.h"

@interface EventListViewController : UITableViewController {
	EventListModel *confListData;
	IBOutlet UIView *uiTableHeaderView;
	IBOutlet UISegmentedControl *uiEventRange;
	IBOutlet UITableViewCell *uiFetchingCell;
}

@property(nonatomic, retain) EventListModel *confListData;
@property(nonatomic, retain) UIView *uiTableHeaderView;
@property(nonatomic, retain) UISegmentedControl *uiEventRange;
@property(nonatomic, retain) UITableViewCell *uiFetchingCell;

- (void)rangeChanged;

@end
