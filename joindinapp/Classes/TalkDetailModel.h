//
//  TalkDetailModel.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TalkDetailModel : NSObject {
	NSString   *title;      // talk_title
	NSString   *speaker;    // speaker
	NSUInteger  Id;         // tid
	NSUInteger  eventId;    // eid
	NSString   *slidesLink; // slides_link
	NSDate     *given;      // date_given
	NSString   *desc;       // talk_desc
	NSString   *langName;   // lang_name
	NSUInteger  lang;       // lang
	NSUInteger  rating;     // tavg
	NSString   *type;       // tcid
}

@property (nonatomic, retain) NSString   *title;
@property (nonatomic, retain) NSString   *speaker;
@property (nonatomic, assign) NSUInteger  Id;
@property (nonatomic, assign) NSUInteger  eventId;
@property (nonatomic, retain) NSString   *slidesLink;
@property (nonatomic, retain) NSDate     *given;
@property (nonatomic, retain) NSString   *desc;
@property (nonatomic, retain) NSString   *langName;
@property (nonatomic, assign) NSUInteger  lang;
@property (nonatomic, assign) NSUInteger  rating;
@property (nonatomic, retain) NSString   *type;

@end
