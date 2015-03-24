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

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController {
	IBOutlet UITextField  *uiUser;
	IBOutlet UITextField  *uiPass;
	IBOutlet UISwitch     *uiLimitEvents;
	IBOutlet UIButton     *uiOk;
	IBOutlet UIButton     *uiLogout;
	IBOutlet UIActivityIndicatorView *uiChecking;
	IBOutlet UIScrollView *uiContent;
	IBOutlet UISwitch     *uiLocalTime;
	IBOutlet UIImageView *uiUserGravatar;
	IBOutlet UILabel *uiLoggedInText;

	// Containing views for signed-in/signed-out states
	IBOutlet UIView *uiSigninView;
	IBOutlet UIView *uiSignedInView;

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
@property (nonatomic, retain) UISwitch     *uiLocalTime;
@property (nonatomic, retain) UIImageView  *uiUserGravatar;
@property (nonatomic, retain) UILabel      *uiLoggedInText;
@property (nonatomic, retain) UIView       *uiSigninView;
@property (nonatomic, retain) UIView       *uiSignedInView;

- (IBAction) submitScreen:(id)sender;
- (IBAction) logout:(id)sender;
- (IBAction) doneEditingUser:(id)sender;
- (IBAction) doneEditingPass:(id)sender;
- (IBAction) gotoRegister:(id)sender;
- (void) setSignedIn:(BOOL)userSignedIn;
- (void) setPrefs:(NSDictionary *)params;

@end
