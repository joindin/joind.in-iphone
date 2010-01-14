//
//  TalkCommentsViewController.h
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkDetailModel.h"
#import "TalkCommentListModel.h"


@interface TalkCommentsViewController : UITableViewController {
	TalkDetailModel *talk;
	TalkCommentListModel *comments;
	
	IBOutlet UILabel *uiComment;
	IBOutlet UILabel *uiAuthor;
	IBOutlet UIImageView *uiRating;
	IBOutlet UITableViewCell *uiCell;
	
}

@property (nonatomic, retain) TalkDetailModel *talk;
@property (nonatomic, retain) TalkCommentListModel *comments;

@property (nonatomic, retain) UILabel *uiComment;
@property (nonatomic, retain) UILabel *uiAuthor;
@property (nonatomic, retain) UIImageView *uiRating;
@property (nonatomic, retain) UITableViewCell *uiCell;

@end
