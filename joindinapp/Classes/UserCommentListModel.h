//
//  UserCommentListModel.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCommentDetailModel.h"
#import "UserTalkCommentDetailModel.h"
#import "UserEventCommentDetailModel.h"
#import "TalkDetailModel.h"
#import "EventDetailModel.h"

@interface UserCommentListModel : NSObject {
	NSMutableArray *comments;
}

@property(nonatomic, retain) NSMutableArray *comments;

- (void)addComment:(UserCommentDetailModel *)tcdm;
- (UserCommentDetailModel *)getUserCommentAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumComments;

- (UserTalkCommentDetailModel *)getCommentForTalk:(TalkDetailModel *)talk;
- (UserEventCommentDetailModel *)getCommentForEvent:(EventDetailModel *)talk;

@end
