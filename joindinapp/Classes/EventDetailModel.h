//
//  EventDetailModel.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventDetailModel : NSObject {
	NSString   *name;
	NSDate     *start;
	NSDate     *end;
	NSUInteger  Id;
	NSString   *location;
	NSString   *description;
	BOOL        active;
	NSString   *stub;
	NSInteger   tzOffset;
	NSString   *icon;
	BOOL        pending;
	NSString   *hashtag;
	NSString   *url;
	NSDate     *cfpStart;
	NSDate     *cfpEnd;
	BOOL        voting;
	BOOL        private;
	NSUInteger  numAttend;
	NSUInteger  numComments;
	
	// Auth'd user details
	BOOL        isAuthd;
	BOOL        userAttend;

	/*
	 event_lat: For future use 
	 event_long: For future use 
	 */
	
}
@property (nonatomic, retain) NSString   *name;
@property (nonatomic, retain) NSDate     *start;
@property (nonatomic, retain) NSDate     *end;
@property (nonatomic, assign) NSUInteger  Id;
@property (nonatomic, retain) NSString   *location;
@property (nonatomic, retain) NSString   *description;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, retain) NSString   *stub;
@property (nonatomic, assign) NSInteger   tzOffset;
@property (nonatomic, retain) NSString   *icon;
@property (nonatomic, assign) BOOL        pending;
@property (nonatomic, retain) NSString   *hashtag;
@property (nonatomic, retain) NSString   *url;
@property (nonatomic, retain) NSDate     *cfpStart;
@property (nonatomic, retain) NSDate     *cfpEnd;
@property (nonatomic, assign) BOOL        voting;
@property (nonatomic, assign) BOOL        private;
@property (nonatomic, assign) NSUInteger  numAttend;
@property (nonatomic, assign) NSUInteger  numComments;
@property (nonatomic, assign) BOOL        isAuthd;
@property (nonatomic, assign) BOOL        userAttend;

@end
