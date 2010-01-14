//
//  TalkCommentListModel.m
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkCommentListModel.h"
#import "TalkCommentDetailModel.h"


@implementation TalkCommentListModel

@synthesize comments;

- (TalkCommentListModel *)init {
	self.comments = [NSMutableArray array];
	return self;
}

- (void)addComment:(TalkCommentDetailModel *)tcdm {
	[tcdm retain];
	[self.comments addObject:tcdm];
}

- (TalkCommentDetailModel *)getTalkCommentAtIndex:(NSUInteger)idx {
	return [self.comments objectAtIndex:idx];
}

- (NSUInteger)getNumComments {
	return [self.comments count];
}

@end
