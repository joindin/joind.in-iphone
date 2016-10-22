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
#import "EventDetailModel.h"
#import "TracksListModel.h"

@interface TalkDetailModel : NSObject {
	NSString   *title;      // talk_title
	NSString   *urlFriendlyTalkTitle;      // url_friendly_talk_title
	NSString   *description;       // talk_description
	NSString   *type;       // type
	NSString   *slidesLink; // slides_link
	NSString   *lang;       // language
	NSDate     *startDate; // start_date
	NSUInteger  duration; // duration
	NSString   *stub; // stub
	NSUInteger  rating; // average_rating
	BOOL        allowComments; // comments_enabled
	NSUInteger  commentCount; // comment_count
	BOOL        starred; // starred
	NSUInteger  starredCount; // starred_count
	TracksListModel *tracks; // tracks (array)
	NSArray    *speakers;    // speakers (array)

	NSString   *uri;
	NSString   *verboseURI;
	NSString   *websiteURI;
	NSString   *commentsURI;
	NSString   *starredURI;
	NSString   *verboseCommentsURI;
	NSString   *eventURI;
}

@property (nonatomic, strong) NSString   *title;
@property (nonatomic, strong) NSString   *urlFriendlyTalkTitle;
@property (nonatomic, strong) NSString   *description;
@property (nonatomic, strong) NSString   *type;
@property (nonatomic, strong) NSString   *slidesLink;
@property (nonatomic, strong) NSString  *lang;
@property (nonatomic, strong) NSDate     *startDate;
@property (nonatomic, assign) NSUInteger  duration;
@property (nonatomic, strong) NSString   *stub;
@property (nonatomic, assign) NSUInteger  rating;
@property (nonatomic, assign) BOOL        allowComments;
@property (nonatomic, assign) NSUInteger  commentCount;
@property (nonatomic, assign) BOOL        starred;
@property (nonatomic, assign) NSUInteger  starredCount;
@property (nonatomic, strong) TracksListModel *tracks;
@property (nonatomic, strong) NSArray    *speakers;

@property (nonatomic, strong) NSString   *uri;
@property (nonatomic, strong) NSString   *verboseURI;
@property (nonatomic, strong) NSString   *websiteURI;
@property (nonatomic, strong) NSString   *commentsURI;
@property (nonatomic, strong) NSString   *starredURI;
@property (nonatomic, strong) NSString   *verboseCommentsURI;
@property (nonatomic, strong) NSString   *eventURI;

-(id)init;
-(BOOL)hasFinished;
-(NSComparisonResult)comparator:(TalkDetailModel *)otherModel;
-(NSString *)getDateString:(EventDetailModel *)event;
-(NSString *)getSortableDateString:(EventDetailModel *)event;
-(NSString *)getTimeString:(EventDetailModel *)event;
-(NSString *)getPrimarySpeakerString;
-(NSString *)getAllSpeakersString;
-(BOOL)onNow;
-(BOOL)onNext;

@end
