//
//  TalkGetComments.h
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "TalkDetailModel.h"
#import "TalkCommentListModel.h"


@interface TalkGetComments : APICaller {

}

- (void)call:(TalkDetailModel *)talk;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_TalkGetComments)
+ (TalkGetComments *)TalkGetComments:(id)_delegate;
@end

@protocol TalkGetCommentsResponse
- (void)gotTalkComments:(TalkCommentListModel *)tclm error:(APIError *)err;
@end
