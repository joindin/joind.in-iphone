//
//  UserGetDetail.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "UserDetailModel.h"

@interface UserGetDetail : APICaller {

}

- (void)call:(NSString *)user;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(APIError *)error;

@end

@interface APICaller (APICaller_UserGetDetail)
+ (UserGetDetail *)UserGetDetail:(id)_delegate;
@end

@protocol UserGetDetailResponse
- (void)gotUserGetDetailData:(UserDetailModel *)success error:(APIError *)err;
@end
