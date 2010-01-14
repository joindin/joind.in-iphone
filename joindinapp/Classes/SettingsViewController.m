//
//  SettingsViewController.m
//  joindinapp
//
//  Created by Kevin on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "APICaller.h"

@implementation SettingsViewController

@synthesize uiUser;
@synthesize uiPass;
@synthesize uiLimitEvents;
@synthesize uiAPIUrl;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	self.uiUser.text = [userPrefs stringForKey:@"username"];
	self.uiPass.text = [userPrefs stringForKey:@"password"];
	self.uiLimitEvents.on = [userPrefs boolForKey:@"limitevents"];
	[self.uiAPIUrl selectRow:[userPrefs integerForKey:@"apiurl"] inComponent:0 animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	[userPrefs setObject:self.uiUser.text forKey:@"username"];
	[userPrefs setObject:self.uiPass.text forKey:@"password"];
	[userPrefs setBool:self.uiLimitEvents.on forKey:@"limitevents"];
	[userPrefs setInteger:[self.uiAPIUrl selectedRowInComponent:0] forKey:@"apiurl"];
	[userPrefs synchronize];
	[APICaller clearCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark UIPickerView methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	switch (row) {
		case 0:
			return @"http://joind.in/api";
			break;
		case 1:
			return @"http://lorna.rivendell.local/api";
			break;
		case 2:
			return @"http://lorna.adsl.magicmonkey.org/api";
			break;
		default:
			return @"http://lorna.adsl.magicmonkey.org/api";
			break;
	}
}



@end

