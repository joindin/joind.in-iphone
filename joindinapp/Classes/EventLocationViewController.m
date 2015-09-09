//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
    [self updateShowMeEnabledStatus:[CLLocationManager authorizationStatus]];
    [self.locationManager startUpdatingLocation];
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
	evtLocation.latitude = self.event.latitude;
	evtLocation.longitude = self.event.longitude;
	
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
	location.latitude=self.event.latitude;
	location.longitude=self.event.longitude;
	
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

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self updateShowMeEnabledStatus:status];
}

- (void)updateShowMeEnabledStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusDenied) {
        self.uiShowMe.enabled = FALSE;
    }
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.uiShowMe.enabled = TRUE;
    }
}

@end
