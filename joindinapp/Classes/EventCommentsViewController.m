//
//  EventCommentsViewController.m
//  joindinapp
//
//  Created by Kevin on 25/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventCommentsViewController.h"

#import "EventCommentsViewController.h"
#import "EventGetComments.h"
#import "EventAddComment.h"
#import "EventCommentsViewCell.h"
#import "NewEventCommentViewCell.h"
#import "SettingsViewController.h"

@implementation EventCommentsViewController

@synthesize event;
@synthesize comments;

@synthesize uiComment;
@synthesize uiAuthor;
@synthesize uiCell;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	EventGetComments *e = [APICaller EventGetComments:self];
	[e call:self.event];
	
}

- (void)gotEventComments:(EventCommentListModel *)eclm error:(APIError *)err {
	if (err == nil) {
		self.comments = eclm;
		[(UITableView *)[self view] reloadData];
	} else {
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:err.msg 
										  delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
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
		}
		[alert show];
		[alert release];
	} else {
		// Reload comments
		EventGetComments *e = [APICaller EventGetComments:self];
		[e call:self.event];
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
		return [self.comments getNumComments];
	} else {
		return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	tableView.allowsSelection = NO;
	
	if ([indexPath section] == 0) {
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
		NSString *commentText = [self.comments getEventCommentAtIndex:[indexPath row]].comment;
		CGSize suggestedSize = [commentText sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(297.0f, FLT_MAX) lineBreakMode:UILineBreakModeTailTruncation];
		return suggestedSize.height + 30.0f;
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

