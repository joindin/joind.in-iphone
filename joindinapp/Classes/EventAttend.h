//
//  EventAttend.h
//  joindinapp
//
//  Created by Kevin on 08/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDetailModel.h"
#import "APICaller.h"


@interface EventAttend : APICaller {

}
- (void)call:(EventDetailModel *)event;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end

@interface APICaller (APICaller_EventAttend)
+ (EventAttend *)EventAttend:(id)_delegate;
@end

@protocol EventAttendResponse
- (void)gotEventAttend:(APIError *)err;
@end
