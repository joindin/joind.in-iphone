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

#import "EventDetailModel.h"
#import "TracksListModel.h"

@implementation EventDetailModel

@synthesize name;
@synthesize start;
@synthesize end;
@synthesize Id;
@synthesize location;
@synthesize description;
@synthesize active;
@synthesize stub;
@synthesize tzCont;
@synthesize tzPlace;
@synthesize icon;
@synthesize pending;
@synthesize hashtag;
@synthesize url;
@synthesize cfpStart;
@synthesize cfpEnd;
@synthesize voting;
@synthesize private;
@synthesize numAttend;
@synthesize numComments;
@synthesize allowComments;
@synthesize isAuthd;
@synthesize userAttend;
@synthesize event_lat;
@synthesize event_long;
@synthesize tracks;

-(id)init {
	self.tracks = [[TracksListModel alloc] init];
	return self;
}

-(BOOL)isNowOn {
	return ([self hasStarted] && ![self hasFinished]);
}

-(BOOL)hasFinished {
	return ([self.end compare:[NSDate date]] == NSOrderedAscending);
}

-(BOOL)hasStarted {
	return ([self.start compare:[NSDate date]] == NSOrderedAscending);
}

-(NSComparisonResult)comparator:(EventDetailModel *)otherModel {
	return [self.start compare:otherModel.start];
}

-(BOOL)hasTracks {
	return ([self.tracks getNumTracks] > 0);
}

@end
