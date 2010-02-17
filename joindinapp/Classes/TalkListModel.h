//
//  TalkListModel.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TalkDetailModel.h"

@interface TalkListModel : NSObject {
	NSMutableArray *talks;
	NSMutableDictionary *talksByDate;
}

@property(nonatomic, retain) NSMutableArray *talks;
@property(nonatomic, retain) NSMutableDictionary *talksByDate;

- (void)addTalk:(TalkDetailModel *)tdm;
- (TalkDetailModel *)getTalkDetailModelAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumTalks;
- (void)sort;
- (void)sort:(BOOL)forwards;
- (NSDictionary *)getTalksByDate;
- (NSArray *)getTalksOnDate:(NSDate *)date;
- (TalkDetailModel *)getTalkForDayAndRowByIndex:(NSUInteger)dayIndex rowIndex:(NSUInteger)rowIndex;

@end
