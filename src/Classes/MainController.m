    //
//  MainController.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "MainController.h"
#import "LoginController.h"

@implementation MainController

@synthesize navViewController;
@synthesize loginController;

- (void)viewDidLoad {
	[self.view addSubview:loginController.view];
	[super viewDidLoad];
};
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
	[navViewController release];
	[loginController release];
    [super dealloc];
}
#pragma mark -
#pragma mark ButtonActions
- (IBAction)signin:(id)sender {
	
	[loginController.view removeFromSuperview];
	[self.view insertSubview:navViewController.view atIndex:0];
}

- (IBAction)signup:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apple.com"]];
}
@end
