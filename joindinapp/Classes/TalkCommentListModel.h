//
//  TalkCommentListModel.h
//  joindinapp
//
//  Created by Kevin on 09/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TalkCommentDetailModel.h"


@interface TalkCommentListModel : NSObject {
	NSMutableArray *comments;
}

@property(nonatomic, retain) NSMutableArray *comments;

- (void)addComment:(TalkCommentDetailModel *)tcdm;
- (TalkCommentDetailModel *)getTalkCommentAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumComments;

@end
