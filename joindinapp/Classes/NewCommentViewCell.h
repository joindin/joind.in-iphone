//
//  NewCommentViewCell.h
//  joindinapp
//
//  Created by Kevin on 11/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewCommentViewCell : UITableViewCell {
	IBOutlet UIButton *uiSubmit;
	IBOutlet UITextView *uiComment;
	IBOutlet UIActivityIndicatorView *uiActivity;
}

@property (nonatomic, retain) UIButton *uiSubmit;
@property (nonatomic, retain) UITextView *uiComment;
@property (nonatomic, retain) UIActivityIndicatorView *uiActivity;

- (IBAction) uiSubmitted:(id)sender;

@end
