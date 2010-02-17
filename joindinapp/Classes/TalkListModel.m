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

- (void)addTalk:(TalkDetailModel *)tdm {
	[tdm retain];
	[self.talks addObject:tdm];
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
			id c  = [[self.talks objectAtIndex:i] retain];
			[self.talks replaceObjectAtIndex:i withObject:[self.talks objectAtIndex:n-i-1]];
			[self.talks replaceObjectAtIndex:n-i-1 withObject:c];
		}
	}
}

- (NSUInteger)getNumTalks {
	return [self.talks count];
}

- (NSDictionary *)getTalksByDate {
	NSMutableDictionary *allDates = [[NSMutableDictionary alloc] initWithCapacity:1];
	for (TalkDetailModel *tdm in self.talks) {
		// First get the date
		NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:tdm.given];
		NSString *dateString = [NSString stringWithFormat:@"%d%d%d", [dateComponents year], [dateComponents month], [dateComponents day]];
		//NSLog(@"Addr of dateString: %i", &dateString);
		
		if ([allDates objectForKey:dateString] == nil) {
			NSMutableArray *thing = [[NSMutableArray alloc] initWithCapacity:1];
			[thing addObject:tdm];
			[allDates setObject:thing forKey:dateString];
		} else {
			NSMutableArray *thing = [allDates objectForKey:dateString];
			[thing addObject:tdm];
		}
	}
	return allDates;
}

- (NSArray *)getTalksOnDate:(NSDate *)date {
	
	NSMutableArray *allTalks = [[NSMutableArray alloc] init];
	
	for (TalkDetailModel *tdm in self.talks) {
		// First get the date of the talk
		NSDateComponents *dateComponents1 = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:tdm.given];
		NSString *dateString1 = [NSString stringWithFormat:@"%d%d%d", [dateComponents1 year], [dateComponents1 month], [dateComponents1 day]];
		// Get the date to compare
		NSDateComponents *dateComponents2 = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
		NSString *dateString2 = [NSString stringWithFormat:@"%d%d%d", [dateComponents2 year], [dateComponents2 month], [dateComponents2 day]];
		
		if ([dateString1 isEqualToString:dateString2]) {
			[allTalks addObject:tdm];
		}
	}
	
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
