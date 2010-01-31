//
//  EventCommentListModel.h
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventCommentDetailModel.h"


@interface EventCommentListModel : NSObject {
	NSMutableArray *comments;
}

@property(nonatomic, retain) NSMutableArray *comments;

- (void)addComment:(EventCommentDetailModel *)tcdm;
- (EventCommentDetailModel *)getEventCommentAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumComments;

@end
