//
//  EventGetComments.h
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "EventDetailModel.h"
#import "EventCommentListModel.h"


@interface EventGetComments : APICaller {

}

- (void)call:(EventDetailModel *)talk;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_EventGetComments)
+ (EventGetComments *)EventGetComments:(id)_delegate;
@end

@protocol EventGetCommentsResponse
- (void)gotEventComments:(EventCommentListModel *)eclm error:(APIError *)err;
@end

