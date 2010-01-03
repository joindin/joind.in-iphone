//
//  joindinappAppDelegate.h
//  joindinapp
//
//  Created by Kevin on 31/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface joindinappAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    IBOutlet SplashScreenViewController *splashScreenViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SplashScreenViewController *splashScreenViewController;

@end

