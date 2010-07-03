//
//  TripViewController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TripViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	
	NSMutableArray *listData;
	UITableView *tableView;
	
@private
    // for downloading the xml data
    
	NSMutableDictionary *currentDictionary;
	
	NSString *currentElementName;
	NSMutableArray *elementStack;
}

@property (nonatomic, retain) IBOutlet NSMutableData *listData;

@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (void)fetchData;


@end
