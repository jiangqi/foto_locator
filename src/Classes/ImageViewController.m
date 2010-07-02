    //
//  ImageViewController.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"


@implementation ImageViewController

@synthesize imageView, picker;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view addSubview:picker.view];
	/*
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
	 */
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[picker release];
    [super dealloc];
}

- (BOOL)startLibraryPickerFromViewController {
	UIImagePickerController *p = [[UIImagePickerController alloc] init];
	p.delegate = self;
	p.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

	p.allowsEditing = YES;
	[self.view addSubview:p.view];
	
	return YES;
}

@end
