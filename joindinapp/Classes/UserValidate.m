//
//  UserValidate.m
//  joindinapp
//
//  Created by Kevin on 17/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserValidate.h"
#import "NSString+md5.h"


@implementation UserValidate

- (void)call:(NSString *)user password:(NSString *)pass {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
	[params setValue:user       forKey:@"uid"];
	[params setValue:[pass md5] forKey:@"pass"];
	[self callAPI:@"user" action:@"validate" params:params needAuth:NO canCache:NO];
}

- (void)gotData:(NSObject *)obj {
	NSDictionary *response = (NSDictionary *)obj;
	if ([[response objectForKey:@"msg"] isEqualToString:@"success"]) {
		[self.delegate gotUserValidateData:YES error:nil];
	} else {
		[self.delegate gotUserValidateData:NO error:nil];
	}
}

- (void)gotError:(NSObject *)error {
	//[self.delegate gotUserValidateData:nil error:error];
}

@end

@implementation APICaller (APICaller_UserValidate)
+ (UserValidate *)UserValidate:(id)_delegate {
	static UserValidate *u = nil;
	if (u != nil) {
		[u cancel];
		[u release];
	}	
	u = [[UserValidate alloc] initWithDelegate:_delegate];
	return u;
}
@end
