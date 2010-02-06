//
//  UserEventCommentDetailModel.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCommentDetailModel.h"


@interface UserEventCommentDetailModel : UserCommentDetailModel {
	NSUInteger  eventId;
	NSString   *commentorName;
}

@property (nonatomic, assign) NSUInteger  eventId;
@property (nonatomic, retain) NSString   *commentorName;

@end
