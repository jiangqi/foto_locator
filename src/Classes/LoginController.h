//
//  LoginController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapViewController;


@interface LoginController : UIViewController {
	UITextField *nameField;
	UITextField *pwdField;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *pwdField;

@end