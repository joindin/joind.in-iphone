//
//  SettingsViewController.h
//  joindinapp
//
//  Created by Kevin on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	IBOutlet UITextField  *uiUser;
	IBOutlet UITextField  *uiPass;
	IBOutlet UISwitch     *uiLimitEvents;
	IBOutlet UIPickerView *uiAPIUrl;
}

@property (nonatomic, retain) UITextField  *uiUser;
@property (nonatomic, retain) UITextField  *uiPass;
@property (nonatomic, retain) UISwitch     *uiLimitEvents;
@property (nonatomic, retain) UIPickerView *uiAPIUrl;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView;
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;


@end
