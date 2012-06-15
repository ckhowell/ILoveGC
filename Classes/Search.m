//
//  Categories.m
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ILoveGCAppDelegate.h"
#import "Search.h"
#import "Event.h"
#import "AppEvents.h"
#import "Alarms.h"


#define kCustomRowHeight 63.0


@interface Search ()

- (void)startIconDownload:(AppEvents *)appRecord forIndexPath:(NSIndexPath *)indexPath;

@end


@implementation Search

@synthesize searchBar, tableView, list, datef, searchArray, alarmButton;
@synthesize tabledata, imageDownloadsInProgress, last, activity, datef2;

@synthesize loading_iv, loading_lb;

-(void) viewDidLoad{	
	[super viewDidLoad];
	
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	
	self.tableView.rowHeight = kCustomRowHeight;
	self.navigationItem.title = @" ";
	
	tabledata = [[NSMutableArray alloc] init];	
	
	b = -1;
	textChanged = NO;
	
	last = [[NSMutableArray alloc] init];
	
    loading_lb = [[UILabel alloc] initWithFrame:CGRectMake(50, -40, 220, 20)];
    loading_lb.backgroundColor = [UIColor clearColor];
    loading_lb.textColor = [UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:109.0/255.0 alpha:1.0];
    loading_lb.font = [UIFont boldSystemFontOfSize:16];
    loading_lb.textAlignment = UITextAlignmentCenter;
    [loading_lb setText:@"Pull down to refresh..."];
    
    loading_iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, -50, 22, 41)];
    loading_iv.image = [UIImage imageNamed:@"arrow_down"];
    [loading_iv setTag:100];
    
}

- (UIImage*) maskImage:(UIImage *)image  {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIImage *maskImage = [UIImage imageNamed:@"circle.png"];
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    } 
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	UIImageView *navigationBarView = [[UIImageView alloc] 
									  initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width/2 - 25, self.navigationController.navigationBar.frame.size.height/2 - 10, 
															   71,
															   21)];
    [navigationBarView setImage:[UIImage imageNamed:@"topbar_logo.png"]];
	
    navigationBarView.tag = 1;
    
    
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it then add it so it doesn't double it", __FUNCTION__);
        [testImgView removeFromSuperview];
        
    } else {
        NSLog(@"%s no there isn't a bg image so add it ", __FUNCTION__);
    }
    
    
    
	[self.navigationController.navigationBar addSubview:navigationBarView];
	[navigationBarView release];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_default.png"]]];
    
	//self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0];
}


/*- (void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	
	if(g == -1){
		//AppEvents *apl = [tabledata objectAtIndex:b];
		//apl.intr3 = 0;
		b = -1;
		for(AppEvents *ap in tabledata){
			if(ap.intr3 = 1){
				ap.intr3 = 1;
				ap.index3 = 0;
				ap.img3 = 0;
				g = 0;
			}
		}
	}

	//[tabledata removeAllObjects];
	//[tabledata addObjectsFromArray:list];
	[self.tableView reloadData];
}*/


- (NSDateFormatter *)datef {
    if (datef == nil) {
        datef = [[NSDateFormatter alloc] init];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMMM yyyy"];
	}
    return datef;
}

- (NSDateFormatter *)datef2 {
    if (datef2 == nil) {
        datef2 = [[NSDateFormatter alloc] init];
		[datef2 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef2 setTimeZone:[NSTimeZone localTimeZone]];
		[datef2 setDateFormat:@"dd MMMM yyyy"];
	}
    return datef2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [tabledata count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSUInteger const TitleLabelTag = 2;
	static NSUInteger const LocationLabelTag = 3;
	static NSUInteger const DateLabelTag = 4;
	static NSUInteger const AccesoryTag = 5;
	//static NSUInteger const AlarmButtonTag = 6;
    
	
	UIImageView *accesory;
	UILabel *titleLabel = nil;
	UILabel *locationLabel = nil;
	UILabel *dateLabel = nil;
	
	static NSString *CellIdentifier = @"EventsTableCell";
	
	int nodeCount = [tabledata count];	
	
	AppEvents *appRecord = [tabledata objectAtIndex:indexPath.row];
	
	NSCalendar *calendar = [NSCalendar currentCalendar];			
	NSDateComponents *components = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | 
														 kCFCalendarUnitDay) fromDate:appRecord.date];
	
	NSDateComponents *components2 = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | 
														  kCFCalendarUnitDay) fromDate:appRecord.date2];			
	int year = [components year];
	int month = [components month];
	int day = [components day];
	
	int year2 = [components2 year];
	int month2 = [components2 month];
	int day2 = [components2 day];	
	
	if(month==month2 && year==year2 && day==day2){
		appRecord.date2 = nil;
		[self.datef setDateFormat:@"dd MMMM yyyy"];
	}
	else if(month==month2 && year==year2){
		[self.datef setDateFormat:@"dd"];
	}
	else {
		[self.datef setDateFormat:@"dd MMMM yyyy"];
	}
	
	
	int n = appRecord.intr3;	
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		
		titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 20, 215, 20)] autorelease];
		titleLabel.tag = TitleLabelTag;
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:16];
		[cell.contentView addSubview:titleLabel];
		
		locationLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 43, 215, 14)] autorelease];
		locationLabel.tag = LocationLabelTag;
		locationLabel.backgroundColor = [UIColor clearColor];
		locationLabel.font = [UIFont italicSystemFontOfSize:12];
		[cell.contentView addSubview:locationLabel];
		
		dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 6, 215, 14)] autorelease];
		dateLabel.tag = DateLabelTag;
		dateLabel.backgroundColor = [UIColor clearColor];
		dateLabel.font = [UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:dateLabel];
		
		
		/*alarmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		alarmButton.frame = CGRectMake(250, 4, 25, 55);
		alarmButton.backgroundColor = [UIColor clearColor];
		alarmButton.tag = AlarmButtonTag;
		[alarmButton setUserInteractionEnabled:YES];
		[alarmButton setHidden:NO];
		[cell.contentView addSubview:alarmButton];
		[alarmButton addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];
		*/
		
		accesory = [[[UIImageView alloc] initWithFrame:CGRectMake(286.6, 20.2, 22.8, 22.8)] autorelease];
		accesory.tag = AccesoryTag;
		[cell.contentView addSubview:accesory];
        
        
        if (indexPath.row == 0) {
        //    [cell.contentView addSubview:loading_iv];
         //   [cell.contentView addSubview:loading_lb];
        }
		
	}
	else{
		
		titleLabel = (UILabel *)[cell.contentView viewWithTag:TitleLabelTag];
		locationLabel = (UILabel *)[cell.contentView viewWithTag:LocationLabelTag];
		dateLabel = (UILabel *)[cell.contentView viewWithTag:DateLabelTag];
		//alarmButton = (UIButton *)[cell.contentView viewWithTag:AlarmButtonTag];
		accesory = (UIImageView *)[cell.contentView viewWithTag:AccesoryTag];
	}
	
	if (nodeCount > 0)
	{
		if(n == 0){
			UIImageView *aview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 63)];
			aview.image = [UIImage imageNamed:@"back_tab_OFF.png"];
			cell.backgroundView = aview;	
			
			/*titleLabel.textColor = [UIColor whiteColor];
			locationLabel.textColor = [UIColor whiteColor];
			dateLabel.textColor = [UIColor grayColor];*/
            titleLabel.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
            locationLabel.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
            dateLabel.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];
            
			
			/*UIImage *buttonImage;
			if ([appRecord.alarmbut isEqual:@"aa"]) {
				buttonImage = [UIImage imageNamed:@"bell_magenta.png"];
				[alarmButton setImage:buttonImage forState:UIControlStateNormal];
			}*/
		}
		else{
			UIImageView *aview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 63)];
			aview.image = [UIImage imageNamed:@"back_tab_ON.png"];
			cell.backgroundView = aview;	
			
			titleLabel.textColor = [UIColor blackColor];
			locationLabel.textColor = [UIColor blackColor];
			dateLabel.textColor = [UIColor grayColor];
			
			/*UIImage *buttonImage;
			if ([appRecord.alarmbut isEqual:@"aa"]) {
				buttonImage = [UIImage imageNamed:@"bell_magenta.png"];
				[alarmButton setImage:buttonImage forState:UIControlStateNormal];
			}*/
		}
		
		
		/*if([appRecord.alarmbut isEqual:@"aa"]){
			[alarmButton setUserInteractionEnabled:YES];
			[alarmButton setHidden:NO];
		}
		else{
			[alarmButton setUserInteractionEnabled:NO];
			[alarmButton setHidden:YES];	
		}	*/
		
		
		titleLabel.text = appRecord.eventTitle;
		locationLabel.text = [appRecord.region capitalizedString];
		
		if(appRecord.date2 == nil && appRecord.date != nil){
			dateLabel.text = [NSString stringWithFormat:@"%@", [self.datef stringFromDate:appRecord.date]];
		}
		else{
			if(appRecord.date == nil){
				dateLabel.text = @"";
			}
			else{
				dateLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.datef stringFromDate:appRecord.date], [self.datef2 stringFromDate:appRecord.date2]];	
			}
		}
		
		
		if (!appRecord.eventImage)
		{
			if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
			{
				if(![appRecord.imageURLString isEqualToString:@""]){
					[self startIconDownload:appRecord forIndexPath:indexPath];	
				}
				
			}
			// if a download is deferred or in progress, return a placeholder image
			cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
		}	                
		else
		{
			cell.imageView.image =[self maskImage:appRecord.eventImage];// appRecord.eventImage;
			
		}	

		
		if (appRecord.img2 == 1){
			if ([appRecord.category isEqualToString:@"Arts"]) {
                UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_arts.png"];
                accesory.image = indicatorImage2;
                
            }
            if ([appRecord.category isEqualToString:@"Community"]) {
                UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_comm.png"];
                accesory.image = indicatorImage2;
                
            }
            if ([appRecord.category isEqualToString:@"Food"]) {
                UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_food.png"];
                accesory.image = indicatorImage2;
                
            }
            if ([appRecord.category isEqualToString:@"Sport"]) {
                UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_sports.png"];
                accesory.image = indicatorImage2;
            }

		}
		else {
			
			if ([appRecord.category isEqualToString:@"Arts"]) {
                UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_arts.png"];
                accesory.image = indicatorImage;
                
            }
            if ([appRecord.category isEqualToString:@"Community"]) {
                UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_comm.png"];
                accesory.image = indicatorImage;
                
            }
            if ([appRecord.category isEqualToString:@"Food"]) {
                UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_food.png"];
                accesory.image = indicatorImage;
                
            }
            if ([appRecord.category isEqualToString:@"Sport"]) {
                UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_sports.png"];
                accesory.image = indicatorImage;
            }
//			accesory.image = indicatorImage;
		}
	}	
		
	return cell;			
}


- (void)didPressedButton:(UIButton *)sender 
{
	Alarms *alar = [[Alarms alloc] init];
	
	alar.ape = [tabledata objectAtIndex:[self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row];
	//objindex = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ObjIndex" object:alar.ape];
	
	[self.navigationController pushViewController:alar animated:YES];
	
	[alar release];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
		//[tabledata addObjectsFromArray:list];
		//[self.tableView reloadData];
	[self.searchBar resignFirstResponder];
	
	AppEvents *selectedEvent = [tabledata objectAtIndex:indexPath.row];
	
	Event *evn = [[Event alloc] init];
	
	evn.events = [[NSMutableArray alloc] init];
	[evn.events addObjectsFromArray:searchArray];

	evn.isShowAll = YES;
	evn.event = selectedEvent;
	evn.fromCategories = NO;
	evn.fromFavourites = NO;
	evn.fromMaps = NO;
	evn.fromSearch = YES;
	
	ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UINavigationController *navigationController = app.searchController;
	
	[navigationController pushViewController:evn animated:YES];
	
	selectedEvent.img3 = 1;
	selectedEvent.intr3 = 1;
	selectedEvent.index3 = indexPath.row; 
	
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	[ary  addObject:selectedEvent];
	
	if(b != -1){
		AppEvents *ap = [[AppEvents alloc] init];
		ap = [tabledata objectAtIndex:b];
		if(![ap.eventTitle isEqual:selectedEvent.eventTitle]){
			ap.intr3 = 0;
			ap.img3 = 0;
			[ary addObject:ap];
		}
		else if(ap.idcod != selectedEvent.idcod){
			ap.intr3 = 0;
			ap.img3 = 0;
			[ary addObject:ap];
		}
	}
	
	b = indexPath.row;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"RWTable" object:ary];
	
	[selectedEvent release];
	[evn release];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	[self.searchBar setShowsCancelButton:YES animated:YES];
	self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	self.searchBar.text = nil;
	[self.searchBar setShowsCancelButton:NO animated:YES];
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	
	textChanged = YES;
	g = -1;
	[tabledata removeAllObjects];
	if([searchText isEqualToString:@""]){
		
		[tableView reloadData];
		return;
	}
	
	//NSInteger counter = 0;
	
	for(AppEvents *ap in list)
	{
			
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
		
		//NSComparisonResult result = [ap.eventTitle compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0,  [searchText length])];
		
		if ([[ap.eventTitle lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound){
		//if (result == NSOrderedSame)
		//{
				if(g == -1){
					for(AppEvents *ap in list){
						if(ap.intr3 = 1){
							ap.intr3 = 0;
							ap.index3 = 0;
							ap.img3 = 0;
						}
					}
				}			
			
				[tabledata addObject:ap];
		//}
		}
		
		/*NSRange r = [name rangeOfString:searchText];
		if(r.location != NSNotFound)
		{
			if(r.location== 0)
			{
				[tabledata addObject:name];
			}
		}*/
		
		
		//counter++;
		
		[pool release];
		
	}
	
	if ([tabledata count] != 0) {
		if (!activity) {
			activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activity.center = CGPointMake(160,200);	
            activity.color = [UIColor blackColor];
			[self.view addSubview: activity];
			[activity startAnimating];	
			self.tableView.userInteractionEnabled = NO;	
		}
	}
	
	if ([self.tabledata count] > 6) {
		NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
		for (int i=0;i<[visiblePaths count];i++) {
			int n = [[visiblePaths objectAtIndex:i] row];
			AppEvents *ap = [self.tabledata objectAtIndex:n];
			if (ap.eventImage != nil) {
				[activity stopAnimating];
				[activity setHidden:YES];
				activity = nil;
				self.tableView.userInteractionEnabled = YES;	
			}
		}
	}
	else {
		if ([tabledata count] == 0) {
			[activity stopAnimating];
			[activity setHidden:YES];
			activity = nil;
		}
		else {
			for (int i=0;i<[tabledata count];i++) {
				AppEvents *ap = [self.tabledata objectAtIndex:i];
				if (ap.eventImage != nil) {
					[activity stopAnimating];
					[activity setHidden:YES];
					activity = nil;
					self.tableView.userInteractionEnabled = YES;	
				}
			}
		}
	}

	
	[tableView reloadData];
	b = -1;
	
	NSDate *acum = [NSDate date];
	acum = [acum dateByAddingTimeInterval:3];
	NSTimer *tim = [[NSTimer alloc] initWithFireDate:acum interval:0 target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
	
	NSRunLoop *runner = [NSRunLoop mainRunLoop];
	[runner addTimer:tim forMode: NSDefaultRunLoopMode];
	[tim release];	
}

-(void)stopAnimation{
	[activity stopAnimating];
	[activity setHidden:YES];
	activity = nil;
	self.tableView.userInteractionEnabled = YES;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[activity stopAnimating];
	[activity setHidden:YES];
	activity = nil;
	
	if (textChanged == YES) {
		[tabledata removeAllObjects];
		[tabledata addObjectsFromArray:last];
	//[tabledata addObjectsFromArray:list];
	
		@try{
			[tableView reloadData];
		}
		@catch(NSException *e){
			
		}
		textChanged = NO;
	}

	[self.searchBar resignFirstResponder];
	self.searchBar.text = @"";
}
	
	
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	textChanged = NO;
	[self.searchBar resignFirstResponder];
	g = -1;
	[last removeAllObjects];
	[last addObjectsFromArray:tabledata];
}



- (void)startIconDownload:(AppEvents *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.tabledata count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            AppEvents *appRecord = [self.tabledata objectAtIndex:indexPath.row];
            
			if (!appRecord.eventImage) // avoid the app icon download if the app already has an icon
			{
				[self startIconDownload:appRecord forIndexPath:indexPath];
			}
        }
    }
}


// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
		
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];     
		// Display the newly loaded image
		
		//NSLog(@"%d", iconDownloader.indexPathInTableView.row);
		cell.imageView.image = [self maskImage:iconDownloader.appRecord.eventImage];//iconDownloader.appRecord.eventImage;
		
		[activity stopAnimating];
		[activity setHidden:YES];
		activity = nil;
		self.tableView.userInteractionEnabled = YES;
    }
}


// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[activity startAnimating];
	self.tableView.userInteractionEnabled = NO;
	
	NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
	for (int i=0;i<[visiblePaths count];i++) {
		int n = [[visiblePaths objectAtIndex:i] row];
		AppEvents *ap = [self.tabledata objectAtIndex:n];
		if (ap.eventImage != nil) {
			[activity stopAnimating];
			[activity setHidden:YES];
			activity = nil;
			self.tableView.userInteractionEnabled = YES;	
		}
	}
	
    [self loadImagesForOnscreenRows];
	
	NSDate *acum = [NSDate date];
	acum = [acum dateByAddingTimeInterval:3];
	NSTimer *tim = [[NSTimer alloc] initWithFireDate:acum interval:0 target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
	
	NSRunLoop *runner = [NSRunLoop mainRunLoop];
	[runner addTimer:tim forMode: NSDefaultRunLoopMode];
	[tim release];	
}




- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
	NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
	[allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
}

- (void)viewDidUnload {
    [super viewDidUnload];

	self.searchArray = nil;
}


- (void)dealloc {
	
	[alarmButton release];
	[last release];
	[tabledata release];
	[searchArray release];
	[datef release];
	[list release];
	[tableView release];
	[searchBar release];
	[imageDownloadsInProgress release];
	
    [loading_lb release];
    [loading_iv release];
    
    [super dealloc];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView.contentOffset.y < -50) {
        if (loading_iv.tag == 100) {
            [loading_iv setTag:101];
            
            CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            spinAnimation.duration = 0.3;
            spinAnimation.fromValue = [NSNumber numberWithFloat:0];
            spinAnimation.toValue = [NSNumber numberWithFloat:-M_PI];
            [loading_iv.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
            loading_iv.transform = CGAffineTransformMakeRotation(-M_PI);
            
            loading_lb.text = @"Release to refresh...";
        }
	}
    else {
        if (loading_iv.tag == 101) {
            [loading_iv setTag:100];
            
            CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            spinAnimation.duration = 0.3;
            spinAnimation.fromValue = [NSNumber numberWithFloat:-M_PI];
            spinAnimation.toValue = [NSNumber numberWithFloat:0];
            [loading_iv.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
            
            loading_iv.transform = CGAffineTransformMakeRotation(0);
            
            
            loading_lb.text = @"Pull down to refresh...";
        }
    }
}

@end
