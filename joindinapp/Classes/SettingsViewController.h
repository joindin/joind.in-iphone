//
//  SettingsViewController.h
//  joindinapp
//
//  Created by Kevin on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	IBOutlet UITextField *uiUser;
	IBOutlet UITextField *uiPass;
	IBOutlet UISwitch    *uiLimitEvents;
}

@property (nonatomic, retain) UITextField *uiUser;
@property (nonatomic, retain) UITextField *uiPass;
@property (nonatomic, retain) UISwitch    *uiLimitEvents;

@end
