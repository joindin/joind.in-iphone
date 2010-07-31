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

#import "TalkAddComment.h"
#import "TalkDetailModel.h"


@implementation TalkAddComment

- (void)call:(TalkDetailModel *)talk rating:(NSUInteger)rating comment:(NSString *)comment private:(BOOL)priv {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
	[params setObject:[NSString stringWithFormat:@"%d", talk.Id] forKey:@"talk_id"];
	[params setObject:[NSString stringWithFormat:@"%d", rating ] forKey:@"rating"];
	[params setObject:comment forKey:@"comment"];
	[params setObject:[NSString stringWithFormat:@"%d", priv   ] forKey:@"private"];
	[self callAPI:@"talk" action:@"addcomment" params:params needAuth:YES canCache:NO];
}

- (void)gotData:(NSObject *)obj {
	id _msg = [((NSDictionary *)obj) objectForKey:@"msg"];
	
	if ([_msg isKindOfClass:[NSString class]] && [_msg isEqualToString:@"Comment added!"]) {
		[self.delegate gotAddedTalkComment:nil];
	} else {
		// Detect if obj.msg is an array, and if so then collapse it
		NSMutableString *msg = [NSMutableString stringWithCapacity:0];
		if ([_msg isKindOfClass:[NSArray class]]) {
			for(NSString *msgs in _msg) {
				if ([msg length] > 1) {
					[msg appendString:@", "];
				}
				[msg appendString:msgs];
			}
		} else {
			[msg appendString:_msg];
		}
		[self gotError:[APIError APIErrorWithMsg:msg type:ERR_UNKNOWN]];
	}
}

- (void)gotError:(APIError *)error {
	[self.delegate gotAddedTalkComment:error];
}

@end

@implementation APICaller (APICaller_TalkAddComment)
+ (TalkAddComment *)TalkAddComment:(id)_delegate {
	static TalkAddComment *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[TalkAddComment alloc] initWithDelegate:_delegate];
	return e;
}
@end
