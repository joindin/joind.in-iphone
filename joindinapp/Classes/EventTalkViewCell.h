//
//  EventTalkViewCell.h
//  joindinapp
//
//  Created by Kevin on 01/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventTalkViewCell : UITableViewCell {
	IBOutlet UIButton    *uiDetail;
	IBOutlet UILabel     *uiTalkName;
	IBOutlet UILabel     *uiSpeaker;
	IBOutlet UIImageView *uiRating;
	IBOutlet UILabel     *uiNumComments;
}

@property (nonatomic,retain) UIButton    *uiDetail;
@property (nonatomic,retain) UILabel     *uiTalkName;
@property (nonatomic,retain) UILabel     *uiSpeaker;
@property (nonatomic,retain) UIImageView *uiRating;
@property (nonatomic,retain) UILabel     *uiNumComments;

@end
