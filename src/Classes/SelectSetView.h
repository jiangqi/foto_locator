//
//  SelectSetView.h
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "ObjectiveFlickr.h"
#import <UIKit/UIKit.h>


@interface SelectSetView : UIViewController <OFFlickrAPIRequestDelegate> {
	NSMutableArray *btnList;
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary;
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError;
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(NSUInteger)inSentBytes totalBytes:(NSUInteger)inTotalBytes;
@end
