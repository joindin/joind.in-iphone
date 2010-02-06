//
//  UserGetDetail.m
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserGetDetail.h"


@implementation UserGetDetail

- (void)call:(NSString *)user {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
	[params setValue:user forKey:@"uid"];
	[self callAPI:@"user" action:@"getdetail" params:params needAuth:YES canCache:NO];
}

- (void)gotData:(NSObject *)obj {
	
	UserDetailModel *udm = [[[UserDetailModel alloc] init] autorelease];

	NSDictionary *response = (NSDictionary *)obj;
	
	if ([[response objectForKey:@"username"] isKindOfClass:[NSString class]]) {
		udm.username = [response objectForKey:@"username"];
	} else {
		udm.username = @"";
	}
	
	if ([[response objectForKey:@"last_login"] isKindOfClass:[NSString class]]) {
		udm.lastLogin = [NSDate dateWithTimeIntervalSince1970:[[response objectForKey:@"last_login"] integerValue]];
	} else {
		udm.lastLogin = nil;
	}
	
	if ([[response objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
		udm.uid = [[response objectForKey:@"ID"] integerValue];
	} else {
		udm.uid = 0;
	}
	
	if ([[response objectForKey:@"full_name"] isKindOfClass:[NSString class]]) {
		udm.fullName = [response objectForKey:@"full_name"];
	} else {
		udm.fullName = @"";
	}
	
	[self.delegate gotUserGetDetailData:udm error:nil];
	
}

- (void)gotError:(APIError *)error {
	[self.delegate gotUserGetDetailData:nil error:error];
}

@end

@implementation APICaller (APICaller_UserGetDetail)
+ (UserGetDetail *)UserGetDetail:(id)_delegate {
	static UserGetDetail *u = nil;
	if (u != nil) {
		[u cancel];
		[u release];
	}	
	u = [[UserGetDetail alloc] initWithDelegate:_delegate];
	return u;
}
@end
