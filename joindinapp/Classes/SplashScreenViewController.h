//
//  SplashScreenViewController.h
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SplashScreenViewController : UIViewController {
	IBOutlet UIActivityIndicatorView *uiLoading;
}

- (IBAction) pressedWebsite;

@property (nonatomic, retain) UIActivityIndicatorView *uiLoading;

@end
