//
//  EventGetEventList.h
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "APICaller.h"
#import "EventListModel.h"

@interface EventGetEventList : APICaller {

}

- (void)call:(NSString *)eventType;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_EventGetEventList)
+ (EventGetEventList *)EventGetEventList:(id)_delegate;
@end

@protocol EventGetEventListResponse
- (void)gotEventListData:(EventListModel *)elm;
@end

