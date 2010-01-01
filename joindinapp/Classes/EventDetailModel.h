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
	NSUInteger  active;
	NSString   *stub;
	NSUInteger  tzOffset;
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
@property (nonatomic, assign) NSUInteger  active;
@property (nonatomic, retain) NSString   *stub;
@property (nonatomic, assign) NSUInteger  tzOffset;

@end
