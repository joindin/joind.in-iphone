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

#import "SettingsViewController.h"
#import "APICaller.h"
#import "UserValidate.h"
#import "AboutViewController.h"

@implementation SettingsViewController

@synthesize uiUser;
@synthesize uiPass;
@synthesize uiLimitEvents;
@synthesize uiOk;
@synthesize uiLogout;
@synthesize uiChecking;
@synthesize uiContent;
@synthesize uiLocalTime;
@synthesize keyboardIsShowing;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(aboutBtnPressed)];
	// Let me know if the keyboard is going to appear / disappear
	[[NSNotificationCenter defaultCenter]
				 addObserver:self
					selector:@selector(keyboardWillShow:)
						name:UIKeyboardWillShowNotification
					  object:nil];
	[[NSNotificationCenter defaultCenter]
				 addObserver:self
					selector:@selector(keyboardWillHide:)
						name:UIKeyboardWillHideNotification
					  object:nil];
	self.title = @"Settings";
}

- (void)aboutBtnPressed {
	AboutViewController *vc = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.keyboardIsShowing = NO;
	
	// Set the initial scroll view size
	self.uiContent.contentSize = CGSizeMake(self.uiContent.frame.size.width, self.uiContent.frame.size.height);
	
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	
	if ([userPrefs stringForKey:@"timezonedisplay"] == nil) {
		[userPrefs setObject:@"event" forKey:@"timezonedisplay"];
		[userPrefs synchronize];
	}
	
	self.uiUser.text      = [userPrefs stringForKey:@"username"];
	self.uiPass.text      = [userPrefs stringForKey:@"password"];
	self.uiLimitEvents.on = [userPrefs boolForKey:@"limitevents"];
	self.uiLocalTime.on   = [[userPrefs stringForKey:@"timezonedisplay"] isEqualToString:@"event"];
	
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [super dealloc];
}

- (void) keyboardWillShow:(NSNotification *)note {
	if (!self.keyboardIsShowing) {
		CGRect keyboardBounds;
		[[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
		NSUInteger keyboardHeight = keyboardBounds.size.height;
		
		CGRect frame = self.uiContent.frame;
		frame.size.height -= keyboardHeight;
		self.uiContent.frame = frame;
		self.keyboardIsShowing = YES;
	}
}

- (void) keyboardWillHide:(NSNotification *)note {
	if (self.keyboardIsShowing) {
		CGRect keyboardBounds;
		[[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
		NSUInteger keyboardHeight = keyboardBounds.size.height;
		
		CGRect frame = self.uiContent.frame;
		frame.size.height += keyboardHeight;
		self.uiContent.frame = frame;
		self.keyboardIsShowing = NO;
	}
	
}

- (IBAction) submitScreen:(id)sender {
	if ([self.uiUser.text isEqualToString:@""]) {
		NSMutableDictionary *params = [[NSMutableDictionary init] alloc];
		[params setObject:@"" forKey:@"username"];
		[params setObject:@"" forKey:@"access_token"];
		[params setObject:@"" forKey:@"user_uri"];
		[self setPrefs:params];
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		[self.uiChecking startAnimating];
		self.uiOk.hidden = YES;
		UserValidate *u = [APICaller UserValidate:self];
		[u call:self.uiUser.text password:self.uiPass.text];		
	}
}

- (IBAction) logout:(id)sender {
	self.uiUser.text = @"";
	self.uiPass.text = @"";
	[self submitScreen:sender];
}

- (void) setPrefs:(NSDictionary *)params {
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];

	// We expect authentication details to be set here
	if ([[params objectForKey:@"username"] isKindOfClass:[NSString class]]) {
		[userPrefs setObject:[params objectForKey:@"username"] forKey:@"username"];
	}
	if ([[params objectForKey:@"access_token"] isKindOfClass:[NSString class]]) {
		[userPrefs setObject:[params objectForKey:@"access_tokene"] forKey:@"access_token"];
	}
	if ([[params objectForKey:@"user_uri"] isKindOfClass:[NSString class]]) {
		[userPrefs setObject:[params objectForKey:@"user_uri"] forKey:@"user_uri"];
	}

	[userPrefs setBool:self.uiLimitEvents.on forKey:@"limitevents"];
	if (self.uiLocalTime.on) {
		[userPrefs setObject:@"event" forKey:@"timezonedisplay"];
	} else {
		[userPrefs setObject:@"you"   forKey:@"timezonedisplay"];
	}
	[userPrefs synchronize];
	//[APICaller clearCache];
}

- (void)gotUserValidateData:(BOOL)success error:(APIError *)err data:(NSDictionary *)data {
	[self.uiChecking stopAnimating];
	if (success) {
		NSMutableDictionary *newParams = [[NSMutableDictionary alloc] initWithDictionary:data];
		[newParams setObject:self.uiUser.text forKey:@"username"];
		[self setPrefs:newParams];
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid username/password"
										  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		self.uiOk.hidden = NO;
	}
}

- (IBAction) gotoRegister:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://joind.in/user/register/"]];
}

-(IBAction)doneEditingUser:(id)sender {
	[sender resignFirstResponder];
	[self.uiPass becomeFirstResponder];
}

-(IBAction)doneEditingPass:(id)sender {
	[sender resignFirstResponder];
}
@end

