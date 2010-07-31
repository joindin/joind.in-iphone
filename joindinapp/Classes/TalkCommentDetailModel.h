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

#import <Foundation/Foundation.h>


@interface TalkCommentDetailModel : NSObject {

	/*
	 talk_id: integer, ID number of the talk comment is on 
	 comment: string, Comments from the user 
	 date_made: integer, Unix timestamp of when comment was posted 
	 ID: integer, ID number of the comment 
	 private: integer, If the comment is marked private or not 
	 active: integer, If the comment is marked as active or not 
	 user_id: integer, If a registered user made the comment, a non-zero value is here 
	 uname: string, If a registered user made the comment, their username is here
	 */
	
	NSUInteger  talkId;
	NSUInteger  rating;
	NSString   *comment;
	NSString   *type;
	NSDate     *made;
	NSUInteger  Id;
	BOOL        private;
	BOOL        active;
	NSUInteger  userId;
	NSString   *username;
	
}

@property (nonatomic, assign) NSUInteger  talkId;
@property (nonatomic, assign) NSUInteger  rating;
@property (nonatomic, retain) NSString   *comment;
@property (nonatomic, retain) NSString   *type;
@property (nonatomic, retain) NSDate     *made;
@property (nonatomic, assign) NSUInteger  Id;
@property (nonatomic, assign) BOOL        private;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, assign) NSUInteger  userId;
@property (nonatomic, retain) NSString   *username;

@end
