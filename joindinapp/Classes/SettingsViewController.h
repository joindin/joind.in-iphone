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
	IBOutlet UIButton     *uiOk;
	IBOutlet UIButton     *uiLogout;
	IBOutlet UIActivityIndicatorView *uiChecking;
	IBOutlet UIScrollView *uiContent;
	
	BOOL keyboardIsShowing;
}

@property (nonatomic, retain) UITextField  *uiUser;
@property (nonatomic, retain) UITextField  *uiPass;
@property (nonatomic, retain) UISwitch     *uiLimitEvents;
@property (nonatomic, retain) UIButton     *uiOk;
@property (nonatomic, retain) UIButton     *uiLogout;
@property (nonatomic, retain) UIActivityIndicatorView *uiChecking;
@property (nonatomic, retain) UIScrollView *uiContent;
@property (nonatomic, assign) BOOL keyboardIsShowing;

- (IBAction) submitScreen:(id)sender;
- (IBAction) logout:(id)sender;
- (IBAction) doneEditingUser:(id)sender;
- (IBAction) doneEditingPass:(id)sender;
- (void) savePrefs;

@end
