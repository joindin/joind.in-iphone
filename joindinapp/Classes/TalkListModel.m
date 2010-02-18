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
@synthesize talksByDate;

- (TalkListModel *)init {
	self.talks = [NSMutableArray array];
	self.talksByDate = [[NSMutableDictionary alloc] init];
	return self;
}

- (void)addTalk:(TalkDetailModel *)tdm {
	[tdm retain];
	[self.talks addObject:tdm];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
	NSString *dateString = [dateFormatter stringFromDate:tdm.given];
	
	if ([self.talksByDate objectForKey:dateString] == nil) {
		NSMutableArray *thing = [[NSMutableArray alloc] initWithCapacity:1];
		[thing addObject:tdm];
		[self.talksByDate setObject:thing forKey:dateString];
		[thing release];
	} else {
		NSMutableArray *thing = [self.talksByDate objectForKey:dateString];
		[thing addObject:tdm];
	}
	
	[dateFormatter release];
	
}

- (TalkDetailModel *)getTalkDetailModelAtIndex:(NSUInteger)idx {
	return [self.talks objectAtIndex:idx];
}

- (void)sort {
	[self sort:true];
}

- (void)sort:(BOOL)forwards {
	
	[self.talks sortUsingSelector:@selector(comparator:)];
	if (!forwards) {
		// Reverse the array
		int n = [self.talks count];
		for (int i=0; i<n/2; ++i) {
			id c  = [self.talks objectAtIndex:i];
			[self.talks replaceObjectAtIndex:i withObject:[self.talks objectAtIndex:n-i-1]];
			[self.talks replaceObjectAtIndex:n-i-1 withObject:c];
		}
	}
	
	// Re-index the array in talksByDate
	self.talksByDate = [[NSMutableDictionary alloc] init];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
	for (TalkDetailModel *tdm in self.talks) {
		NSString *dateString = [dateFormatter stringFromDate:tdm.given];
		if ([self.talksByDate objectForKey:dateString] == nil) {
			NSMutableArray *thing = [[NSMutableArray alloc] initWithCapacity:1];
			[thing addObject:tdm];
			[self.talksByDate setObject:thing forKey:dateString];
			[thing release];
		} else {
			NSMutableArray *thing = [self.talksByDate objectForKey:dateString];
			[thing addObject:tdm];
		}
	}
	[dateFormatter release];
	
	
}

- (NSUInteger)getNumTalks {
	return [self.talks count];
}

- (NSDictionary *)getTalksByDate {
	return self.talksByDate;
}

- (NSArray *)getTalksOnDate:(NSDate *)date {
	
	NSMutableArray *allTalks = [[[NSMutableArray alloc] init] autorelease];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
	
	for (TalkDetailModel *tdm in self.talks) {
		if ([[dateFormatter stringFromDate:tdm.given] isEqualToString:[dateFormatter stringFromDate:date]]) {
			[allTalks addObject:tdm];
		}
	}
	
	[dateFormatter release];
	
	return allTalks;
}

- (TalkDetailModel *)getTalkForDayAndRowByIndex:(NSUInteger)dayIndex rowIndex:(NSUInteger)rowIndex {
	NSDictionary *allDates = [self getTalksByDate];
	NSArray *dates = [[allDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSString *relevantDate = [dates objectAtIndex:dayIndex];
	NSArray *talksOnDate = [allDates objectForKey:relevantDate];
	
	TalkDetailModel *tdm = [talksOnDate objectAtIndex:rowIndex];
	return tdm;	
}

@end
