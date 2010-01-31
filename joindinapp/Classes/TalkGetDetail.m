//
//  TalkGetDetail.m
//  joindinapp
//
//  Created by Kevin on 16/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkGetDetail.h"


@implementation TalkGetDetail

- (void)call:(TalkDetailModel *)talk {
	[self callAPI:@"talk" action:@"getdetail" params:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", talk.Id] forKey:@"talk_id"] needAuth:YES canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	TalkDetailModel *tdm = [[TalkDetailModel alloc] init];
	
	NSDictionary *talk = [(NSArray *)obj objectAtIndex:0];
	
	if ([[talk objectForKey:@"talk_title"] isKindOfClass:[NSString class]]) {
		tdm.title         = [talk objectForKey:@"talk_title"];
	} else {
		tdm.title         = @"";
	}
	
	if ([[talk objectForKey:@"speaker"] isKindOfClass:[NSString class]]) {
		tdm.speaker       = [talk objectForKey:@"speaker"];
	} else {
		tdm.speaker       = @"";
	}
	
	if ([[talk objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
		tdm.Id            = [[talk objectForKey:@"ID"] integerValue];
	} else {
		tdm.Id            = 0;
	}
	
	if ([[talk objectForKey:@"event_id"] isKindOfClass:[NSString class]]) {
		tdm.eventId       = [[talk objectForKey:@"event_id"] integerValue];
	} else {
		tdm.eventId       = 0;
	}
	
	if ([[talk objectForKey:@"slides_link"] isKindOfClass:[NSString class]]) {
		tdm.slidesLink    = [talk objectForKey:@"slides_link"];
	} else {
		tdm.slidesLink    = @"";
	}
	
	if ([[talk objectForKey:@"date_given"] isKindOfClass:[NSString class]]) {
		tdm.given         = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"date_given"]   integerValue]];
	} else {
		tdm.given         = 0;
	}
	
	if ([[talk objectForKey:@"talk_desc"] isKindOfClass:[NSString class]]) {
		tdm.desc          = [talk objectForKey:@"talk_desc"];
	} else {
		tdm.desc          = @"";
	}
	
	if ([[talk objectForKey:@"lang_name"] isKindOfClass:[NSString class]]) {
		tdm.langName      = [talk objectForKey:@"lang_name"];
	} else {
		tdm.langName      = @"";
	}
	
	if ([[talk objectForKey:@"lang"] isKindOfClass:[NSString class]]) {
		tdm.lang          = [[talk objectForKey:@"lang"] integerValue];
	} else {
		tdm.lang          = 0;
	}
	
	if ([[talk objectForKey:@"tavg"] isKindOfClass:[NSString class]]) {
		tdm.rating        = [[talk objectForKey:@"tavg"] integerValue];
	} else {
		tdm.rating        = 0;
	}
	
	if ([[talk objectForKey:@"tcid"] isKindOfClass:[NSString class]]) {
		tdm.type          = [talk objectForKey:@"tcid"];
	} else {
		tdm.type          = @"";
	}
	
	if ([[talk objectForKey:@"active"] isKindOfClass:[NSString class]]) {
		tdm.active        = ([[[talk objectForKey:@"active"] lowercaseString] compare:@"y"] == NSOrderedSame);
	} else {
		tdm.active        = NO;
	}
	
	if ([[talk objectForKey:@"owner_id"] isKindOfClass:[NSString class]]) {
		tdm.speakerId     = [[talk objectForKey:@"owner_id"] integerValue];
	} else {
		tdm.speakerId     = 0;
	}
	
	if ([[talk objectForKey:@"private"] isKindOfClass:[NSString class]]) {
		tdm.private       = ([[[talk objectForKey:@"private"] lowercaseString] compare:@"y"] == NSOrderedSame);
	} else {
		tdm.private       = NO;
	}
	
	if ([[talk objectForKey:@"lang_abbr"] isKindOfClass:[NSString class]]) {
		tdm.langAbbr      = [talk objectForKey:@"lang_abbr"];
	} else {
		tdm.langAbbr      = @"";
	}
	
	if ([[talk objectForKey:@"ccount"] isKindOfClass:[NSString class]]) {
		tdm.numComments   = [[talk objectForKey:@"ccount"] integerValue];
	} else {
		tdm.numComments   = 0;
	}
	
	if ([[talk objectForKey:@"last_comment_date"] isKindOfClass:[NSString class]]) {
		tdm.lastComment   = [NSDate dateWithTimeIntervalSince1970:[[talk objectForKey:@"last_comment_date"]   integerValue]];
	} else {
		tdm.lastComment   = 0;
	}
	
	if ([[talk objectForKey:@"allow_comments"] isKindOfClass:[NSString class]]) {
		if ([[[talk objectForKey:@"allow_comments"] lowercaseString] isEqualToString:@"y"] || [[[talk objectForKey:@"allow_comments"] lowercaseString] isEqualToString:@"1"]) {
			tdm.allowComments = YES;
		} else {
			tdm.allowComments = NO;
		}
	} else {
		tdm.allowComments = NO;
	}
	
	[self.delegate gotTalkDetailData:tdm error:nil];
	[tdm release];

}

- (void)gotError:(NSObject *)error {
	
}

@end

@implementation APICaller (APICaller_TalkGetDetail)
+ (TalkGetDetail *)TalkGetDetail:(id)_delegate {
	static TalkGetDetail *t = nil;
	if (t != nil) {
		[t cancel];
		[t release];
	}	
	t = [[TalkGetDetail alloc] initWithDelegate:_delegate];
	return t;
}
@end

