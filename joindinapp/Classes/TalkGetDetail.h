//
//  TalkGetDetail.h
//  joindinapp
//
//  Created by Kevin on 16/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "TalkDetailModel.h"


@interface TalkGetDetail : APICaller {

}

- (void)call:(TalkDetailModel *)talk;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_TalkGetDetail)
+ (TalkGetDetail *)TalkGetDetail:(id)_delegate;
@end

@protocol TalkGetDetailResponse
- (void)gotTalkDetailData:(TalkDetailModel *)tdm error:(APIError *)err;
@end
