//
//  UserGetComments.m
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserGetComments.h"
#import "UserDetailModel.h"
#import "UserCommentListModel.h"
#import "UserCommentDetailModel.h"
#import "UserTalkCommentDetailModel.h"
#import "UserEventCommentDetailModel.h"

@implementation UserGetComments

- (void)call:(UserDetailModel *)user {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:4];
	if (user == nil) {
		NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
		NSString *username = [userPrefs stringForKey:@"username"];
		if (username == nil) {
			[params setObject:@"" forKey:@"username"];
		} else {
			[params setObject:username forKey:@"username"];
		}
	} else {
		[params setObject:user.username forKey:@"username"];
	}
	//[params setObject:@"talk"       forKey:@"type"];
	[self callAPI:@"user" action:@"getcomments" params:params needAuth:YES canCache:YES];
}

- (void)gotData:(NSObject *)obj {
	UserCommentListModel *uclm = [[[UserCommentListModel alloc] init] autorelease];
	
	NSDictionary *d = (NSDictionary *)obj;
	for (NSDictionary *comment in d) {
		
		if ([comment objectForKey:@"talk_id"] != nil) {
			
			UserTalkCommentDetailModel *ucdm;
			ucdm = [[UserTalkCommentDetailModel alloc] init];
			
			if ([[comment objectForKey:@"talk_id"] isKindOfClass:[NSString class]]) {
				ucdm.talkId = [[comment objectForKey:@"talk_id"] integerValue];
			} else {
				ucdm.talkId = 0;
			}
			
			if ([[comment objectForKey:@"rating"] isKindOfClass:[NSString class]]) {
				ucdm.rating = [[comment objectForKey:@"rating"] integerValue];
			} else {
				ucdm.rating = 0;
			}
			
			if ([[comment objectForKey:@"comment_type"] isKindOfClass:[NSString class]]) {
				ucdm.type = [comment objectForKey:@"comment_type"];
			} else {
				ucdm.type = @"comment";
			}
			
			////
			
			if ([[comment objectForKey:@"comment"] isKindOfClass:[NSString class]]) {
				ucdm.comment = [comment objectForKey:@"comment"];
			} else {
				ucdm.comment = @"";
			}
			
			if ([[comment objectForKey:@"date_made"] isKindOfClass:[NSString class]]) {
				ucdm.made = [NSDate dateWithTimeIntervalSince1970:[[comment objectForKey:@"date_made"] integerValue]];
			} else {
				ucdm.made = nil;
			}
			
			if ([[comment objectForKey:@"user_id"] isKindOfClass:[NSString class]]) {
				ucdm.uid = [[comment objectForKey:@"user_id"] integerValue];
			} else {
				ucdm.uid = 0;
			}
			
			if ([[comment objectForKey:@"active"] isKindOfClass:[NSString class]]) {
				ucdm.active = [[[comment objectForKey:@"active"] lowercaseString] isEqualToString:@"y"];
			} else if ([[comment objectForKey:@"active"] isKindOfClass:[NSNumber class]]) {
				ucdm.active = ([[comment objectForKey:@"active"] boolValue]);
			} else {
				NSLog(@"Can't recognise type %@", [[comment objectForKey:@"active"] class]);
			}		
			
			if ([[comment objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
				ucdm.id = [[comment objectForKey:@"ID"] integerValue];
			} else {
				ucdm.id = 0;
			}
			
			[uclm addComment:ucdm];
			[ucdm release];
			
		} else if ([comment objectForKey:@"event_id"] != nil) {
			
			UserEventCommentDetailModel *ucdm;
			ucdm = [[UserEventCommentDetailModel alloc] init];
			
			if ([[comment objectForKey:@"event_id"] isKindOfClass:[NSString class]]) {
				ucdm.eventId = [[comment objectForKey:@"event_id"] integerValue];
			} else {
				ucdm.eventId = 0;
			}
			
			if ([[comment objectForKey:@"cname"] isKindOfClass:[NSString class]]) {
				ucdm.commentorName = [comment objectForKey:@"cname"];
			} else {
				ucdm.commentorName = @"Anonymous";
			}
			
			/////
			
			if ([[comment objectForKey:@"comment"] isKindOfClass:[NSString class]]) {
				ucdm.comment = [comment objectForKey:@"comment"];
			} else {
				ucdm.comment = @"";
			}
			
			if ([[comment objectForKey:@"date_made"] isKindOfClass:[NSString class]]) {
				ucdm.made = [NSDate dateWithTimeIntervalSince1970:[[comment objectForKey:@"date_made"] integerValue]];
			} else {
				ucdm.made = nil;
			}
			
			if ([[comment objectForKey:@"user_id"] isKindOfClass:[NSString class]]) {
				ucdm.uid = [[comment objectForKey:@"user_id"] integerValue];
			} else {
				ucdm.uid = 0;
			}
			
			if ([[comment objectForKey:@"active"] isKindOfClass:[NSString class]]) {
				ucdm.active = [[[comment objectForKey:@"active"] lowercaseString] isEqualToString:@"y"];
			} else if ([[comment objectForKey:@"active"] isKindOfClass:[NSNumber class]]) {
				ucdm.active = ([[comment objectForKey:@"active"] boolValue]);
			} else {
				NSLog(@"Can't recognise type %@", [[comment objectForKey:@"active"] class]);
			}		
			
			if ([[comment objectForKey:@"ID"] isKindOfClass:[NSString class]]) {
				ucdm.id = [[comment objectForKey:@"ID"] integerValue];
			} else {
				ucdm.id = 0;
			}
			
			[uclm addComment:ucdm];
			[ucdm release];
			
		} else {
			
			continue;
			
		}
		
	}
	[self.delegate gotUserComments:uclm error:nil];
	
}

- (void)gotError:(APIError *)error {
	[self.delegate gotUserComments:nil error:error];
}

@end

@implementation APICaller (APICaller_UserGetComments)
+ (UserGetComments *)UserGetComments:(id)_delegate {
	static UserGetComments *e = nil;
	if (e != nil) {
		[e cancel];
		[e release];
	}
	e = [[UserGetComments alloc] initWithDelegate:_delegate];
	return e;
}

@end
