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

#import "UserValidate.h"
#import "NSString+md5.h"


@implementation UserValidate

- (void)call:(NSString *)user password:(NSString *)pass {
	// Get OAuth details from application settings
	NSString *oauthClientID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"joindInOAuthClientID"];
	NSString *oauthClientSecret = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"joindInOAuthClientSecret"];

	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
	[params setValue:user       forKey:@"username"];
	[params setValue:pass       forKey:@"password"];
	[params setValue:@"password" forKey:@"grant_type"];
	[params setValue:oauthClientID forKey:@"client_id"];
	[params setValue:oauthClientSecret forKey:@"client_secret"];
	[self callAPI:@"token" method:@"POST" params:params needAuth:NO canCache:NO];
}

- (void)gotData:(NSObject *)obj {
	// Successful response (ie non-400/500 error)
	NSDictionary *response = (NSDictionary *)obj;
	[self.delegate gotUserValidateData:YES error:nil data:response];
}

- (void)gotError:(NSObject *)error {
	// Error response
	[self.delegate gotUserValidateData:NO error:nil data:nil];
}

@end

@implementation APICaller (APICaller_UserValidate)
+ (UserValidate *)UserValidate:(id)_delegate {
	static UserValidate *u = nil;
	if (u != nil) {
		[u cancel];
	}	
	u = [[UserValidate alloc] initWithDelegate:_delegate];
	return u;
}
@end
