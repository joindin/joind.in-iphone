//
//  Copyright (c) 2010, Kevin Bowman
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  
//  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//  * Neither the name of the organisation (joind.in) nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "EventListModel.h"
#import "EventDetailModel.h"


@implementation EventListModel

@synthesize events;

- (EventListModel *)init {
	self.events = [NSMutableArray array];
	return self;
}

- (void)addEvent:(EventDetailModel *)edm {
	[edm retain];
	[self.events addObject:edm];
}

- (EventDetailModel *)getEventDetailModelAtIndex:(NSUInteger)idx {
	return [self.events objectAtIndex:idx];
}

- (void)sort {
	[self sort:true];
}

- (void)sort:(BOOL)forwards {
	[self.events sortUsingSelector:@selector(comparator:)];
	if (!forwards) {
		// Reverse the array
		int n = (int)[self.events count];
		for (int i=0; i<n/2; ++i) {
			id c  = [self.events objectAtIndex:i];
			[self.events replaceObjectAtIndex:i withObject:[self.events objectAtIndex:n-i-1]];
			[self.events replaceObjectAtIndex:n-i-1 withObject:c];
		}
	}
}

- (NSUInteger)getNumEvents {
	return [self.events count];
}


@end
