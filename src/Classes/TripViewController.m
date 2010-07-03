    //
//  TripViewController.m
//  ImageLocater
//
//  Created by Jiang Qi on 10-7-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TripViewController.h"
#import "ASIHTTPRequest.h"


@implementation TripViewController
@synthesize tableView;

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
	[super dealloc];
}

- (void)fetchData {
	NSURL *url = [NSURL URLWithString:@"http://192.168.1.6:3000/circule.xml"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
	

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	NSString *responseString = [request responseString];
	
	// Use when fetching binary data
	NSData *responseData = [request responseData];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:responseData];
	[parser setDelegate:self];
	[parser parse];
	[parser release];
	
	listData = [currentDictionary valueForKeyPath:@"cirucles.circule"];
	[self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	NSMutableDictionary *mutableAttrDict = attributeDict ? [NSMutableDictionary dictionaryWithDictionary:attributeDict] : [NSMutableDictionary dictionary];
	
	// see if it's duplicated
	id element = [currentDictionary objectForKey:elementName];
	if (element) {
		if (![element isKindOfClass:[NSMutableArray class]]) {
			if ([element isKindOfClass:[NSMutableDictionary class]]) {
				[element retain];
				[currentDictionary removeObjectForKey:elementName];
				
				NSMutableArray *newArray = [NSMutableArray arrayWithObject:element];
				[currentDictionary setObject:newArray forKey:elementName];
				[element release];
				
				element = newArray;
			}
			else {
				
			}
		}
		
		[element addObject:mutableAttrDict];
	}
	else {
		// plural tag rule: if the parent's tag is plural and the incoming is singular, we'll make it into an array (we only handles the -s case)
		
		if ([currentElementName length] > [elementName length] && [currentElementName hasPrefix:elementName] && [currentElementName hasSuffix:@"s"]) {
			[currentDictionary setObject:[NSMutableArray arrayWithObject:mutableAttrDict] forKey:elementName];
		}
		else {
			[currentDictionary setObject:mutableAttrDict forKey:elementName];
		}
	}
	
	[elementStack insertObject:currentDictionary atIndex:0];
	currentDictionary = mutableAttrDict;
	NSString *tmp = currentElementName;
	currentElementName = [elementName retain];
	[tmp release];
}

// The number of rows is equal to the number of earthquakes in the array.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	
    return [elementStack count];
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
  	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ids];
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
    
    // Get the specific earthquake for this row.
	NSArray *array = [currentDictionary valueForKeyPath:@"circules.circule"];
	NSDictionary *circule = [array objectAtIndex:indexPath.row];
    
    // Set the relevant data for each subview in the cell.
    dateLabel.text = [circule valueForKey:@"name"];
	
	return cell;
}

// When the user taps a row in the table, display the USGS web page that displays details of the
// earthquake they selected.
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
    UIActionSheet *sheet =
	[[UIActionSheet alloc] initWithTitle:
	 NSLocalizedString(@"External App Sheet Title",
					   @"Title for sheet displayed with options for displaying Earthquake data in other applications")
								delegate:self
					   cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
				  destructiveButtonTitle:nil
					   otherButtonTitles:NSLocalizedString(@"Show USGS Site in Safari", @"Show USGS Site in Safari"),
	 NSLocalizedString(@"Show Location in Maps", @"Show Location in Maps"),
	 nil];
    [sheet showInView:self.view];
    [sheet release];
}

@end
