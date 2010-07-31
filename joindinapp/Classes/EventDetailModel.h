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
	NSDate     *start;
	NSDate     *end;
	NSUInteger  Id;
	NSString   *location;
	NSString   *description;
	BOOL        active;
	NSString   *stub;
	NSString   *tzCont;
	NSString   *tzPlace;
	NSString   *icon;
	BOOL        pending;
	NSString   *hashtag;
	NSString   *url;
	NSDate     *cfpStart;
	NSDate     *cfpEnd;
	BOOL        voting;
	BOOL        private;
	NSUInteger  numAttend;
	NSUInteger  numComments;
	BOOL        allowComments;
	TracksListModel *tracks;
	float       event_lat;
	float       event_long;

	// Auth'd user details
	BOOL        isAuthd;
	BOOL        userAttend;

}
@property (nonatomic, retain) NSString   *name;
@property (nonatomic, retain) NSDate     *start;
@property (nonatomic, retain) NSDate     *end;
@property (nonatomic, assign) NSUInteger  Id;
@property (nonatomic, retain) NSString   *location;
@property (nonatomic, retain) NSString   *description;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, retain) NSString   *stub;
@property (nonatomic, retain) NSString   *tzCont;
@property (nonatomic, retain) NSString   *tzPlace;
@property (nonatomic, retain) NSString   *icon;
@property (nonatomic, assign) BOOL        pending;
@property (nonatomic, retain) NSString   *hashtag;
@property (nonatomic, retain) NSString   *url;
@property (nonatomic, retain) NSDate     *cfpStart;
@property (nonatomic, retain) NSDate     *cfpEnd;
@property (nonatomic, assign) BOOL        voting;
@property (nonatomic, assign) BOOL        private;
@property (nonatomic, assign) NSUInteger  numAttend;
@property (nonatomic, assign) NSUInteger  numComments;
@property (nonatomic, assign) BOOL        allowComments;
@property (nonatomic, assign) BOOL        isAuthd;
@property (nonatomic, assign) BOOL        userAttend;
@property (nonatomic, assign) float       event_lat;
@property (nonatomic, assign) float       event_long;
@property (nonatomic, retain) TracksListModel    *tracks;

-(id)init;
-(BOOL)isNowOn;
-(BOOL)hasFinished;
-(BOOL)hasStarted;
-(NSComparisonResult)comparator:(EventDetailModel *)otherModel;
-(BOOL)hasTracks;

@end
