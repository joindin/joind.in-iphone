//
//  SettingsViewController.h
//  joindinapp
//
//  Created by Kevin on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	IBOutlet UITextField  *uiUser;
	IBOutlet UITextField  *uiPass;
	IBOutlet UISwitch     *uiLimitEvents;
	IBOutlet UISwitch     *uiSignIn;
	IBOutlet UIButton     *uiOk;
	IBOutlet UILabel      *uiUserLabel;
	IBOutlet UILabel      *uiPassLabel;
	IBOutlet UILabel      *uiLimitLabel;
	IBOutlet UIActivityIndicatorView *uiChecking;
	IBOutlet UIScrollView *uiContent;
}

@property (nonatomic, retain) UITextField  *uiUser;
@property (nonatomic, retain) UITextField  *uiPass;
@property (nonatomic, retain) UISwitch     *uiLimitEvents;
@property (nonatomic, retain) UISwitch     *uiSignIn;
@property (nonatomic, retain) UIButton     *uiOk;
@property (nonatomic, retain) UILabel      *uiUserLabel;
@property (nonatomic, retain) UILabel      *uiPassLabel;
@property (nonatomic, retain) UILabel      *uiLimitLabel;
@property (nonatomic, retain) UIActivityIndicatorView *uiChecking;
@property (nonatomic, retain) UIScrollView *uiContent;

- (IBAction) changedSignIn:(UISwitch *)sender;
- (IBAction) submitScreen:(id)sender;
- (IBAction) doneEditing:(id)sender;
- (void) setupSignedIn;
- (void) savePrefs;

@end
