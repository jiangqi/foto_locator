//
//  MainController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginController;
@class MapViewController;
@interface MainController : UIViewController {
	LoginController *loginController;
	UINavigationController *navViewController;
}

@property (nonatomic, retain) IBOutlet LoginController *loginController;
@property (nonatomic, retain) IBOutlet UINavigationController *navViewController;


- (IBAction)signin:(id)sender;
- (IBAction)signup:(id)sender;

@end
