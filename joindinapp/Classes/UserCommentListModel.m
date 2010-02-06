//
//  UserCommentListModel.m
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserCommentListModel.h"


@implementation UserCommentListModel

@synthesize comments;

- (UserCommentListModel *)init {
	self.comments = [NSMutableArray array];
	return self;
}

- (void)addComment:(UserCommentDetailModel *)ucdm {
	[ucdm retain];
	[self.comments addObject:ucdm];
}

- (UserCommentDetailModel *)getUserCommentAtIndex:(NSUInteger)idx {
	return [self.comments objectAtIndex:idx];
}

- (NSUInteger)getNumComments {
	return [self.comments count];
}

- (UserTalkCommentDetailModel *)getCommentForTalk:(TalkDetailModel *)talk {
	for (id c in self.comments) {
		if ([c class] == [UserTalkCommentDetailModel class]) {
			UserTalkCommentDetailModel *d = (UserTalkCommentDetailModel *)c;
			if (d.talkId == talk.Id) {
				return d;
			}
		}
	}
	return nil;
}

- (UserEventCommentDetailModel *)getCommentForEvent:(EventDetailModel *)event {
	for (id c in self.comments) {
		if ([c class] == [UserEventCommentDetailModel class]) {
			UserEventCommentDetailModel *d = (UserEventCommentDetailModel *)c;
			if (d.eventId == event.Id) {
				return d;
			}
		}
	}
	return nil;
}

@end
