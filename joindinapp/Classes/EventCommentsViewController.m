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

#import "EventCommentsViewController.h"

#import "EventCommentsViewController.h"
#import "EventGetComments.h"
#import "EventAddComment.h"
#import "EventCommentsViewCell.h"
#import "NewEventCommentViewCell.h"
#import "SettingsViewController.h"
#import "TalkCommentsLoadingViewCell.h"

@implementation EventCommentsViewController

@synthesize event;
@synthesize comments;
@synthesize commentsLoaded;
@synthesize newCommentCell;

@synthesize uiComment;
@synthesize uiAuthor;
@synthesize uiCell;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.commentsLoaded = NO;
	EventGetComments *e = [APICaller EventGetComments:self];
	[e call:self.event];
	self.title = @"Loading...";
	
	if (self.event.allowComments) {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnPressed)];
	} else {
		// Removed refresh button because it'll only appear after commenting has closed, so there's no point having a refresh
		//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshBtnPressed)];
	}
	
}

- (void)refreshBtnPressed {
	self.commentsLoaded = NO;
	self.comments = nil;
	self.title = @"Loading...";
	[APICaller clearCache];
	EventGetComments *e = [APICaller EventGetComments:self];
	[e call:self.event];
	[[self tableView] reloadData];
}

- (void)addBtnPressed {
	
	NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
	[[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	[self performSelector:@selector(focusNewComment) withObject:nil afterDelay:0.1f];
}

- (void)focusNewComment {
	if (self.newCommentCell != nil) {
		[self.newCommentCell.uiComment becomeFirstResponder];
	} else {
		// Cell hasn't loaded yet - wait until the scroll is at the bottom and then focus the UITextView
		[self performSelector:@selector(focusNewComment) withObject:nil afterDelay:0.1f];
	}
}

- (void)gotEventComments:(EventCommentListModel *)eclm error:(APIError *)err {
	if (err == nil) {
		self.commentsLoaded = YES;
		self.comments = eclm;
		[[self tableView] reloadData];
	} else {
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:err.msg 
										  delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	self.title = [NSString stringWithFormat:@"%d comments", [self.comments getNumComments]];
}

- (void)gotAddedEventComment:(APIError *)error {
	if (error != nil) {
		UIAlertView *alert;
		if (error.type == ERR_CREDENTIALS) {
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.msg 
											  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		} else {
			NSMutableString *msg = [NSMutableString stringWithCapacity:1];
			[msg setString:@""];
			if ([error.msg class] == [NSArray class]) {
				for(NSString *eachMsg in (NSArray *)error.msg) {
					[msg appendString:@", "];
					[msg appendString:eachMsg];
				}
			} else {
				[msg appendString:error.msg];
			}
			NSLog(@"Error string %@", error.msg);
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg 
											  delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
			// Reload comments
			EventGetComments *e = [APICaller EventGetComments:self];
			[e call:self.event];
			self.title = @"Loading...";
		}
		[alert show];
		[alert release];
	} else {
		// Reload comments
		EventGetComments *e = [APICaller EventGetComments:self];
		[e call:self.event];
		self.title = @"Loading...";
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	SettingsViewController *vc = [[SettingsViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (self.event.allowComments) {
		return 2;
	} else {
		return 1;
	}
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		if (self.commentsLoaded) {
			return [self.comments getNumComments];
		} else {
			return 1; // "Loading" spinner
		}
	} else {
		return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	tableView.allowsSelection = NO;
	
	if ([indexPath section] == 0) {
		
		if (self.commentsLoaded) {
			
			static NSString *CellIdentifier = @"EventCommentCell";
			
			EventCommentsViewCell *cell = (EventCommentsViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventCommentsCell" owner:nil options:nil];
				for (id currentObject in topLevelObjects) {
					if ([currentObject isKindOfClass:[EventCommentsViewCell class]]) {
						cell = (EventCommentsViewCell *)currentObject;
						break;
					}
				}
			}
			
			cell.uiAuthor.text  = [self.comments getEventCommentAtIndex:[indexPath row]].username;
			cell.uiComment.text = [self.comments getEventCommentAtIndex:[indexPath row]].comment;
			[cell.uiComment sizeToFit];
			
			CGRect f = cell.uiComment.frame;
			
			CGRect f2 = cell.uiAuthor.frame;
			f2.origin.y = f.size.height + 0.0f;
			cell.uiAuthor.frame = f2;
			
			return cell;
			
		} else {			
			
			static NSString *CellIdentifier = @"TalkCommentsLoadingCell";
			
			TalkCommentsLoadingViewCell *cell = (TalkCommentsLoadingViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TalkCommentsCell" owner:nil options:nil];
				for (id currentObject in topLevelObjects) {
					if ([currentObject isKindOfClass:[TalkCommentsLoadingViewCell class]]) {
						cell = (TalkCommentsLoadingViewCell *)currentObject;
						break;
					}
				}
			}
			
			return cell;
			
		}
	} else {
		static NSString *CellIdentifier = @"NewEventCommentViewCell";
		
		NewEventCommentViewCell *cell = (NewEventCommentViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventCommentsCell" owner:nil options:nil];
			for (id currentObject in topLevelObjects) {
				if ([currentObject isKindOfClass:[NewEventCommentViewCell class]]) {
					cell = (NewEventCommentViewCell *)currentObject;
					break;
				}
			}
		}
		cell.EventCommentDelegate = self;
		self.newCommentCell = cell;
		[cell doStuff];
		return cell;
	}
}

- (void)submitComment:(NSString *)comment activityIndicator:(UIActivityIndicatorView *)activity {
	[activity startAnimating];
	EventAddComment *e = [APICaller EventAddComment:self];
	[e call:self.event comment:comment];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([indexPath section] == 0) {
		if (self.commentsLoaded) {
			
			NSString *commentText = [self.comments getEventCommentAtIndex:[indexPath row]].comment;
			CGSize suggestedSize = [commentText sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(297.0f, FLT_MAX) lineBreakMode:NSLineBreakByTruncatingTail];
			return suggestedSize.height + 30.0f;
		} else {
			return 50.0f;
		}
	} else {
		return 108.0f;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)dealloc {
    [super dealloc];
}


@end

