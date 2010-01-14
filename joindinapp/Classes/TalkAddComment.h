//
//  TalkAddComment.h
//  joindinapp
//
//  Created by Kevin on 14/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "TalkDetailModel.h"

@interface TalkAddComment : APICaller {

}

- (void)call:(TalkDetailModel *)talk rating:(NSUInteger)rating comment:(NSString *)comment private:(BOOL)priv;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(APIError *)error;

@end

@interface APICaller (APICaller_TalkAddComment)
+ (TalkAddComment *)TalkAddComment:(id)_delegate;
@end

@protocol TalkAddCommentResponse
- (void)gotAddedTalkComment:(APIError *)err;
@end
