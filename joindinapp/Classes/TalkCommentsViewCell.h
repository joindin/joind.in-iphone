//
//  TalkCommentsViewCellController.h
//  joindinapp
//
//  Created by Kevin on 10/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TalkCommentsViewCell : UITableViewCell {
	IBOutlet UILabel *uiComment;
	IBOutlet UILabel *uiAuthor;
	IBOutlet UIImageView *uiRating;
}

@property (nonatomic, retain) UILabel     *uiComment;
@property (nonatomic, retain) UILabel     *uiAuthor;
@property (nonatomic, retain) UIImageView *uiRating;

@end
