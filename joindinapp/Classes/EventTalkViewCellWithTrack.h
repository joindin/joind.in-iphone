//
//  EventTalkViewCellWithTrack.h
//  joindinapp
//
//  Created by Kevin on 20/03/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventTalkViewCellWithTrack : UITableViewCell {
	IBOutlet UIButton    *uiDetail;
	IBOutlet UILabel     *uiTalkName;
	IBOutlet UILabel     *uiSpeaker;
	IBOutlet UIImageView *uiRating;
	IBOutlet UILabel     *uiNumComments;
	IBOutlet UIImageView *uiCommentBubble;
	IBOutlet UIImageView *uiTalkType;
	IBOutlet UILabel     *uiTime;
	IBOutlet UILabel     *uiTracks;
}

@property (nonatomic,retain) UIButton    *uiDetail;
@property (nonatomic,retain) UILabel     *uiTalkName;
@property (nonatomic,retain) UILabel     *uiSpeaker;
@property (nonatomic,retain) UIImageView *uiRating;
@property (nonatomic,retain) UILabel     *uiNumComments;
@property (nonatomic,retain) UIImageView *uiCommentBubble;
@property (nonatomic,retain) UIImageView *uiTalkType;
@property (nonatomic,retain) UILabel     *uiTime;
@property (nonatomic,retain) UILabel     *uiTracks;

@end
