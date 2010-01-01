//
//  EventListModel.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDetailModel.h"

@interface EventListModel : NSObject {
	NSMutableArray *events;
}

@property(nonatomic, retain) NSMutableArray *events;

- (void)addEvent:(EventDetailModel *)edm;
- (EventDetailModel *)getEventDetailModelAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumEvents;

@end
