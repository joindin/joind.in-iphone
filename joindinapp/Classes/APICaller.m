//
//  APICaller.m
//  joindinapp
//
//  Created by Kevin on 01/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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

- (id)initWithDelegate:(id)_delegate {
	self.delegate = _delegate;
	self.urlData = [[NSMutableData alloc] init];
	return self;
}

- (NSString *)getApiUrl {
	//return @"http://lorna.rivendell.local/api";
	return @"http://joind.in/api";
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
	
	NSString *reqJSON = [reqObject JSONRepresentation];
	
	[reqRequest release];
	[reqAuth    release];
	[reqAction  release];
	[reqObject  release];

	NSLog(@"JSON request is %@", reqJSON);
	
	NSMutableURLRequest *req;
	req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", [self getApiUrl], type]]];
	[req setHTTPBody:[reqJSON dataUsingEncoding:NSUTF8StringEncoding]];
	[req setHTTPMethod:@"POST"];
	[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	// Make synchronous request
	self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
	[req release];
	
}

- (void)cancel {
	[self.connection cancel];
}

#pragma mark URL callback methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
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
	
	// Parse response
	//NSLog(@"Response is %@", responseString);
	SBJSON *jsonParser = [SBJSON new];
	NSObject *obj = [jsonParser objectWithString:responseString error:NULL];
	[jsonParser release];
	[responseString release];
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
