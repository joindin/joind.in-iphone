//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
	NSTimeZone *localTZ;
	
	sourceTZ = [NSTimeZone timeZoneWithName:@"UTC"];
	localTZ = [NSTimeZone systemTimeZone];
	
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
	NSInteger localGMTOffset = [localTZ secondsFromGMTForDate:self.given];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset - localGMTOffset;
	
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
