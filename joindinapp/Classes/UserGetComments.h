//
//  UserGetComments.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"
#import "UserDetailModel.h"
#import "UserCommentListModel.h"

@interface UserGetComments : APICaller {

}

- (void)call:(UserDetailModel *)talk;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(APIError *)error;

@end

@interface APICaller (APICaller_UserGetComments)
+ (UserGetComments *)UserGetComments:(id)_delegate;
@end

@protocol UserGetCommentsResponse
- (void)gotUserComments:(UserCommentListModel *)uclm error:(APIError *)err;
@end
