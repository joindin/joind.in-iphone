//
//  UserDetailModel.h
//  joindinapp
//
//  Created by Kevin on 03/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDetailModel : NSObject {
	NSString   *username;
	NSDate     *lastLogin;
	NSUInteger  uid;
	NSString   *fullName;
}

@property (nonatomic, retain) NSString   *username;
@property (nonatomic, retain) NSDate     *lastLogin;
@property (nonatomic, assign) NSUInteger  uid;
@property (nonatomic, retain) NSString   *fullName;

@end
