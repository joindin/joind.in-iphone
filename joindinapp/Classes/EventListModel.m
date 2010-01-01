//
//  EventListModel.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventListModel.h"
#import "EventDetailModel.h"


@implementation EventListModel

@synthesize events;

- (EventListModel *)init {
	self.events = [NSMutableArray array];
	return self;
}

- (void)addEvent:(EventDetailModel *)edm {
	[edm retain];
	[self.events addObject:edm];
}

- (EventDetailModel *)getEventDetailModelAtIndex:(NSUInteger)idx {
	return [self.events objectAtIndex:idx];
}

- (NSUInteger)getNumEvents {
	return [self.events count];
}


@end
