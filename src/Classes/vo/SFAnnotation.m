#import "SFAnnotation.h"

@implementation SFAnnotation 

@synthesize image;
@synthesize imageURL;


- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = lat;
    theCoordinate.longitude = lon;
    return theCoordinate; 
}

- (void)dealloc
{
    [image release];
    [super dealloc];
}

- (NSString *)title
{
    return @"Picture Spot";
}

// optional
- (NSString *)subtitle
{
	NSString *result = [NSString stringWithFormat:@"Have %d picture(s) here.", [imageURL count]];
	return result;
}

- (void)setLatitude:(double)lati {
	lat = lati;
}

- (void)setLongitude:(double)longi {
	lon = longi;
}

- (double)getLatitude {
	return lat;
}

- (double)getLongitude {
	return lon;
}

@end
