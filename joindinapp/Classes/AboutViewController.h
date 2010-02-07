//
//  AboutViewController.h
//  joindinapp
//
//  Created by Kevin on 01/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {
	IBOutlet UILabel *uiVersion;
}

@property (nonatomic, retain) UILabel *uiVersion;

- (IBAction) uiClearCache:(id)sender;
- (IBAction) uiWebsite:(id)sender;
- (IBAction) uiSupportWebsite:(id)sender;
- (IBAction) uiCredits:(id)sender;

@end
