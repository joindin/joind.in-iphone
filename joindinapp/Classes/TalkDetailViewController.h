//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <UIKit/UIKit.h>
#import "TalkDetailModel.h"
#import "EventDetailModel.h"

@interface TalkDetailViewController : UIViewController {
	TalkDetailModel  *talk;
	EventDetailModel *event;
	
	IBOutlet UILabel    *uiTitle;
	IBOutlet UILabel    *uiSpeaker;
	IBOutlet UILabel    *uiDate;
	IBOutlet UITextView *uiDesc;
	IBOutlet UIImageView *uiRating;
	IBOutlet UIButton   *uiComments;
	IBOutlet UILabel    *uiNotRated;
	IBOutlet UILabel    *uiNumComments;
	IBOutlet UIActivityIndicatorView *uiLoading;
	IBOutlet UILabel    *uiTracks;
}

@property (nonatomic, retain) TalkDetailModel  *talk;
@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) UILabel *uiTitle;
@property (nonatomic, retain) UILabel *uiSpeaker;
@property (nonatomic, retain) UILabel *uiDate;
@property (nonatomic, retain) UITextView *uiDesc;
@property (nonatomic, retain) UIImageView *uiRating;
@property (nonatomic, retain) UIButton *uiComments;
@property (nonatomic, retain) UILabel *uiNotRated;
@property (nonatomic, retain) UILabel *uiNumComments;
@property (nonatomic, retain) UIActivityIndicatorView *uiLoading;
@property (nonatomic, retain) UILabel *uiTracks;

-(IBAction)uiViewComments:(id)sender;
-(void)setupScreen:(BOOL)withExtraInfo;

@end
