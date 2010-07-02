//
//  ImageLocaterAppDelegate.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainController;

@interface ImageLocaterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	MainController *mainController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainController *mainController;
@end

