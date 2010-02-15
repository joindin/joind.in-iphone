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

-(BOOL)hasFinished {
	return ([self.given compare:[NSDate dateWithTimeIntervalSinceNow:-86400]] == NSOrderedAscending);
}

-(NSComparisonResult)comparator:(TalkDetailModel *)otherModel {
	return [self.given compare:otherModel.given];
}

@end
