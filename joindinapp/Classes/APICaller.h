//
//  APICaller.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventListModel.h"


@interface APICaller : NSObject {

}

+ (EventListModel *)GetEventList;
+ (NSObject *)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params;

@end
