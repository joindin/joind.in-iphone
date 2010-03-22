//
//  NowNextViewController.h
//  joindinapp
//
//  Created by Kevin on 21/03/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "UserCommentListModel.h"

@interface NowNextViewController : UITableViewController {

	EventDetailModel *event;
	TalkListModel *talks;
	UserCommentListModel *comments;

}

@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) TalkListModel *talks;
@property (nonatomic, retain) UserCommentListModel *comments;

@end
