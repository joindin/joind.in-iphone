//
//  APICaller.h
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIError.h"

//#define API_URL @"http://joind.in/api"
#define API_URL @"http://lorna.rivendell.local/api";
//#define API_URL @"http://lorna.adsl.magicmonkey.org/api";
//#define API_URL @"http://lorna.rivendell.local/api";

#define CACHE_TIME 86400 // In seconds

@interface APICaller : NSObject {
	id delegate;
	NSMutableData *urlData;
	NSURLConnection *connection;
	NSString *reqJSON;
	NSString *url;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableData *urlData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSString *reqJSON;
@property (nonatomic, retain) NSString *url;

- (id)initWithDelegate:(id)_delegate;
- (NSString *)getApiUrl;
- (void)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params needAuth:(BOOL)needAuth;
- (void)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params needAuth:(BOOL)needAuth canCache:(BOOL)canCache;
- (void)cancel;
- (void)gotResponse:(NSString *)responseString;
- (BOOL)checkCacheForRequest:(NSString *)_reqJSON toUrl:(NSString *)url ignoreExpiry:(BOOL)ignoreExpiry;
- (void)writeDataToCache:(NSString *)responseData requestJSON:(NSString *)_reqJSON toUrl:(NSString *)_url;

+ (void)clearCache;

// Override these methods to implement a new API call
- (void)call:(NSString *)eventType;
- (void)gotData:(NSObject *)obj;
- (void)gotError:(NSObject *)error;

@end
