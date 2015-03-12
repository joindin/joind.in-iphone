//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "TalkListModel.h"
#import "TalkDetailModel.h"


@implementation TalkListModel

@synthesize talks;
@synthesize talksByDate;
@synthesize event;
@synthesize talksNow;
@synthesize talksNext;

- (id)initWithEvent:(EventDetailModel *)_edm {
	self.talks = [NSMutableArray array];
	self.talksByDate = [[NSMutableDictionary alloc] init];
	self.event = _edm;
	self.talksNow  = [NSMutableArray array];
	self.talksNext = [NSMutableArray array];
	return self;
}

- (void)addTalk:(TalkDetailModel *)tdm {
	[tdm retain];
	[self.talks addObject:tdm];
	
	NSString *dateString = [tdm getSortableDateString:self.event];
	
	if ([self.talksByDate objectForKey:dateString] == nil) {
		NSMutableArray *thing = [[NSMutableArray alloc] initWithCapacity:1];
		[thing addObject:tdm];
		[self.talksByDate setObject:thing forKey:dateString];
		[thing release];
	} else {
		NSMutableArray *thing = [self.talksByDate objectForKey:dateString];
		[thing addObject:tdm];
	}
	
	if ([tdm onNow]) {
		[self.talksNow addObject:tdm];
	}
	if ([tdm onNext]) {
		[self.talksNext addObject:tdm];
	}
	
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
		int n = (int)[self.talks count];
		for (int i=0; i<n/2; ++i) {
			id c  = [self.talks objectAtIndex:i];
			[self.talks replaceObjectAtIndex:i withObject:[self.talks objectAtIndex:n-i-1]];
			[self.talks replaceObjectAtIndex:n-i-1 withObject:c];
		}
	}
	
	// Re-index the array in talksByDate
	self.talksByDate = [[NSMutableDictionary alloc] init];
	for (TalkDetailModel *tdm in self.talks) {
		NSString *dateString = [tdm getSortableDateString:self.event];
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
		
}

- (NSUInteger)getNumTalks {
	return [self.talks count];
}

- (NSDictionary *)getTalksByDate {
	return self.talksByDate;
}

/*
- (NSArray *)getTalksOnDate:(NSDate *)date {
	
	NSMutableArray *allTalks = [[[NSMutableArray alloc] init] autorelease];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE d MMM yyyy"];
	
	for (TalkDetailModel *tdm in self.talks) {
		if ([[tdm getDateString:self.event] isEqualToString:[dateFormatter stringFromDate:date]]) {
			[allTalks addObject:tdm];
		}
	}
	
	[dateFormatter release];
	
	return allTalks;
}
*/

- (TalkDetailModel *)getTalkForDayAndRowByIndex:(NSUInteger)dayIndex rowIndex:(NSUInteger)rowIndex {
	
	NSDictionary *allDates = [self getTalksByDate];
	NSArray *dates = [[allDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSString *relevantDate = [dates objectAtIndex:dayIndex];
	NSArray *talksOnDate = [allDates objectForKey:relevantDate];
	
	TalkDetailModel *tdm = [talksOnDate objectAtIndex:rowIndex];
	return tdm;	
}

@end
