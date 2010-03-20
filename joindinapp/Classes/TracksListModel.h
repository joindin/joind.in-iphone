//
//  TracksListModel.h
//  joindinapp
//
//  Created by Kevin on 20/03/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackDetailModel.h"

@interface TracksListModel : NSObject {
	NSMutableArray *tracks;
}

@property(nonatomic, retain) NSMutableArray *tracks;

- (id)init;
- (void)addTrack:(TrackDetailModel *)tdm;
- (TrackDetailModel *)getTrackDetailModelAtIndex:(NSUInteger)idx;
- (NSUInteger)getNumTracks;
- (NSString *)getStringTrackList;

@end
