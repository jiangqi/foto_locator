//
//  ImageViewController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIImageView *imageView;
	UIImagePickerController *picker;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIImagePickerController *picker;

- (BOOL)startLibraryPickerFromViewController;

@end
