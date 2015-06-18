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

#import "EventDetailModel.h"
#import "TracksListModel.h"

@implementation EventDetailModel

@synthesize name;
@synthesize startDate;
@synthesize endDate;
@synthesize description;
@synthesize stub;
@synthesize href;
@synthesize icon;
@synthesize latitude;
@synthesize longitude;
@synthesize tzContinent;
@synthesize tzPlace;
@synthesize location;
@synthesize hashtag;
@synthesize attendeeCount;
@synthesize attending;
@synthesize commentsEnabled;
@synthesize eventCommentsCount;
@synthesize tracksCount;
@synthesize talksCount;
@synthesize cfpStartDate;
@synthesize cfpEndDate;
@synthesize cfpURL;
@synthesize talkCommentsCount;
@synthesize uri;
@synthesize verboseURI;
@synthesize commentsURI;
@synthesize talksURI;
@synthesize tracksURI;
@synthesize attendingURI;
@synthesize websiteURI;
@synthesize humaneWebsiteURI;
@synthesize allTalkCommentsURI;
@synthesize attendeesURI;


-(id)init {
	return self;
}

-(BOOL)isNowOn {
	return ([self hasStarted] && ![self hasFinished]);
}

-(BOOL)hasFinished {
	return ([self.endDate compare:[NSDate date]] == NSOrderedAscending);
}

-(BOOL)hasStarted {
	return ([self.startDate compare:[NSDate date]] == NSOrderedAscending);
}

-(BOOL)postEventTimeLimitReached {
    // The event time limit is 12 weeks following the end of the event
    NSDateComponents *weekComponent = [[NSDateComponents alloc] init];
    weekComponent.week = 12;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [calendar dateByAddingComponents:weekComponent toDate:self.endDate options:0];

    return ([nextDate compare:[NSDate date]] == NSOrderedAscending);
}

-(NSComparisonResult)comparator:(EventDetailModel *)otherModel {
	return [self.startDate compare:otherModel.startDate];
}

-(BOOL)hasTracks {
	return (self.tracksCount > 0);
}

@end
