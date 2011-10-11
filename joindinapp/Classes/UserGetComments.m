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
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *d = (NSDictionary *)obj;
        for (NSObject *commentObj in d) {
            if ([commentObj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *comment = (NSDictionary *)commentObj;
                
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
