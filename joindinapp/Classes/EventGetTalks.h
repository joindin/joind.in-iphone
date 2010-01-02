//
//  EventGetTalks.h
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "APICaller.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"

@interface EventGetTalks : APICaller {
}

- (void)call:(EventDetailModel *)event;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_EventGetTalks)
+ (EventGetTalks *)EventGetTalks:(id)_delegate;
@end

@protocol EventGetTalksResponse
- (void)gotTalksForEvent:(TalkListModel *)tlm;
@end
