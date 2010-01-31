//
//  EventAddComment.h
//  joindinapp
//
//  Created by Kevin on 29/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "EventDetailModel.h"


@interface EventAddComment : APICaller {

}

- (void)call:(EventDetailModel *)talk comment:(NSString *)comment;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(APIError *)error;

@end

@interface APICaller (APICaller_EventAddComment)
+ (EventAddComment *)EventAddComment:(id)_delegate;
@end

@protocol EventAddCommentResponse
- (void)gotAddedEventComment:(APIError *)err;
@end
