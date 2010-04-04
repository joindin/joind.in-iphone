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
	IBOutlet UIButton *uiShowMe;
	IBOutlet UIButton *uiShowEvent;
	EventDetailModel *event;
}

- (void)initMap;
- (IBAction) uiShowMePressed:(id)sender;
- (IBAction) uiShowEventPressed:(id)sender;

@property (nonatomic, retain) MKMapView *uiMap;
@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) UISegmentedControl *uiMapType;
@property (nonatomic, retain) UIButton *uiShowMe;
@property (nonatomic, retain) UIButton *uiShowEvent;

@end
