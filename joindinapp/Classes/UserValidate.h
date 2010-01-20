//
//  UserValidate.h
//  joindinapp
//
//  Created by Kevin on 17/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICaller.h"


@interface UserValidate : APICaller {

}
- (void)call:(NSString *)user password:(NSString *)pass;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_UserValidate)
+ (UserValidate *)UserValidate:(id)_delegate;
@end

@protocol UserValidateResponse
- (void)gotUserValidateData:(BOOL)success error:(APIError *)err;
@end
