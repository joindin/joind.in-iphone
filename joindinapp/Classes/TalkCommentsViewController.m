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

#import "TalkCommentsViewController.h"
#import "TalkGetComments.h"
#import "TalkAddComment.h"
#import "TalkCommentsViewCell.h"
#import "NewCommentViewCell.h"
#import "SettingsViewController.h"
#import "TalkCommentsLoadingViewCell.h"

@implementation TalkCommentsViewController

@synthesize talk;
@synthesize comments;
@synthesize provideCommentCell;

@synthesize uiComment;
@synthesize uiAuthor;
@synthesize uiRating;
@synthesize uiCell;
@synthesize commentsLoaded;
@synthesize scrollToEnd;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.commentsLoaded = NO;
	self.scrollToEnd = NO;
	TalkGetComments *t = [APICaller TalkGetComments:self];
	[t call:self.talk];
	self.title = @"Loading...";
	
	if (self.talk.allowComments) {
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
	TalkGetComments *t = [APICaller TalkGetComments:self];
	[t call:self.talk];
	[[self tableView] reloadData];
}

- (void)addBtnPressed {
	
	NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
	[[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	[self performSelector:@selector(focusNewComment) withObject:nil afterDelay:0.1f];
}

- (void)focusNewComment {
	if (self.provideCommentCell != nil) {
		[self.provideCommentCell.uiComment becomeFirstResponder];
	} else {
		// Cell hasn't loaded yet - wait until the scroll is at the bottom and then focus the UITextView
		[self performSelector:@selector(focusNewComment) withObject:nil afterDelay:0.1f];
	}
}

- (void)gotTalkComments:(TalkCommentListModel *)tclm error:(APIError *)err {
	if (err == nil) {
		self.commentsLoaded = YES;
		self.comments = tclm;
		[[self tableView] reloadData];
		if (scrollToEnd) {
			scrollToEnd = NO;
			[self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
		}
	} else {
		UIAlertView *alert;
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:err.msg 
											  delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    int numComments = (int) [self.comments getNumComments];
    NSMutableString *commentTitle = [NSMutableString stringWithFormat:@"%d comment", numComments];
    if (numComments != 1) {
        [commentTitle appendString:@"s"];
    }
    self.title = commentTitle;
}

- (void)gotAddedTalkComment:(APIError *)error {
    if (error != nil) {
        UIAlertView *alert;
        NSLog(@"Error string %@", (NSString *)error);
        NSString *msg = @"There was a problem posting your comment";
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg
                                          delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

    // Reload comments
    [self.provideCommentCell reset];
    self.scrollToEnd = YES;
    TalkGetComments *t = [APICaller TalkGetComments:self];
    [t call:self.talk];
    self.title = @"Loading...";
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
	if (self.talk.allowComments) {
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
			static NSString *CellIdentifier = @"TalkCommentCell";
			
			TalkCommentsViewCell *cell = (TalkCommentsViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TalkCommentsCell" owner:nil options:nil];
				for (id currentObject in topLevelObjects) {
					if ([currentObject isKindOfClass:[TalkCommentsViewCell class]]) {
						cell = (TalkCommentsViewCell *)currentObject;
						break;
					}
				}
			}
			
			cell.uiAuthor.text  = [self.comments getTalkCommentAtIndex:[indexPath row]].userDisplayName;
			cell.uiComment.text = [self.comments getTalkCommentAtIndex:[indexPath row]].comment;
			cell.uiRating.image = [UIImage imageNamed:[NSString stringWithFormat:@"rating-%d.gif", (int) [self.comments getTalkCommentAtIndex:[indexPath row]].rating]];
			
			[cell.uiComment sizeToFit];
			
			CGRect f = cell.uiComment.frame;
			f.size.width = 297.0f;
			cell.uiComment.frame = f;
			
			CGRect f2 = cell.uiAuthor.frame;
			f2.origin.y = f.size.height + 6.0f;
			cell.uiAuthor.frame = f2;
			
			CGRect f3 = cell.uiRating.frame;
			f3.origin.y = f.size.height + 13.0f;
			cell.uiRating.frame = f3;
			
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
		static NSString *CellIdentifier = @"NewCommentViewCell";
		
		NewCommentViewCell *cell = (NewCommentViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TalkCommentsCell" owner:nil options:nil];
			for (id currentObject in topLevelObjects) {
				if ([currentObject isKindOfClass:[NewCommentViewCell class]]) {
					cell = (NewCommentViewCell *)currentObject;
					break;
				}
			}
		}
		cell.commentDelegate = self;
		[cell doStuff];
		self.provideCommentCell = cell;
		return cell;
	}
}

- (void)submitComment:(NSString *)comment activityIndicator:(UIActivityIndicatorView *)activity rating:(NSUInteger)rating {
	[activity startAnimating];
	TalkAddComment *t = [APICaller TalkAddComment:self];
	[t call:self.talk rating:rating comment:comment private:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([indexPath section] == 0) {
		if (self.commentsLoaded) {
			NSString *commentText = [self.comments getTalkCommentAtIndex:[indexPath row]].comment;
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

