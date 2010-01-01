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
}

@property(nonatomic, retain) NSMutableArray *talks;

- (void)addTalk:(TalkDetailModel *)tdm;
- (TalkDetailModel *)getTalkDetailModelAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumTalks;

@end
