//
//  MainController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginController;
@class MapViewController;

@interface MainController : UIViewController {
	LoginController *loginController;
	MapViewController *mapViewController;
}

@property (nonatomic, retain) IBOutlet LoginController *loginController;
@property (nonatomic, retain) IBOutlet MapViewController *mapViewController;

@end
