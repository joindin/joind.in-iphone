//
//  SettingsViewController.m
//  joindinapp
//
//  Created by Kevin on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "APICaller.h"
#import "UserValidate.h"
#import "AboutViewController.h"

@implementation SettingsViewController

@synthesize uiUser;
@synthesize uiPass;
@synthesize uiLimitEvents;
@synthesize uiSignIn;
@synthesize uiOk;
@synthesize uiUserLabel;
@synthesize uiPassLabel;
@synthesize uiLimitLabel;
@synthesize uiChecking;
@synthesize uiContent;
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
	
}

- (void)aboutBtnPressed {
	AboutViewController *vc = [[AboutViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];	
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.keyboardIsShowing = NO;
	
	// Set the initial scroll view size
	//self.uiContent.contentSize = CGSizeMake(self.uiContent.frame.size.width, self.uiContent.frame.size.height);
	
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	self.uiUser.text      = [userPrefs stringForKey:@"username"];
	self.uiPass.text      = [userPrefs stringForKey:@"password"];
	self.uiLimitEvents.on = [userPrefs boolForKey:@"limitevents"];
	self.uiSignIn.on      = [userPrefs boolForKey:@"uselogin"];
	[self setupSignedIn];
	
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
		[[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
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
		[[note.userInfo valueForKey:UIKeyboardBoundsUserInfoKey] getValue: &keyboardBounds];
		NSUInteger keyboardHeight = keyboardBounds.size.height;
		
		CGRect frame = self.uiContent.frame;
		frame.size.height += keyboardHeight;
		self.uiContent.frame = frame;
		self.keyboardIsShowing = NO;
	}
	
}

- (IBAction) changedSignIn:(UISwitch *)sender {
	[self setupSignedIn];
}

- (void) setupSignedIn {

	if (self.uiSignIn.on) {
		self.uiUser.enabled        = YES;
		self.uiPass.enabled        = YES;
		self.uiLimitEvents.enabled = YES;
		self.uiUser.hidden         = NO;
		self.uiPass.hidden         = NO;
		self.uiLimitEvents.hidden  = NO;
		self.uiUserLabel.hidden    = NO;
		self.uiPassLabel.hidden    = NO;
		self.uiLimitLabel.hidden   = NO;
	} else {
		self.uiUser.enabled        = NO;
		self.uiPass.enabled        = NO;
		self.uiLimitEvents.enabled = NO;
		self.uiUser.hidden         = YES;
		self.uiPass.hidden         = YES;
		self.uiLimitEvents.hidden  = YES;
		self.uiUserLabel.hidden    = YES;
		self.uiPassLabel.hidden    = YES;
		self.uiLimitLabel.hidden   = YES;
	}
	self.uiContent.contentSize = CGSizeMake(self.uiContent.frame.size.width, self.uiContent.frame.size.height);
}

- (IBAction) submitScreen:(id)sender {
	if (self.uiSignIn.on) {
		[self.uiChecking startAnimating];
		self.uiOk.hidden = YES;
		UserValidate *u = [APICaller UserValidate:self];
		[u call:self.uiUser.text password:self.uiPass.text];		
	} else {
		[self savePrefs];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void) savePrefs {
	NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
	[userPrefs setBool:self.uiSignIn.on      forKey:@"uselogin"];
	[userPrefs setObject:self.uiUser.text    forKey:@"username"];
	[userPrefs setObject:self.uiPass.text    forKey:@"password"];
	[userPrefs setBool:self.uiLimitEvents.on forKey:@"limitevents"];
	[userPrefs synchronize];
	[APICaller clearCache];
}

- (void)gotUserValidateData:(BOOL)success error:(APIError *)err {
	[self.uiChecking stopAnimating];
	if (success) {
		[self savePrefs];
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

-(IBAction)doneEditing:(id)sender {
	[sender resignFirstResponder];
}
@end

