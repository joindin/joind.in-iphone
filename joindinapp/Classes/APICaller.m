//
//  APICaller.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#pragma mark Other stuff

#import <CommonCrypto/CommonDigest.h>

NSString* md5( NSString *str ) {
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5( cStr, strlen(cStr), result );
	
	return [NSString
			stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1],
			result[2], result[3],
			result[4], result[5],
			result[6], result[7],
			result[8], result[9],
			result[10], result[11],
			result[12], result[13],
			result[14], result[15]
			];
}





#import "APICaller.h"
#import "JSON.h"
#import "EventListModel.h"
#import "EventDetailModel.h"
#import "TalkListModel.h"
#import "TalkDetailModel.h"




@implementation APICaller

@synthesize delegate;
@synthesize urlData;
@synthesize connection;
@synthesize reqJSON;
@synthesize url;

- (id)initWithDelegate:(id)_delegate {
	self.delegate = _delegate;
	self.urlData = [[NSMutableData alloc] init];
	return self;
}

- (NSString *)getApiUrl {
	//return @"http://lorna.rivendell.local/api";
	return @"http://joind.in/api";
}

- (BOOL)checkCacheForRequest:(NSString *)_reqJSON toUrl:(NSString *)_url ignoreExpiry:(BOOL)ignoreExpiry {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *filename = [NSString stringWithFormat:@"%@/%@.json",  [paths objectAtIndex:0], md5([NSString stringWithFormat:@"%@%@", _reqJSON, _url])];
	//NSLog(@"Cache file is %@", filename);
	NSString *result = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:NULL];
	if (result == NULL) {
		//NSLog(@"Not cached");
		return NO;
	} else {
		//NSLog(@"Cached, checking expiry...");
		NSDictionary *data = [result JSONValue];
		if (!ignoreExpiry) {
			//NSLog(@"Expiry: %i", [[data valueForKey:@"expires"] integerValue]);
			if ([[data valueForKey:@"expires"] integerValue] < [[NSDate date] timeIntervalSince1970] ) {
				//NSLog(@"Expired");
				return NO;
			}
		}
		// Store the data which made this response
		self.reqJSON = _reqJSON;
		self.url = _url;
		//NSLog(@"Returning cached data");
		[self gotResponse:[data valueForKey:@"data"]];
		return YES;
	}
}

- (void)writeDataToCache:(NSString *)responseString requestJSON:(NSString *)_reqJSON toUrl:(NSString *)_url {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSMutableDictionary *d = [NSMutableDictionary dictionaryWithCapacity:2];
	[d setObject:responseString forKey:@"data"];
	[d setObject:[NSString stringWithFormat:@"%f", [[NSDate dateWithTimeIntervalSinceNow:60.0f] timeIntervalSince1970]] forKey:@"expires"];
	NSString *filename = [NSString stringWithFormat:@"%@/%@.json", [paths objectAtIndex:0], md5([NSString stringWithFormat:@"%@%@", _reqJSON, _url])];
	[[d JSONRepresentation] writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

#pragma mark API call

- (void)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params {
	
	//NSLog(@"Type is %@, action is %@, params are %@", type, action, params);
	
	NSMutableDictionary *reqAuth = [[NSMutableDictionary alloc] initWithCapacity:2];
	[reqAuth setObject:@"kevin" forKey:@"user"];
	[reqAuth setObject:@"6228bd57c9a858eb305e0fd0694890f7" forKey:@"pass"];
	
	NSMutableDictionary *reqAction = [[NSMutableDictionary alloc] initWithCapacity:2];
	[reqAction setObject:action forKey:@"type"];
	if (params != nil) {
		[reqAction setObject:params forKey:@"data"];
	} else {
		[reqAction setObject:[NSNull null] forKey:@"data"];
	}
	
	NSMutableDictionary *reqRequest = [[NSMutableDictionary alloc] initWithCapacity:2];
	[reqRequest setObject:reqAuth forKey:@"auth"];
	[reqRequest setObject:reqAction forKey:@"action"];
	
	NSMutableDictionary *reqObject = [[NSMutableDictionary alloc] initWithCapacity:1];
	[reqObject setObject:reqRequest forKey:@"request"];
	
	self.reqJSON = [reqObject JSONRepresentation];
	
	[reqRequest release];
	[reqAuth    release];
	[reqAction  release];
	[reqObject  release];

	//NSLog(@"JSON request is %@", reqJSON);
	
	self.url = [NSString stringWithFormat:@"%@/%@", [self getApiUrl], type];
	
	if (![self checkCacheForRequest:self.reqJSON toUrl:self.url ignoreExpiry:NO]) {
		NSMutableURLRequest *req;
		req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:3.0f];
		[req setHTTPBody:[self.reqJSON dataUsingEncoding:NSUTF8StringEncoding]];
		[req setHTTPMethod:@"POST"];
		[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		
		// Make asynchronous request (and store it in case it needs to be cancelled)
		self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
		[req release];
	}
	
}

- (void)cancel {
	[self.connection cancel];
}

#pragma mark URL callback methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if (![self checkCacheForRequest:self.reqJSON toUrl:self.url ignoreExpiry:YES]) {
		[self gotResponse:nil];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Network error" 
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		[self gotResponse:nil];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.urlData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *responseString = [[NSString alloc] initWithData:self.urlData encoding:NSUTF8StringEncoding];
	
	// Reset buffer
	[self.urlData release];
	self.urlData = [[NSMutableData alloc] init];
	
	[self writeDataToCache:responseString requestJSON:self.reqJSON toUrl:self.url];
	
	[self gotResponse:responseString];
	[responseString release];

}

- (void)gotResponse:(NSString *)responseString {	
	// Parse response
	//NSLog(@"Response is %@", responseString);
	SBJSON *jsonParser = [SBJSON new];
	NSObject *obj = [jsonParser objectWithString:responseString error:NULL];
	//NSLog(@"Got obj %@", obj);
	[jsonParser release];
	[self gotData:obj];
}

#pragma mark Override these
- (void)call:(NSString *)eventType {
	[self doesNotRecognizeSelector:_cmd];
}
- (void)gotData:(NSObject *)obj {
	[self doesNotRecognizeSelector:_cmd];
}
- (void)gotError:(NSObject *)error {
	[self doesNotRecognizeSelector:_cmd];
}

@end

