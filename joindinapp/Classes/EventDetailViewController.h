//
//  EventDetailViewController.h
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"
#import "TalkListModel.h"

@interface EventDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
	EventDetailModel *event;
	TalkListModel *talks;
	
	UIScrollView *uiScroller;
	// IB components
	IBOutlet UILabel  *uiTitle;
	IBOutlet UILabel  *uiDate;
	IBOutlet UILabel  *uiLocation;
	IBOutlet UILabel  *uiDesc;
	IBOutlet UIButton *uiDescButton;
	IBOutlet UIView *uiViewWithContent;
}

- (UIView*) createFixedView;
- (IBAction)uiDescButtonPressed:(id)sender;

@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) TalkListModel *talks;

@property (nonatomic, retain) UILabel  *uiTitle;
@property (nonatomic, retain) UILabel  *uiDate;
@property (nonatomic, retain) UILabel  *uiLocation;
@property (nonatomic, retain) UILabel  *uiDesc;
@property (nonatomic, retain) UIButton *uiDescButton;
@property (nonatomic, retain) UIScrollView  *uiScroller;
@property (nonatomic, retain) UIView  *uiViewWithContent;

@end
