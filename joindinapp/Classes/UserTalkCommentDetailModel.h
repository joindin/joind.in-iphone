//
//  UserTalkCommentDetailModel.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCommentDetailModel.h"


@interface UserTalkCommentDetailModel : UserCommentDetailModel {
	NSUInteger  talkId;
	NSUInteger  rating;
	NSString   *type;    // null for normal comment, "vote" for pre-event vote
}

@property (nonatomic, assign) NSUInteger  talkId;
@property (nonatomic, assign) NSUInteger  rating;
@property (nonatomic, retain) NSString   *type;

@end
