//
//  SFPhoto.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SFPhoto : NSObject {
	NSString *takenTime;
	NSString *thumbnailUrl;
	NSString *url;
}

@property (nonatomic, retain) IBOutlet NSString *takenTime;
@property (nonatomic, retain) IBOutlet NSString *thumbnailUrl;
@property (nonatomic, retain) IBOutlet NSString *url;

@end
