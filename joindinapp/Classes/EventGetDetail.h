//
//  EventGetDetail.h
//  joindinapp
//
//  Created by Kevin on 30/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "EventDetailModel.h"
#import "TracksListModel.h"

@interface EventGetDetail : APICaller {

}

- (void)call:(NSUInteger)eventId;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_EventGetDetail)
+ (EventGetDetail *)EventGetDetail:(id)_delegate;
@end

@protocol EventGetDetailResponse
- (void)gotEventDetailData:(EventDetailModel *)edm error:(APIError *)err;
@end
