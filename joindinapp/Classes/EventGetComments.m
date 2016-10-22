//
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

#import "EventGetComments.h"


@implementation EventGetComments

- (void)call:(EventDetailModel *)event {
    [self callAPI:event.commentsURI params:[NSDictionary dictionaryWithObject:[[NSNumber alloc] initWithInt:200] forKey:@"resultsperpage"] needAuth:NO canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	EventCommentListModel *eclm = [[EventCommentListModel alloc] init];
	
	NSDictionary *d = [(NSDictionary *)obj objectForKey:@"comments"];
	for (NSDictionary *comment in d) {
		EventCommentDetailModel *ecdm = [[EventCommentDetailModel alloc] init];
		
		if ([[comment objectForKey:@"comment"] isKindOfClass:[NSString class]]) {
			ecdm.comment = [comment objectForKey:@"comment"];
		} else {
			ecdm.comment = @"";
		}
		
		if ([[comment objectForKey:@"created_date"] isKindOfClass:[NSString class]]) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
			ecdm.createdDate = [dateFormatter dateFromString:[comment objectForKey:@"created_date"]];
		} else {
			ecdm.createdDate = nil;
		}
		
		if ([[comment objectForKey:@"user_display_name"] isKindOfClass:[NSString class]]) {
			ecdm.userDisplayName = [comment objectForKey:@"user_display_name"];
		} else {
			ecdm.userDisplayName = @"ANONYMOUS";
		}
		
		if ([[comment objectForKey:@"gravatar_hash"] isKindOfClass:[NSString class]]) {
			ecdm.gravatarHash = [comment objectForKey:@"gravatar_hash"];
		} else {
			ecdm.gravatarHash = @"";
		}

		if ([[comment objectForKey:@"user_uri"] isKindOfClass:[NSString class]]) {
			ecdm.userURI = [comment objectForKey:@"user_uri"];
		} else {
			ecdm.userURI = @"";
		}

		if ([[comment objectForKey:@"comment_uri"] isKindOfClass:[NSString class]]) {
			ecdm.commentURI = [comment objectForKey:@"comment_uri"];
		} else {
			ecdm.commentURI = @"";
		}

		[eclm addComment:ecdm];

		
	}
	[self.delegate gotEventComments:eclm error:nil];
	
}

- (void)gotError:(NSObject *)error {
	NSLog(@"Got event comments error %@", error);
}

@end

@implementation APICaller (APICaller_EventGetComments)
+ (EventGetComments *)EventGetComments:(id)_delegate {
	static EventGetComments *e = nil;
	if (e != nil) {
		[e cancel];
	}
	e = [[EventGetComments alloc] initWithDelegate:_delegate];
	return e;
}
@end
