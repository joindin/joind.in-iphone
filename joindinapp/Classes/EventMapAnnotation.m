//
//  EventMapAnnotation.m
//  joindinapp
//
//  Created by Kevin on 04/04/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import "EventMapAnnotation.h"


@implementation EventMapAnnotation
@synthesize coordinate;
@synthesize title;

-(id) initWithCoordinate:(CLLocationCoordinate2D)_coordinate title:(NSString*)_title {
	self.coordinate = _coordinate;
	self.title = _title;
	return self;
}

@end
