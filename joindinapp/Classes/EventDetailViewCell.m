//
//  EventDetailViewCell.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewCell.h"


@implementation EventDetailViewCell

@synthesize title, desc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)_title {
	title = _title;
	[title retain];
	lblTitle.text = title;
}

- (void)setDesc:(NSString *)_desc {
	desc = _desc;
	[desc retain];
	lblDesc.text = desc;
}

- (void)dealloc {
    [super dealloc];
}


@end
