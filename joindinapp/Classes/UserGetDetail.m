//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
