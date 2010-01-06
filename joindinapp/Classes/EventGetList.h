//
//  EventGetList.h
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "APICaller.h"
#import "EventListModel.h"

@interface EventGetList : APICaller {

}

- (void)call:(NSString *)eventType;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_EventGetList)
+ (EventGetList *)EventGetList:(id)_delegate;
@end

@protocol EventGetListResponse
- (void)gotEventListData:(EventListModel *)elm;
@end

