//
//  TalkDetailViewController.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkDetailModel.h"

@interface TalkDetailViewController : UIViewController {
	TalkDetailModel *talk;
	
	IBOutlet UILabel    *uiTitle;
	IBOutlet UILabel    *uiSpeaker;
	IBOutlet UILabel    *uiDate;
	IBOutlet UITextView *uiDesc;
	IBOutlet UIImageView *uiRating;
	IBOutlet UIButton   *uiComments;
	IBOutlet UILabel    *uiNotRated;
	IBOutlet UILabel    *uiNumComments;
}

@property (nonatomic, retain) TalkDetailModel *talk;
@property (nonatomic, retain) UILabel *uiTitle;
@property (nonatomic, retain) UILabel *uiSpeaker;
@property (nonatomic, retain) UILabel *uiDate;
@property (nonatomic, retain) UITextView *uiDesc;
@property (nonatomic, retain) UIImageView *uiRating;
@property (nonatomic, retain) UIButton *uiComments;
@property (nonatomic, retain) UILabel *uiNotRated;
@property (nonatomic, retain) UILabel *uiNumComments;

-(IBAction)uiViewComments:(id)sender;

@end
