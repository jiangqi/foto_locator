//
//  SFCircule.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SFCircule : NSObject {
	NSString *circuleName;
	NSMutableArray *siteList;
}

@property (nonatomic, retain) IBOutlet NSString *circuleName;
@property (nonatomic, retain) IBOutlet NSMutableArray *siteList;

@end
