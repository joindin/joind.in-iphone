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

- (void)call:(NSString *)userURI {
    [self callAPI:userURI needAuth:NO canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	
	UserDetailModel *udm = [[[UserDetailModel alloc] init] autorelease];

    NSDictionary *user = [(NSArray *)[(NSDictionary *)obj objectForKey:@"users"] objectAtIndex:0];
    if ([[user objectForKey:@"username"] isKindOfClass:[NSString class]]) {
        udm.username = [user objectForKey:@"username"];
    } else {
        udm.username = @"";
    }

    if ([[user objectForKey:@"full_name"] isKindOfClass:[NSString class]]) {
        udm.fullName = [user objectForKey:@"full_name"];
    } else {
        udm.fullName = @"";
    }

    if ([[user objectForKey:@"twitter_username"] isKindOfClass:[NSString class]]) {
        udm.twitterUsername = [user objectForKey:@"twitter_username"];
    } else {
        udm.twitterUsername = @"";
    }

    if ([[user objectForKey:@"gravatar_hash"] isKindOfClass:[NSString class]]) {
        udm.gravatarHash = [user objectForKey:@"gravatar_hash"];
    } else {
        udm.gravatarHash = @"";
    }

    if ([[user objectForKey:@"uri"] isKindOfClass:[NSString class]]) {
        udm.uri = [user objectForKey:@"uri"];
    } else {
        udm.uri = @"";
    }

    if ([[user objectForKey:@"verbose_uri"] isKindOfClass:[NSString class]]) {
        udm.verboseURI = [user objectForKey:@"verbose_uri"];
    } else {
        udm.verboseURI = @"";
    }

    if ([[user objectForKey:@"website_uri"] isKindOfClass:[NSString class]]) {
        udm.websiteURI = [user objectForKey:@"website_uri"];
    } else {
        udm.websiteURI = @"";
    }

    if ([[user objectForKey:@"talks_uri"] isKindOfClass:[NSString class]]) {
        udm.talksURI = [user objectForKey:@"talks_uri"];
    } else {
        udm.talksURI = @"";
    }

    if ([[user objectForKey:@"attended_events_uri"] isKindOfClass:[NSString class]]) {
        udm.attendedEventsURI = [user objectForKey:@"attended_events_uri"];
    } else {
        udm.attendedEventsURI = @"";
    }

    if ([[user objectForKey:@"hosted_events_uri"] isKindOfClass:[NSString class]]) {
        udm.hostedEventsURI = [user objectForKey:@"hosted_events_uri"];
    } else {
        udm.hostedEventsURI = @"";
    }

    if ([[user objectForKey:@"talk_comments_uri"] isKindOfClass:[NSString class]]) {
        udm.talkCommentsURI = [user objectForKey:@"talk_comments_uri"];
    } else {
        udm.talkCommentsURI = @"";
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
