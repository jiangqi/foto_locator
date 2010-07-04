    //
//  MapViewController.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "SFAnnotation.h"
#import "BridgeAnnotation.h"
#import "ImageViewController.h"

enum
{
    kCityAnnotationIndex = 0,
    kBridgeAnnotationIndex
};


@implementation MapViewController

@synthesize mapView, mapAnnotations, imageViewController, popOverController;

#pragma mark -

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}
+ (CGFloat)calloutHeight;
{
    return 40.0f;
}

- (void)gotoLocation
{
    // start off by default in San Francisco
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = (maxLat + minLat) / 2;
    newRegion.center.longitude = (maxLon + minLon) / 2;
    newRegion.span.latitudeDelta = (maxLat - minLat) + 0.01;
    newRegion.span.longitudeDelta = (maxLon - minLon) + 0.01;
	
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    // bring back the toolbar
    //[self.navigationController setToolbarHidden:NO animated:NO];
}

- (void)viewDidLoad
{
    self.mapView.mapType = MKMapTypeStandard;   // also MKMapTypeSatellite or MKMapTypeHybrid
	self.mapAnnotations = [NSMutableArray array];
	
	SFAnnotation *tempAnnotation = [SFAnnotation alloc];
	[tempAnnotation setLatitude:0];
	[tempAnnotation setLongitude:0];
	[self.mapAnnotations addObject:tempAnnotation];
	[self.mapView addAnnotation:tempAnnotation];
	[tempAnnotation release];
	[self gotoLocation];
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

- (void)pushAnnotation:(NSMutableArray *)list {
	// First let's calcluate the map range.
	minLat = 0;
	maxLat = 0;
	minLon = 0;
	maxLon = 0;
	for (int i = 0; i < [list count]; i++) {
		SFAnnotation *annotation = [list objectAtIndex:i];
		
		if (minLat == 0 || minLat >= [annotation getLatitude]) {
			minLat = [annotation getLatitude];
		}
		
		if (maxLat == 0 || maxLat <= [annotation getLatitude]) {
			maxLat = [annotation getLatitude];
		}
		
		if (minLon == 0 || minLon >= [annotation getLongitude]) {
			minLon = [annotation getLongitude];
		}
		
		if (maxLon == 0 || maxLon <= [annotation getLongitude]) {
			maxLon = [annotation getLongitude];
		}
	}
	
	if (self.mapAnnotations != nil) {
		[self.mapView removeAnnotations:self.mapView.annotations];  // remove any annotations that exist
	}
	self.mapAnnotations = [NSMutableArray array];
	for (int i = 0; i < [list count]; i++) {
		[self.mapAnnotations addObject:[list objectAtIndex:i]];
		[self.mapView addAnnotation:[list objectAtIndex:i]];
	}
	
	[self gotoLocation];    // finally goto zoom
}


- (void)dealloc {
    [super dealloc];
}
#pragma mark -
#pragma mark MKMapViewDelegate

- (void)showDetails:(id)sender
{
    // the detail view does not want a toolbar so hide it
    //[self.navigationController setToolbarHidden:YES animated:NO];
    
    //[self.navigationController pushViewController:self.imageViewController animated:YES];
	
	UIImagePickerController *p = [[UIImagePickerController alloc] init];
	p.delegate = self;
	p.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	
	p.allowsEditing = YES;

	
	UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:p];
	aPopover.delegate = self;
	
	self.popOverController = aPopover;
	
	[aPopover release];
	
	[self.popOverController presentPopoverFromRect:CGRectMake(10, 10, 300, 500) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny
										  animated:YES];	
	
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
    
        // try to dequeue an existing pin view first
        static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
			
            return customPinView;
        }
        else
        {
            pinView.annotation = annotation;
        }
        return pinView;
}


@end
