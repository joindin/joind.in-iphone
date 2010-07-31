//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
