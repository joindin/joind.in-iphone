//
//  APICaller.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APICaller : NSObject {
	id delegate;
	NSMutableData *urlData;
	NSURLConnection *connection;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableData *urlData;
@property (nonatomic, retain) NSURLConnection *connection;

- (id)initWithDelegate:(id)_delegate;
- (NSString *)getApiUrl;
- (void)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params;
- (void)cancel;

// Override these methods to implement a new API call
- (void)call:(NSString *)eventType;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end
