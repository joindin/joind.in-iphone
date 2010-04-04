//
//  EventDetailModel.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TracksListModel.h"

@interface EventDetailModel : NSObject {
	NSString   *name;
	NSDate     *start;
	NSDate     *end;
	NSUInteger  Id;
	NSString   *location;
	NSString   *description;
	BOOL        active;
	NSString   *stub;
	NSString   *tzCont;
	NSString   *tzPlace;
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
	BOOL        allowComments;
	TracksListModel *tracks;
	float       event_lat;
	float       event_long;

	// Auth'd user details
	BOOL        isAuthd;
	BOOL        userAttend;

}
@property (nonatomic, retain) NSString   *name;
@property (nonatomic, retain) NSDate     *start;
@property (nonatomic, retain) NSDate     *end;
@property (nonatomic, assign) NSUInteger  Id;
@property (nonatomic, retain) NSString   *location;
@property (nonatomic, retain) NSString   *description;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, retain) NSString   *stub;
@property (nonatomic, retain) NSString   *tzCont;
@property (nonatomic, retain) NSString   *tzPlace;
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
@property (nonatomic, assign) BOOL        allowComments;
@property (nonatomic, assign) BOOL        isAuthd;
@property (nonatomic, assign) BOOL        userAttend;
@property (nonatomic, assign) float       event_lat;
@property (nonatomic, assign) float       event_long;
@property (nonatomic, retain) TracksListModel    *tracks;

-(id)init;
-(BOOL)isNowOn;
-(BOOL)hasFinished;
-(BOOL)hasStarted;
-(NSComparisonResult)comparator:(EventDetailModel *)otherModel;
-(BOOL)hasTracks;

@end
