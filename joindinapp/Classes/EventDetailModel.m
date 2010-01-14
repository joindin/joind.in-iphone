//
//  EventDetailModel.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventDetailModel.h"


@implementation EventDetailModel

@synthesize name;
@synthesize start;
@synthesize end;
@synthesize Id;
@synthesize location;
@synthesize description;
@synthesize active;
@synthesize stub;
@synthesize tzOffset;
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
@synthesize isAuthd;
@synthesize userAttend;

-(BOOL)hasFinished {
	return ([self.end compare:[NSDate date]] == NSOrderedAscending);
}

@end
