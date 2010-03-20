//
//  TracksListModel.m
//  joindinapp
//
//  Created by Kevin on 20/03/2010.
//  Copyright 2010 joind.in. All rights reserved.
//

#import "TracksListModel.h"
#import "TrackDetailModel.h"

@implementation TracksListModel

@synthesize tracks;

- (id)init {
	self.tracks = [NSMutableArray arrayWithCapacity:0];
	return self;
}

- (void)addTrack:(TrackDetailModel *)tdm {
	[tdm retain];
	[self.tracks addObject:tdm];
}

- (TrackDetailModel *)getTrackDetailModelAtIndex:(NSUInteger)idx {
	return [self.tracks objectAtIndex:idx];
}

- (NSUInteger)getNumTracks {
	return [self.tracks count];
}

- (NSString *)getStringTrackList {
	NSMutableString *output = [NSMutableString stringWithCapacity:0];
	for (TrackDetailModel *tkdm in self.tracks) {
		if ([output length] > 0) {
			[output appendString:@", "];
		}
		[output appendString:tkdm.name];
	}
	return output;
}
	
@end
