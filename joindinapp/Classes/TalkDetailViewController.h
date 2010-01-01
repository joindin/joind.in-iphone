//
//  TalkDetailViewController.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkDetailModel.h"

@interface TalkDetailViewController : UITableViewController {
	TalkDetailModel *talk;
}

@property (nonatomic, retain) TalkDetailModel *talk;

@end
