//
//  MapViewController.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-6-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class ImageViewController;

@interface MapViewController : UIViewController <MKMapViewDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	MKMapView *mapView;
	ImageViewController *imageViewController;
    NSMutableArray *mapAnnotations;
	UIPopoverController *popOverController;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet ImageViewController *imageViewController;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) IBOutlet UIPopoverController *popOverController;

+ (CGFloat)annotationPadding;
+ (CGFloat)calloutHeight;

- (IBAction)cityAction:(id)sender;
- (IBAction)bridgeAction:(id)sender;
- (IBAction)allAction:(id)sender;
@end
