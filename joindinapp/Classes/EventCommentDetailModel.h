//
//  EventCommentDetailModel.h
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventCommentDetailModel : NSObject {
	NSUInteger  eventId;
	NSString   *comment;
	NSDate     *made;
	NSUInteger  Id;
	BOOL        private;
	BOOL        active;
	NSUInteger  userId;
	NSString   *username;
}

@property (nonatomic, assign) NSUInteger  eventId;
@property (nonatomic, retain) NSString   *comment;
@property (nonatomic, retain) NSDate     *made;
@property (nonatomic, assign) NSUInteger  Id;
@property (nonatomic, assign) BOOL        private;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, assign) NSUInteger  userId;
@property (nonatomic, retain) NSString   *username;

@end
