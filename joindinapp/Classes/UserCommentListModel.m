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

#import "UserCommentListModel.h"


@implementation UserCommentListModel

@synthesize comments;

- (UserCommentListModel *)init {
	self.comments = [NSMutableArray array];
	return self;
}

- (void)addComment:(UserCommentDetailModel *)ucdm {
	[ucdm retain];
	[self.comments addObject:ucdm];
}

- (UserCommentDetailModel *)getUserCommentAtIndex:(NSUInteger)idx {
	return [self.comments objectAtIndex:idx];
}

- (NSUInteger)getNumComments {
	return [self.comments count];
}

- (UserTalkCommentDetailModel *)getCommentForTalk:(TalkDetailModel *)talk {
	for (id c in self.comments) {
		if ([c class] == [UserTalkCommentDetailModel class]) {
//			UserTalkCommentDetailModel *d = (UserTalkCommentDetailModel *)c;
//			if (d.talkId == talk.Id) {
//				return d;
//			}
		}
	}
	return nil;
}

- (UserEventCommentDetailModel *)getCommentForEvent:(EventDetailModel *)event {
	for (id c in self.comments) {
		if ([c class] == [UserEventCommentDetailModel class]) {
//			UserEventCommentDetailModel *d = (UserEventCommentDetailModel *)c;
// TODO
//			if (d.eventId == event.Id) {
//				return d;
//			}
		}
	}
	return nil;
}

@end
