//
//  EventDetailViewCell.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EventDetailViewCell : UITableViewCell {
	IBOutlet UILabel *lblTitle;
	IBOutlet UILabel *lblDesc;
	NSString *title;
	NSString *desc;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *desc;

@end
