//
//  ImageLocaterAppDelegate.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ImageLocaterAppDelegate.h"
#import "MainController.h"

@implementation ImageLocaterAppDelegate;

@synthesize window, mainController;

- (void)dealloc
{
	[mainController release];
    [window release];
	
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    [window addSubview:mainController.view];
    [window makeKeyAndVisible];
}

@end
