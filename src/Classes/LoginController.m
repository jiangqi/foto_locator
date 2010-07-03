    //
//  LoginController.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "LoginController.h"
#import "MainController.h"


@implementation LoginController

@synthesize nameField;
@synthesize pwdField;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Logout";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
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
}


- (void)dealloc {
	[nameField dealloc];
	[pwdField dealloc];
    [super dealloc];
}

@end
