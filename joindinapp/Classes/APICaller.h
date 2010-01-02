//
//  APICaller.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListModel.h"
#import "TalkListModel.h"

@interface APICaller : NSObject {
}

+ (NSString *)GetApiUrl;
+ (EventListModel *)GetEventList;
+ (TalkListModel *)GetTalksForEvent:(EventDetailModel *)event;
+ (NSObject *)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params;

@end
