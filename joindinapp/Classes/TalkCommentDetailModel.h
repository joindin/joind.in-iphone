//
//  TalkCommentDetailModel.h
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
