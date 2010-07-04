//
//  TripViewController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAnnotation.h"
#import "SFCircule.h"
#import "MapViewController.h"

@interface TripViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate> {
	
	UITableView *tableView;
	
	MapViewController *mapViewController;
	
@private
	SFCircule *elementStack;
	SFAnnotation *photoStack;
	SFCircule *circules;

}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet MapViewController *mapViewController;

- (void)fetchData;


@end
