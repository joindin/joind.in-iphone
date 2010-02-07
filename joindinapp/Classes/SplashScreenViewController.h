//
//  SplashScreenViewController.h
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"
#import "EventGetDetail.h"
#import "TalkDetailModel.h"
#import "TalkGetDetail.h"

@interface SplashScreenViewController : UIViewController <EventGetDetailResponse, TalkGetDetailResponse> {
	IBOutlet UIActivityIndicatorView *uiLoading;
	UINavigationController *navC;
	
	BOOL havePendingAction;
	NSUInteger pendingEventId;
	NSUInteger pendingTalkId;
}

- (IBAction) pressedWebsite;

- (void) performPendingActions;

- (void) gotoEventScreenWithEventId:(NSUInteger)eventId;
- (void) gotoEventScreenWithEventDetailModel:(EventDetailModel *)edm;
- (void) reallyGotoEventScreenWithEventId:(NSUInteger)eventId;

- (void) gotoTalkScreenWithTalkId:(NSUInteger)talkId;
- (void) gotoTalkScreenWithTalkDetailModel:(TalkDetailModel *)tdm;
- (void) reallyGotoTalkScreenWithTalkId:(NSUInteger)talkId;

@property (nonatomic, retain) UIActivityIndicatorView *uiLoading;
@property (nonatomic, retain) UINavigationController *navC;
@property (nonatomic, assign) BOOL havePendingAction;
@property (nonatomic, assign) NSUInteger pendingEventId;
@property (nonatomic, assign) NSUInteger pendingTalkId;

@end
