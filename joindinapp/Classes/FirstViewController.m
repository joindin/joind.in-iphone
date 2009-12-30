//
//  FirstViewController.m
//  joindinapp
//
//  Created by Kevin on 29/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FirstViewController.h"

#import "JSON.h"


@implementation FirstViewController

@synthesize confListTableView;
@synthesize confListData;

-(IBAction) buttonPressed:(id)sender {
	/*
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Debug" 
													message:@"Hello world"
												   delegate:self 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	*/
	self.confListData = [self callAPI:@"event" action:@"getlist" params:nil];
	
	confListTableView.dataSource = self;
	[confListTableView reloadData];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSObject *localConfListData = self.confListData;
	UITableViewCell *vc;
	vc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
	[vc autorelease];
	
	// Bury into the data struct - this will be farmed out to a model
	NSArray *tempA = (NSArray *)localConfListData;
	NSUInteger idx = [indexPath indexAtPosition:1];
	NSDictionary *tempB = (NSDictionary *)[tempA objectAtIndex:idx];
	
	NSString *label = [[[NSString alloc] initWithString:[tempB objectForKey:@"event_name"]] autorelease];
	
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
	NSDateComponents *startDate = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate dateWithTimeIntervalSince1970:[[tempB objectForKey:@"event_start"] integerValue]]];	
	NSDateComponents *endDate = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate dateWithTimeIntervalSince1970:[[tempB objectForKey:@"event_end"] integerValue]]];	
	
	vc.textLabel.text = label;
	vc.detailTextLabel.text = [NSString stringWithFormat:@"%d/%d/%d - %d/%d/%d", [startDate day], [startDate month], [startDate year], [endDate day], [endDate month], [endDate year]];
	
	NSLog(@"Index %d, label %@, indexPath %@", idx, label, indexPath);
	
	return vc;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *confs = (NSArray *)confListData;
	return [confs count];
}

- (NSObject *)callAPI:(NSString *)type action:(NSString *)action params:(NSArray *)params {
	NSMutableURLRequest *req;
	req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://joind.in/api/event"]];
	NSString *body = @"<request><auth><user>kevin</user><pass>6228bd57c9a858eb305e0fd0694890f7</pass></auth><action type='getlist'><event_type>upcoming</event_type></action></request>";
	[req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	[req setHTTPMethod:@"POST"];
	[req setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	
	
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:req
									returningResponse:&response
												error:&error];
	[req release];
	
	NSString *responseString = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
	SBJSON *jsonParser = [SBJSON new];
	NSObject *obj = [jsonParser objectWithString:responseString error:NULL];
	[jsonParser release];
	[responseString release];
	return obj;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
