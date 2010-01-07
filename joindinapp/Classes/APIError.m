//
//  APIError.m
//  joindinapp
//
//  Created by Kevin on 07/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "APIError.h"


@implementation APIError
@synthesize msg;
@synthesize type;

+(id)APIErrorWithMsg:(NSString *)_msg type:(APIErrType)type {
	APIError *e = [[APIError alloc] autorelease];
	e.msg = _msg;
	e.type = type;
	return e;
}

@end
