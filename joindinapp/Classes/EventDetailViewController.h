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
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "APIError.h"
#import "EventAttend.h"

@interface EventDetailViewController : UITableViewController {
	EventDetailModel *event;
	TalkListModel *talks;

	// IB components
	IBOutlet UILabel  *uiTitle;
	IBOutlet UILabel  *uiDate;
	IBOutlet UILabel  *uiLocation;
	IBOutlet UILabel  *uiDesc;
	IBOutlet UIButton *uiDescButton;
	IBOutlet UIActivityIndicatorView *uiLoadTalksIndicator;
	IBOutlet UIView   *uiTableHeaderView;
	IBOutlet UISwitch *uiAttending;
	IBOutlet UILabel  *uiAttendingLabel;
	IBOutlet UIActivityIndicatorView *uiAttendingIndicator;
	IBOutlet UIButton *uiComments;
	IBOutlet UIActivityIndicatorView *uiLoading;
	IBOutlet UIButton *uiLocationButton;
}

- (IBAction)uiDescButtonPressed:(id)sender;
- (IBAction)uiAttendingButtonPressed:(id)sender;
- (IBAction)uiCommentsButtonPressed:(id)sender;
- (IBAction)uiLocationButtonPressed:(id)sender;

- (void)gotTalksForEvent:(TalkListModel *)tlm error:(APIError *)error;
- (void)gotEventAttend:(APIError *)err;
- (void)setupAttending;

@property (nonatomic, strong) EventDetailModel *event;
@property (nonatomic, strong) TalkListModel *talks;

@property (nonatomic, strong) UILabel  *uiTitle;
@property (nonatomic, strong) UILabel  *uiDate;
@property (nonatomic, strong) UILabel  *uiLocation;
@property (nonatomic, strong) UILabel  *uiDesc;
@property (nonatomic, strong) UIButton *uiDescButton;
@property (nonatomic, strong) UIActivityIndicatorView *uiLoadTalksIndicator;
@property (nonatomic, strong) UIView   *uiTableHeaderView;
@property (nonatomic, strong) UISwitch *uiAttending;
@property (nonatomic, strong) UILabel  *uiAttendingLabel;
@property (nonatomic, strong) UIActivityIndicatorView *uiAttendingIndicator;
@property (nonatomic, strong) UIButton *uiComments;
@property (nonatomic, strong) UIActivityIndicatorView *uiLoading;
@property (nonatomic, strong) UIButton *uiLocationButton;

@end
