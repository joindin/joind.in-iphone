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

#import <Foundation/Foundation.h>


@interface NewCommentViewCell : UITableViewCell {
	IBOutlet UIButton *uiSubmit;
	IBOutlet UITextView *uiComment;
	IBOutlet UIActivityIndicatorView *uiActivity;
	IBOutlet UIButton *uiRating1;
	IBOutlet UIButton *uiRating2;
	IBOutlet UIButton *uiRating3;
	IBOutlet UIButton *uiRating4;
	IBOutlet UIButton *uiRating5;
	
	NSUInteger rating;
	
	id commentDelegate;
}

@property (nonatomic, retain) UIButton *uiSubmit;
@property (nonatomic, retain) UITextView *uiComment;
@property (nonatomic, retain) UIActivityIndicatorView *uiActivity;
@property (nonatomic, retain) id commentDelegate;
@property (nonatomic, retain) UIButton *uiRating1;
@property (nonatomic, retain) UIButton *uiRating2;
@property (nonatomic, retain) UIButton *uiRating3;
@property (nonatomic, retain) UIButton *uiRating4;
@property (nonatomic, retain) UIButton *uiRating5;
@property (nonatomic, assign) NSUInteger rating;

- (IBAction) uiSubmitted:(id)sender;
- (IBAction) uiRatingPressed:(id)sender;
- (void) doStuff;
- (void) textGotFocus:(NSNotification*)notification;
- (void) reset;

@end

@protocol CommentSubmitter
- (void)submitComment:(NSString *)comment  activityIndicator:(UIActivityIndicatorView *)activity rating:(NSUInteger)rating;
@end
