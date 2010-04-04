//
//  EventMapAnnotation.h
//  joindinapp
//
//  Created by Kevin on 04/04/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface EventMapAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *title;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;

@end
