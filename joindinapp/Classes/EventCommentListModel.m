//
//  EventCommentListModel.m
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventCommentListModel.h"
#import "TalkCommentDetailModel.h"

@implementation EventCommentListModel

@synthesize comments;

- (EventCommentListModel *)init {
	self.comments = [NSMutableArray array];
	return self;
}

- (void)addComment:(EventCommentDetailModel *)ecdm {
	[ecdm retain];
	[self.comments addObject:ecdm];
}

- (EventCommentDetailModel *)getEventCommentAtIndex:(NSUInteger)idx {
	return [self.comments objectAtIndex:idx];
}

- (NSUInteger)getNumComments {
	return [self.comments count];
}


@end
