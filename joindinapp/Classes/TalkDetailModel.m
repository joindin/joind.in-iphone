//
//  TalkDetailModel.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkDetailModel.h"

@implementation TalkDetailModel

@synthesize title;
@synthesize speaker;
@synthesize Id;
@synthesize eventId;
@synthesize slidesLink;
@synthesize given;
@synthesize desc;
@synthesize langName;
@synthesize lang;
@synthesize rating;
@synthesize type;
@synthesize active;
@synthesize speakerId;
@synthesize private;
@synthesize langAbbr;
@synthesize numComments;
@synthesize lastComment;
@synthesize allowComments;
@synthesize tracks;
@synthesize nowNext;

-(id)init {
	self.tracks = [[TracksListModel alloc] init];
	return self;
}

-(BOOL)hasFinished {
	return ([self.given compare:[NSDate dateWithTimeIntervalSinceNow:-86400]] == NSOrderedAscending);
}

-(NSComparisonResult)comparator:(TalkDetailModel *)otherModel {
	return [self.given compare:otherModel.given];
}

- (NSDate *)getAdjustedDateGiven:(EventDetailModel *)event {
	NSTimeZone *sourceTZ;
	NSTimeZone *destTZ;
	
	sourceTZ = [NSTimeZone timeZoneWithName:@"UTC"];
	
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	if ([userPrefs stringForKey:@"timezonedisplay"] == nil) {
		[userPrefs setObject:@"event" forKey:@"timezonedisplay"];
		[userPrefs synchronize];
	}
	
	if ([[userPrefs stringForKey:@"timezonedisplay"] isEqualToString:@"event"]) {
		destTZ = [NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@/%@", event.tzCont, event.tzPlace]];
	} else {
		destTZ = [NSTimeZone systemTimeZone];
	}
	
	if (destTZ == nil) {
		destTZ = [NSTimeZone timeZoneWithName:@"UTC"];
	}
	
	NSInteger sourceGMTOffset = [sourceTZ secondsFromGMTForDate:self.given];
	NSInteger destinationGMTOffset = [destTZ secondsFromGMTForDate:self.given];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
	
	//NSLog(@"Dest offset [%d] Source offset [%d]", destinationGMTOffset, sourceGMTOffset);
	
	NSDate* destDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:self.given] autorelease];
	return destDate;
}

-(NSString *)getFormattedDateString:(EventDetailModel *)event format:(NSString *)format {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSString *retval = [dateFormatter stringFromDate:[self getAdjustedDateGiven:event]];
	[dateFormatter release];
 	return retval;
}

- (NSString *)getDateString:(EventDetailModel *)event {
	return [self getFormattedDateString:event format:@"EEE d MMM yyyy"];
}

- (NSString *)getSortableDateString:(EventDetailModel *)event {
	return [self getFormattedDateString:event format:@"yyyy-MM-dd"];
}

- (NSString *)getTimeString:(EventDetailModel *)event {
	NSString *retval = [[self getFormattedDateString:event format:@"h:mma"] lowercaseString];
	if ([retval isEqualToString:@"12:00am"]) {
		retval = @"";
	}
	return retval;
}

- (BOOL)onNow {
	return [self.nowNext isEqualToString:@"now"];
}

- (BOOL)onNext {
	return [self.nowNext isEqualToString:@"next"];
}

@end
