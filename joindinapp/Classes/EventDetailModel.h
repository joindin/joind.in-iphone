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

#import <Foundation/Foundation.h>
#import "TracksListModel.h"

@interface EventDetailModel : NSObject {
	NSString   *name;
	NSDate     *startDate;
	NSDate     *endDate;
	NSString   *location;
	NSString   *description;
	NSString   *stub;
	NSString   *tzContinent;
	NSString   *tzPlace;
	NSString   *icon;
	NSString   *hashtag;
	NSString   *href;
	NSDate     *cfpStartDate;
	NSDate     *cfpEndDate;
	NSString   *cfpURL;
	NSUInteger  attendeeCount;
	NSUInteger  eventCommentsCount;
	NSUInteger  tracksCount;
	NSUInteger  talksCount;
	NSUInteger  talkCommentsCount;
	BOOL        commentsEnabled;
	float       latitude;
	float       longitude;

	NSString    *uri;
	NSString    *verboseURI;
	NSString    *commentsURI;
	NSString    *talksURI;
	NSString    *tracksURI;
	NSString    *attendingURI;
	NSString    *websiteURI;
	NSString    *humaneWebsiteURI;
	NSString    *allTalkCommentsURI;
	NSString    *attendeesURI;

	// Auth'd user details
	BOOL        attending;

}

@property (nonatomic, strong) NSString   *name;
@property (nonatomic, strong) NSDate     *startDate;
@property (nonatomic, strong) NSDate     *endDate;
@property (nonatomic, strong) NSString   *location;
@property (nonatomic, strong) NSString   *description;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, strong) NSString   *stub;
@property (nonatomic, strong) NSString   *tzContinent;
@property (nonatomic, strong) NSString   *tzPlace;
@property (nonatomic, strong) NSString   *icon;
@property (nonatomic, assign) BOOL        pending;
@property (nonatomic, strong) NSString   *hashtag;
@property (nonatomic, strong) NSString   *href;
@property (nonatomic, strong) NSDate     *cfpStartDate;
@property (nonatomic, strong) NSDate     *cfpEndDate;
@property (nonatomic, strong) NSString   *cfpURL;
@property (nonatomic, assign) BOOL        voting;
@property (nonatomic, assign) BOOL        private;
@property (nonatomic, assign) NSUInteger  attendeeCount;
@property (nonatomic, assign) NSUInteger  eventCommentsCount;
@property (nonatomic, assign) NSUInteger  tracksCount;
@property (nonatomic, assign) NSUInteger  talksCount;
@property (nonatomic, assign) NSUInteger  talkCommentsCount;
@property (nonatomic, assign) BOOL        commentsEnabled;
@property (nonatomic, assign) BOOL        attending;
@property (nonatomic, assign) float       latitude;
@property (nonatomic, assign) float       longitude;
@property (nonatomic, strong) NSString    *uri;
@property (nonatomic, strong) NSString    *verboseURI;
@property (nonatomic, strong) NSString    *commentsURI;
@property (nonatomic, strong) NSString    *talksURI;
@property (nonatomic, strong) NSString    *tracksURI;
@property (nonatomic, strong) NSString    *attendingURI;
@property (nonatomic, strong) NSString    *websiteURI;
@property (nonatomic, strong) NSString    *humaneWebsiteURI;
@property (nonatomic, strong) NSString    *allTalkCommentsURI;
@property (nonatomic, strong) NSString    *attendeesURI;

-(id)init;
-(BOOL)isNowOn;
-(BOOL)hasFinished;
-(BOOL)hasStarted;
-(BOOL)postEventTimeLimitReached;
-(NSComparisonResult)comparator:(EventDetailModel *)otherModel;
-(BOOL)hasTracks;

@end
