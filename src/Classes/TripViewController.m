    //
//  TripViewController.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TripViewController.h"
#import "ASIHTTPRequest.h"
#import "SFPhoto.h"


NSString *const TextContentKey = @"_text";



@implementation TripViewController
@synthesize tableView;
@synthesize mapViewController;

- (void)viewDidLoad {
	[super viewDidLoad];
    self.tableView.rowHeight = 48.0;
	[self fetchData];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tableView release];
	[super dealloc];
}


- (void)fetchData {
	
	NSURL *url = [NSURL URLWithString:@"http://localhost:3000/circule.xml"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
	

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching binary data
	NSData *responseData = [request responseData];
	circules = [SFCircule alloc];
	circules.siteList = [NSMutableArray array];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
	[parser setDelegate:self];
	[parser parse];
	[parser release];
	
	[self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	//NSError *error = [request error];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if ([elementName isEqualToString:@"circule"]) {
		elementStack = [SFCircule alloc];
		elementStack.siteList = [NSMutableArray array];
		elementStack.circuleName = [attributeDict objectForKey:@"name"];
		[circules.siteList addObject:elementStack];
	} else if ([elementName isEqualToString:@"site"]) {
		if (photoStack != nil) {
			[photoStack release];
		}
		photoStack = [SFAnnotation alloc];
		NSString *lat = [attributeDict objectForKey:@"latitude"];
		NSString *lon = [attributeDict objectForKey:@"longitude"];
		
		NSNumberFormatter *f = [[NSNumberFormatter alloc]init];
		[f setNumberStyle:NSNumberFormatterDecimalStyle];
		double d = [[f numberFromString:lat] doubleValue];
		[photoStack setLatitude:d];		
		d = [[f numberFromString:lon] doubleValue];
		[photoStack setLongitude:d];
		[f release];
		photoStack.imageURL = [NSMutableArray array];
		
		[elementStack.siteList addObject:photoStack];
		
		
	} else if ([elementName isEqualToString:@"photo"]) {
		if (photoStack == nil) {
			return;
		}
		
		SFPhoto *photo = [SFPhoto alloc];
		photo.takenTime = [attributeDict objectForKey:@"taken_time"];
		photo.thumbnailUrl = [attributeDict objectForKey:@"thumbnail_url"];
		photo.url = [attributeDict objectForKey:@"url"];
		
		[photoStack.imageURL addObject:photo];
	}

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
		
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{

}

// The number of rows is equal to the number of earthquakes in the array.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [circules.siteList count];
}

// The cell uses a custom layout, but otherwise has standard behavior for UITableViewCell.
// In these cases, it's preferable to modify the view hierarchy of the cell's content view, rather
// than subclassing. Instead, view "tags" are used to identify specific controls, such as labels,
// image views, etc.
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Each subview in the cell will be identified by a unique tag.
    static NSUInteger const kDateLabelTag = 3;
    
    // Declare references to the subviews which will display the earthquake data.
    UILabel *dateLabel = nil;
    
	static NSString *ids = @"Circule";    
  	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ids];
	if (cell == nil) {
        // No reusable cell was available, so we create a new cell and configure its subviews.
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:ids] autorelease];
        
        dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 28, 170, 14)] autorelease];
        dateLabel.tag = kDateLabelTag;
        dateLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:dateLabel];
    } else {
        // A reusable cell was available, so we just need to get a reference to the subviews
        // using their tags.
        //
        dateLabel = (UILabel *)[cell.contentView viewWithTag:kDateLabelTag];
    }
    
    SFCircule *circule = [circules.siteList objectAtIndex:indexPath.row];
    // Set the relevant data for each subview in the cell.
    dateLabel.text = circule.circuleName;	
	return cell;
}

// When the user taps a row in the table, display the USGS web page that displays details of the
// earthquake they selected.
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
    UIActionSheet *sheet =
			[[UIActionSheet alloc] initWithTitle:
					NSLocalizedString(@"What to do with the trip?",
									 @"Please select view a trip or remove it")
					delegate:self
					cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
					destructiveButtonTitle:nil
					otherButtonTitles:NSLocalizedString(@"Show Trip in Map", @"Show Trip in Map"),
								      NSLocalizedString(@"Remove Trip", @"RemoveTrip"),
				nil];
    [sheet showInView:self.view];
    [sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
	if (buttonIndex == 1) {
		// Remove
		[circules.siteList removeObjectAtIndex:selectedIndexPath.row];
		[self.tableView reloadData];
	} else {
		// View;
		SFCircule *circule = [circules.siteList objectAtIndex:selectedIndexPath.row];
		[self.mapViewController pushAnnotation:circule.siteList];
		[self.navigationController setToolbarHidden:YES animated:NO];
		[self.navigationController pushViewController:self.mapViewController animated:YES];
	}
}

@end
