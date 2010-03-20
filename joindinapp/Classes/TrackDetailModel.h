//
//  TrackDetailModel.h
//  joindinapp
//
//  Created by Kevin on 20/03/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrackDetailModel : NSObject {
	NSString   *name;
	NSString   *desc;
	NSString   *color;
	NSUInteger  Id;
}

@property (nonatomic, retain) NSString   *name;
@property (nonatomic, retain) NSString   *desc;
@property (nonatomic, retain) NSString   *color;
@property (nonatomic, assign) NSUInteger  Id;

@end
