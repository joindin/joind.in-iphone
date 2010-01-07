//
//  APIError.h
//  joindinapp
//
//  Created by Kevin on 07/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSUInteger APIErrType;
enum {
    ERR_NETWORK = 1,
	ERR_CREDENTIALS = 2,
	ERR_UNKNOWN = 3
};



@interface APIError : NSObject {
	NSString *msg;
	APIErrType type;
}

@property (nonatomic, retain) NSString *msg;
@property (nonatomic, assign) APIErrType type;

+(id)APIErrorWithMsg:(NSString *)_msg type:(APIErrType)errtype;

@end
