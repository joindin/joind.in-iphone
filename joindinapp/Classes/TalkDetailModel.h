//
//  TalkDetailModel.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDetailModel.h"
#import "TracksListModel.h"

@interface TalkDetailModel : NSObject {
	NSString   *title;      // talk_title
	NSString   *speaker;    // speaker
	NSUInteger  Id;         // tid or ID
	NSUInteger  eventId;    // eid or event_id
	NSString   *slidesLink; // slides_link
	NSDate     *given;      // date_given
	NSString   *desc;       // talk_desc
	NSString   *langName;   // lang_name
	NSUInteger  lang;       // lang
	NSUInteger  rating;     // rank
	NSString   *type;       // tcid
	
	BOOL        active;     // active
	NSUInteger  speakerId;  // owner_id
	BOOL        private;    // private
	NSString   *langAbbr;   // lang_abbr
	NSUInteger  numComments;// ccount or comment_count
	NSDate     *lastComment;// last_comment_date
	BOOL        allowComments; // allow_comments
	TracksListModel *tracks; // tracks (array)
	NSString   *nowNext;    // now_next
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
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, assign) NSUInteger  speakerId;
@property (nonatomic, assign) BOOL        private;
@property (nonatomic, retain) NSString   *langAbbr;
@property (nonatomic, assign) NSUInteger  numComments;
@property (nonatomic, retain) NSDate     *lastComment;
@property (nonatomic, assign) BOOL        allowComments;
@property (nonatomic, retain) TracksListModel *tracks;
@property (nonatomic, retain) NSString   *nowNext;

-(id)init;
-(BOOL)hasFinished;
-(NSComparisonResult)comparator:(TalkDetailModel *)otherModel;
-(NSString *)getDateString:(EventDetailModel *)event;
-(NSString *)getSortableDateString:(EventDetailModel *)event;
-(NSString *)getTimeString:(EventDetailModel *)event;
-(BOOL)onNow;
-(BOOL)onNext;

@end
