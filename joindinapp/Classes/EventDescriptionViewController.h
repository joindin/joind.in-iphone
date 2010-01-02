//
//  EventDescriptionViewController.h
//  joindinapp
//
//  Created by Kevin on 02/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailModel.h"


@interface EventDescriptionViewController : UIViewController {
	EventDetailModel *event;
	IBOutlet UITextView *uiDescription;
}

@property (nonatomic, retain) EventDetailModel *event;
@property (nonatomic, retain) UITextView *uiDescription;

@end
