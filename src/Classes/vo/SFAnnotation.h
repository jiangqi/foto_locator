#import <MapKit/MapKit.h>

@interface SFAnnotation : NSObject <MKAnnotation>
{
    UIImage *image;
    NSNumber *latitude;
    NSNumber *longitude;
	double lat;
	double lon;
	NSMutableArray *imageURL;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableArray *imageURL;

- (void)setLatitude:(double)lat;
- (void)setLongitude:(double)lon;
- (double)getLatitude;
- (double)getLongitude;
@end


