    //
//  SelectSetView.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ObjectiveFlickr.h"
#import "SelectSetView.h"


@implementation SelectSetView
- (void)viewDidLoad {
	[super viewDidLoad];
	OFFlickrAPIContext *context = [[OFFlickrAPIContext alloc] initWithAPIKey:@"25b5ae347102682d741caa1ed7f5e17b" sharedSecret:@"7ca9284ef1b67eb9"];
	OFFlickrAPIRequest *request = [[OFFlickrAPIRequest alloc] initWithAPIContext:context];
	
	// set the delegate, here we assume it's the controller that's creating the request object
	[request setDelegate:self];
	[request callAPIMethodWithGET:@"flickr.photosets.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"16899097@N06", @"user_id", nil]];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary {
	NSArray *setArray = [inResponseDictionary valueForKeyPath:@"photosets.photoset"];
	//[[inResponseDictionary valueForKeyPath:@"photos.photo"] objectAtIndex:0];
	for (int i = 0; i < setArray.count; i++) {
		NSDictionary *setDict = [setArray objectAtIndex:i];
		NSDictionary *titleDict = [setDict valueForKey:@"title"];
		NSString *title = [titleDict valueForKey:@"_text"];
		
		UIButton *btn;// = [self buttonWithTitle:title target:nil selector:nil frame:CGRectMake(11, i * 38, 28, 25) image:nil];
		btn = [[[UIButton alloc]initWithFrame:CGRectMake(11,i * 38,28,25)]autorelease];
		[btn setTitle:title forState:UIControlStateNormal & UIControlStateHighlighted & UIControlStateSelected];
		[btnList addObject:btn];
		[self.view addSubview:btn];
	}
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError {
	int i = 0;
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(NSUInteger)inSentBytes totalBytes:(NSUInteger)inTotalBytes {
	int i = 0;
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame image:(UIImage*)image {
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[button setTitle:title forState:UIControlStateNormal & UIControlStateHighlighted & UIControlStateSelected];
	[button setTitleColor:[UIColor blackColor] forState:UIControlEventTouchDown];
	UIImage *newImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	[button setBackgroundImage:newImage forState:UIControlStateNormal];
	[button addTarget:target action:inSelector forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenDisabled = YES;
    button.adjustsImageWhenHighlighted = YES;
	[button setBackgroundColor:[UIColor clearColor]];	// in case the parent view draws with a custom color or gradient, use a transparent color
    [button autorelease];
    return button;
}

@end
