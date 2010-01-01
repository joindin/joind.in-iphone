//
//  TalkListModel.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkListModel.h"
#import "TalkDetailModel.h"


@implementation TalkListModel

@synthesize talks;

- (TalkListModel *)init {
	self.talks = [NSMutableArray array];
	return self;
}

- (void)addTalk:(TalkDetailModel *)edm {
	[edm retain];
	[self.talks addObject:edm];
}

- (TalkDetailModel *)getTalkDetailModelAtIndex:(NSUInteger)idx {
	return [self.talks objectAtIndex:idx];
}

- (NSUInteger)getNumTalks {
	return [self.talks count];
}

@end
