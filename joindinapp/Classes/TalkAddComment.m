//
//  TalkAddComment.m
//  joindinapp
//
//  Created by Kevin on 14/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TalkAddComment.h"


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
	[self.delegate gotAddedTalkComment:nil];
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
