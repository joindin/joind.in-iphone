//
//  EventLocationViewController.m
//  joindinapp
//
//  Created by Kevin on 03/04/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import "EventLocationViewController.h"
#import "EventDetailModel.h"
#import "EventMapAnnotation.h"

@implementation EventLocationViewController

@synthesize uiMap;
@synthesize uiMapType;
@synthesize uiShowMe;
@synthesize uiShowEvent;
@synthesize event;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self initMap];
	
	[self.uiMapType addTarget:self
						 action:@selector(changeMapType:)
			   forControlEvents:UIControlEventValueChanged];
}

- (void)changeMapType:(id)sender {
	switch(self.uiMapType.selectedSegmentIndex) {
		default:
		case 0:
			self.uiMap.mapType = MKMapTypeStandard;
			break;
		case 1:
			self.uiMap.mapType = MKMapTypeSatellite;
			break;
		case 2:
			self.uiMap.mapType = MKMapTypeHybrid;
			break;
	}
}

- (IBAction) uiShowMePressed:(id)sender {
	
	self.uiMap.showsUserLocation = YES;
	
	MKCoordinateRegion region;
	
	CLLocationCoordinate2D evtLocation;
	evtLocation.latitude = self.event.event_lat;
	evtLocation.longitude = self.event.event_long;
	
	CLLocationCoordinate2D myLocation;
	myLocation = self.uiMap.userLocation.location.coordinate;
	
	CLLocationCoordinate2D centreLocation;
	centreLocation.latitude = (evtLocation.latitude + myLocation.latitude) / 2;
	centreLocation.longitude = (evtLocation.longitude + myLocation.longitude) / 2;
	
	MKCoordinateSpan span;
	if ((evtLocation.latitude - myLocation.latitude) > 0) {
		span.latitudeDelta = (evtLocation.latitude - myLocation.latitude);
	} else {
		span.latitudeDelta = (myLocation.latitude - evtLocation.latitude);
	}
	if ((evtLocation.longitude - myLocation.longitude) > 0) {
		span.longitudeDelta = (evtLocation.longitude - myLocation.longitude);
	} else {
		span.longitudeDelta = (myLocation.longitude - evtLocation.longitude);
	}

	region.span = span;
	region.center = centreLocation;
	
	MKCoordinateRegion adjustedRegion = [self.uiMap regionThatFits:region];
	
	[self.uiMap setRegion:adjustedRegion animated:TRUE];
	
}

- (IBAction) uiShowEventPressed:(id)sender {
	[self initMap];
}

- (void)initMap {
	
	/*Region and Zoom*/
	
	MKCoordinateRegion region;
	
	CLLocationCoordinate2D location;
	location.latitude=self.event.event_lat;
	location.longitude=self.event.event_long;
	
	MKCoordinateSpan span;
	span.latitudeDelta=0.02;
	span.longitudeDelta=0.02;
	
	region.span=span;
	region.center=location;
	
	MKCoordinateRegion adjustedRegion = [self.uiMap regionThatFits:region];
	
	[self.uiMap setRegion:adjustedRegion animated:TRUE];
	
	EventMapAnnotation *ema = [[[EventMapAnnotation alloc] initWithCoordinate:location title:self.event.name] autorelease];
	[uiMap addAnnotation:ema];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
