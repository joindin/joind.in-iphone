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

#import "TalkGetComments.h"


@implementation TalkGetComments

- (void)call:(TalkDetailModel *)talk {
    [self callAPI:talk.commentsURI needAuth:YES canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	TalkCommentListModel *tclm = [[[TalkCommentListModel alloc] init] autorelease];
	
	NSDictionary *d = [(NSDictionary *)obj objectForKey:@"comments"];
	for (NSDictionary *comment in d) {
		TalkCommentDetailModel *tcdm = [[TalkCommentDetailModel alloc] init];
		
		if ([[comment objectForKey:@"comment"] isKindOfClass:[NSString class]]) {
			tcdm.comment = [comment objectForKey:@"comment"];
		} else {
			tcdm.comment = @"";
		}
		
		if ([[comment objectForKey:@"created_date"] isKindOfClass:[NSString class]]) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
			tcdm.createdDate = [dateFormatter dateFromString:[comment objectForKey:@"created_date"]];
		} else {
			tcdm.createdDate = nil;
		}
		
		if ([[comment objectForKey:@"rating"] isKindOfClass:[NSNumber class]]) {
			tcdm.rating = [[comment objectForKey:@"rating"] integerValue];
		} else {
			tcdm.rating = 0;
		}
		
		if ([[comment objectForKey:@"user_display_name"] isKindOfClass:[NSString class]]) {
			tcdm.userDisplayName = [comment objectForKey:@"user_display_name"];
		} else {
			tcdm.userDisplayName = @"ANONYMOUS";
		}
		
		if ([[comment objectForKey:@"user_uri"] isKindOfClass:[NSString class]]) {
			tcdm.userURI = [[comment objectForKey:@"user_uri"] integerValue];
		} else {
			tcdm.userURI = 0;
		}
		
		
		//if (tdm.active && !tdm.private) {
		[tclm addComment:tcdm];
		//}
		[tcdm release];
		
	}
	[self.delegate gotTalkComments:tclm error:nil];
		
}

- (void)gotError:(NSObject *)error {
	NSLog(@"Got talk comments error %@", error);
}

@end

@implementation APICaller (APICaller_TalkGetComments)
+ (TalkGetComments *)TalkGetComments:(id)_delegate {
	static TalkGetComments *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[TalkGetComments alloc] initWithDelegate:_delegate];
	return e;
}
@end
