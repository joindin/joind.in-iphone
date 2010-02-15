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

- (void)sort {
	[self sort:true];
}

- (void)sort:(BOOL)forwards {
	[self.events sortUsingSelector:@selector(comparator:)];
	if (!forwards) {
		// Reverse the array
		int n = [self.events count];
		for (int i=0; i<n/2; ++i) {
			id c  = [[self.events objectAtIndex:i] retain];
			[self.events replaceObjectAtIndex:i withObject:[self.events objectAtIndex:n-i-1]];
			[self.events replaceObjectAtIndex:n-i-1 withObject:c];
		}
	}
}

- (NSUInteger)getNumEvents {
	return [self.events count];
}


@end
