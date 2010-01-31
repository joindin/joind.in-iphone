//
//  EventCommentsViewCell.h
//  joindinapp
//
//  Created by Kevin on 27/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EventCommentsViewCell : UITableViewCell {
	IBOutlet UILabel *uiComment;
	IBOutlet UILabel *uiAuthor;
	
}

@property (nonatomic, retain) UILabel     *uiComment;
@property (nonatomic, retain) UILabel     *uiAuthor;

@end
