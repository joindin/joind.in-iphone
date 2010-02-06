//
//  UserCommentDetailModel.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserCommentDetailModel : NSObject {
	NSString   *comment;
	NSDate     *made;
	NSUInteger  uid;
	BOOL        active;
	NSUInteger  id;
}

@property (nonatomic, retain) NSString   *comment;
@property (nonatomic, retain) NSDate     *made;
@property (nonatomic, assign) NSUInteger  uid;
@property (nonatomic, assign) BOOL        active;
@property (nonatomic, assign) NSUInteger  id;

@end
