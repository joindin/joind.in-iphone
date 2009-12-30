//
//  FirstViewController.h
//  joindinapp
//
//  Created by Kevin on 29/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *confListTableView;
	NSObject *confListData;
}

@property(nonatomic, retain) NSObject *confListData;

// Interface builder links
@property (nonatomic, retain) IBOutlet UITableView *confListTableView;
-(IBAction) buttonPressed:(id)sender;

// UIAlertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

// UITableViewDataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

// Other methods
- (NSObject *)callAPI:(NSString *)type action:(NSString *)action params:(NSArray *)params;

@end
