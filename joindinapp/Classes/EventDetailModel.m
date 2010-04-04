//
//  EventDetailModel.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
