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

@implementation APICaller

+ (EventListModel *)GetEventList {
	NSObject *obj = [APICaller callAPI:@"event" action:@"getlist" params:[NSDictionary dictionaryWithObject:@"upcoming" forKey:@"event_type"]];
	NSDictionary *d = (NSDictionary *)obj;
	
	EventListModel *elm = [[EventListModel alloc] init];
	
	for (NSDictionary *event in d) {
		
		NSLog(@"Event is %@", event);
		EventDetailModel *edm = [[EventDetailModel alloc] init];
		edm.name        = [event objectForKey:@"event_name"];
		edm.start       = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_start"] integerValue]];
		edm.end         = [NSDate dateWithTimeIntervalSince1970:[[event objectForKey:@"event_end"]   integerValue]];
		edm.Id          = [[event objectForKey:@"ID"] integerValue];
		edm.location    = [event objectForKey:@"event_loc"];
		edm.description = [event objectForKey:@"event_desc"];
		edm.active      = [[event objectForKey:@"active"] integerValue];
		edm.stub        = [event objectForKey:@"event_stub"];
		edm.tzOffset    = [[event objectForKey:@"event_tz"] integerValue];
		
		[elm addEvent:edm];
		[edm release];
	}
	
	return elm;
}

+ (NSObject *)callAPI:(NSString *)type action:(NSString *)action params:(NSDictionary *)params {
	
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

	//NSLog(@"JSON request is %@", reqJSON);
	
	NSMutableURLRequest *req;
	req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://joind.in/api/event"]];
	[req setHTTPBody:[reqJSON dataUsingEncoding:NSUTF8StringEncoding]];
	[req setHTTPMethod:@"POST"];
	[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:req
									returningResponse:&response
												error:&error];
	[req release];
	
	NSString *responseString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	//NSLog(@"Response is %@", responseString);
	SBJSON *jsonParser = [SBJSON new];
	NSObject *obj = [jsonParser objectWithString:responseString error:NULL];
	[jsonParser release];
	[responseString release];
	return obj;
}

@end
