//
//  EventLocationViewController.h
//  joindinapp
//
//  Created by Kevin on 03/04/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EventDetailModel.h"

@interface EventLocationViewController : UIViewController <MKMapViewDelegate> {
	IBOutlet MKMapView *uiMap;
	IBOutlet UISegmentedControl *uiMapType;
	MKPlacemark *uiPlacemark;
	EventDetailModel *event;
}

- (void)initMap;

@property (nonatomic, retain) MKMapView *uiMap;
@property (nonatomic, retain) MKPlacemark *uiPlacemark;
@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) UISegmentedControl *uiMapType;

@end
