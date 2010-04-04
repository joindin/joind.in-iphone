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
@synthesize uiPlacemark;
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
