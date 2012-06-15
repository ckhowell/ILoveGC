//
//  MyProjectAppDelegate.m
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ILoveGCAppDelegate.h"
#import "Categories.h"
#import "Favourites.h"
#import "ParseOperation.h"
#import "Maps.h"
#import "More.h"
#import "StartView.h"
#import "EventAlert.h"
#import "Search.h"
#import "SHKTwitter2.h"
//#import "SHKFacebook.h"
#import <CFNetwork/CFNetwork.h>


//@"http://earthquake.usgs.gov/eqcenter/catalogs/7day-M2.5.xml";
//http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wpa/MRSS/newreleases/limit=300/rss.xml
//http://www.b-0.info/xml_form/events.xml


@implementation ILoveGCAppDelegate

@synthesize window, aTabBarController, windowiPad;
@synthesize more, search, searchController, lastSesion, allPages;
@synthesize navigationController1, navigationController3, navigationController2, navigationController4;
@synthesize categories, eventlist, queue, appListFeedConnection, appListData, eve;
@synthesize fav, map, splashView, event, eventlist2, i, eval, alert, eventlist3, objindex, showMapClicked;
@synthesize strMenuSelected;

//@synthesize delegate;

#pragma mark -
#pragma mark Application lifecycle


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    
   // [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
	
	applicationStart = YES;
	connectionInterrupted = NO;
	categories.connectionInterrupted = NO;
	showMapClicked = NO;
	allPages = [[NSMutableArray alloc] init];
	
	[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	
	
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	splashView.image = [UIImage imageNamed:@"Splash.png"];
	[window addSubview:splashView];
	
	[window makeKeyAndVisible];	
	
	remove = NO;
	[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeSplash:) userInfo:nil repeats:NO];	
	
	[self performSelector:@selector(refreshEvents:) withObject:nil];
	
    
    //----------------------------Setting up navigations
  //  navigationController1 = [self customizedNavigationController];
    
    
    //==================================================
    
    
	/*self.eventlist = [NSMutableArray array];
	self.eventlist3 = [NSMutableArray array];
	categories.listOfEvents = self.eventlist;
	search.list = self.eventlist3;
    
	NSString *feed = @"https://ilove.qnetau.com/event_data.xml";
	
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:feed]];
	self.appListFeedConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];

    NSAssert(self.appListFeedConnection != nil, @"Failure to create URL connection.");*/
	
	
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(refreshTable:)
											     name:@"RefreshTable" 
											   object:nil];		
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(redrawTable:)
											     name:@"RedrawTable" 
											   object:nil];		
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(rewTable:)
											     name:@"RewTable" 
											   object:nil];		
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(rwTable:)
											     name:@"RWTable" 
											   object:nil];	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(notifications:)
											     name:@"Notifications" 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(refreshEvents:)
											     name:@"RefreshEvents" 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(categAlarm:)
											     name:@"CategAlarm" 
											   object:nil];	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(objIndex:)
											     name:@"ObjIndex" 
											   object:nil];	

	/*[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(rememObj:)
											     name:@"RememObj" 
											   object:nil];*/
	
	NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"file.plist"];		
	NSData *data = [[NSMutableData alloc] initWithContentsOfFile:path];	
	if (data != nil) {
		eventlist2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	
	
	fav.listOfItems = [[NSMutableArray alloc] init];
	[fav.listOfItems addObjectsFromArray:eventlist2];
	if(fav.listOfItems != nil){
		[fav.tableView reloadData];
	}
	
	categories.notifications = [[NSMutableArray alloc] init];
	[categories.notifications addObjectsFromArray:eventlist2];	
}


- (void)objIndex:(NSNotification *)notif
{	
	objindex = [[AppEvents alloc] init];
	objindex = [notif object];
}



/*- (void)rememObj:(NSNotification *)notif
{	
	//AppEvents *apev = [search.list objectAtIndex:objindex];
	objindex.alarme = [NSString stringWithFormat:@"%@", [notif object]];
	
	if ([search.list count] != 0) {
		for (int m = 0;m<[search.list count];m++) {
			if (objindex.idcod == [[search.list objectAtIndex:m] idcod]) {
				[search.list replaceObjectAtIndex:m withObject:objindex];
			}
		}
	}
	if ([search.tabledata count] != 0) {
		for (int m = 0;m<[search.tabledata count];m++) {
			if (objindex.idcod == [[search.tabledata objectAtIndex:m] idcod]) {
				[search.tabledata replaceObjectAtIndex:m withObject:objindex];
			}
		}
	}
	[search.tableView reloadData];
}*/


-(void)categAlarm:(NSNotification *)notif
{
	for (int m=0;m<[categories.selectlist count];m++) {
		if ([[categories.selectlist objectAtIndex:m] idcod] == [[notif object] idcod]) {
			[categories.selectlist replaceObjectAtIndex:m withObject:[notif object]];
			[categories.tableView reloadData];
		}
	}
	for (int m=0;m<[categories.lista count];m++) {
		if ([[categories.lista objectAtIndex:m] idcod] == [[notif object] idcod]) {
			[categories.lista replaceObjectAtIndex:m withObject:[notif object]];
			[categories.tableView reloadData];
		}
	}
	for (int m=0;m<[categories.wthot count];m++) {
		if ([[categories.wthot objectAtIndex:m] idcod] == [[notif object] idcod]) {
			[categories.wthot replaceObjectAtIndex:m withObject:[notif object]];
			[categories.tableView reloadData];
		}
	}
	for (int m=0;m<[search.list count];m++) {
		if ([[search.list objectAtIndex:m] idcod] == [[notif object] idcod]) {
			[search.list replaceObjectAtIndex:m withObject:[notif object]];
			[search.tableView reloadData];
		}
	}
}


-(void)refreshEvents:(NSNotification *)notif
{
	NSLog(@"refresh events");
	connectionInterrupted = NO;
	categories.connectionInterrupted = NO;
	
	if (applicationStart == YES) {
		self.eventlist = [[NSMutableArray alloc]init];
		self.eventlist3 = [[NSMutableArray alloc]init];
		categories.listOfEvents = self.eventlist;
		search.list = self.eventlist3;
	}
	else{
		search.list = nil;
		map.event = nil;
		self.eventlist = [[NSMutableArray alloc]init];
		self.eventlist3 = [[NSMutableArray alloc]init];
		categories.listOfEvents = self.eventlist;
		search.list = self.eventlist3;
	}
 
    NSString *feed = XML_ADDRESS;
    NSLog(@"FEED : %@",feed);
	
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:feed]];
	self.appListFeedConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
	
	NSAssert(self.appListFeedConnection != nil, @"Failure to create URL connection.");

	applicationStart = NO;
}


-(void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	if (buttonIndex == 1)
	{	
		NSString *str = @"ms";
		map.n = [NSString stringWithFormat:@"%@", str];	
		[self performSelector:@selector(removeSplash:)];
		//[str release];
	}
	else{
		[self performSelector:@selector(removeSplash:)];
	}
}


-(void)notifications:(NSNotification *)notif
{
	for(int g=0;g<[categories.notifications count];g++){
		if([[[categories.notifications objectAtIndex:g] eventTitle] isEqual:[[notif object] eventTitle]]){
			if ([[categories.notifications objectAtIndex:g] idcod] == [[notif object] idcod]) {
				[categories.notifications removeObjectAtIndex:g];
			}
		}
	}
}


-(void)removeSplash:(BOOL)animated
{
	UIImageView *img = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];	
	
	if(remove == NO){
		[splashView removeFromSuperview];
	
		//img.image = [UIImage imageNamed:@"default.png"];
		img.backgroundColor = [UIColor blackColor];
		[window addSubview:img];
		
		[[UIApplication sharedApplication] setStatusBarHidden:YES];
		remove = YES;
		
		if (connectionInterrupted == NO) {
			alert = [[UIAlertView alloc] initWithTitle:@"i Love GC would like to use your current location "
									   message:nil 
									  delegate:self 
							 cancelButtonTitle:@"Don't allow"
							 otherButtonTitles:@"Allow", nil];	
			[alert show];
			[alert release];
		}
		else {
			
			[img removeFromSuperview];	
			[window addSubview:aTabBarController.view];
			[window makeKeyAndVisible];
			[[UIApplication sharedApplication] setStatusBarHidden:NO];
		}
	}
	else{
		[img removeFromSuperview];	
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
		[window addSubview:aTabBarController.view];
		[window makeKeyAndVisible];
		
	}
}



- (void)refreshTable:(NSNotification *)notif
{	
	event = [[AppEvents alloc] init];
	event = [notif object];
	if(!fav.listOfItems){
		fav.listOfItems = [[NSMutableArray alloc] init];
		[fav.listOfItems addObject:[notif object]];
		[fav.tableView reloadData];
		if(!categories.notifications){
			categories.notifications = [[NSMutableArray alloc] init];
			[categories.notifications addObject:[notif object]];			
		}
	/*	if(!search.searchArray){
			search.searchArray = [[NSMutableArray alloc] init];
			[search.searchArray addObject:[notif object]];			
		}*/
	}	
	else if([fav.listOfItems containsObject:event]){
		int n = [fav.listOfItems indexOfObject:event];
		[fav.listOfItems replaceObjectAtIndex:n withObject:event];
		[fav.tableView reloadData];	
		if([categories.notifications containsObject:event]){
			int n = [categories.notifications indexOfObject:event];
			[categories.notifications replaceObjectAtIndex:n withObject:event];
		}
		/*if([search.searchArray containsObject:event]){
			int n = [search.searchArray indexOfObject:event];
			[search.searchArray replaceObjectAtIndex:n withObject:event];
		}*/
	}
	else{
		for(int j=0;j<[fav.listOfItems count];j++){
			if([[[fav.listOfItems objectAtIndex:j] eventTitle] isEqual:event.eventTitle]){
				if ([[fav.listOfItems objectAtIndex:j] idcod] == event.idcod) {
					[fav.listOfItems replaceObjectAtIndex:j withObject:event];
					[fav.tableView reloadData];	
					i = event;
				}
			}
			if([[[categories.notifications objectAtIndex:j] eventTitle] isEqual:event.eventTitle]){
				if ([[fav.listOfItems objectAtIndex:j] idcod] == event.idcod) {
					[categories.notifications replaceObjectAtIndex:j withObject:event];
				}
			}
		/*	if([[[search.searchArray objectAtIndex:j] eventTitle] isEqual:event.eventTitle]){
				if ([[fav.listOfItems objectAtIndex:j] idcod] == event.idcod) {
					[search.searchArray replaceObjectAtIndex:j withObject:event];
				}
			}*/
		}
		if(i == event){

		}
		else{
			[fav.listOfItems addObject:event];
			[fav.tableView reloadData];
			[categories.notifications addObject:event];
			//[search.searchArray addObject:event];
		}
	}
}


- (void)redrawTable:(NSNotification *)notif
{	
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	ary = [notif object];
	
	AppEvents *app = [[AppEvents alloc] init];
	AppEvents *app2 = [[AppEvents alloc] init];
	
	app = [ary objectAtIndex:0];
	int n = (int)app.index;
	[categories.listOfEvents replaceObjectAtIndex:n withObject:app];
	
	int c = [ary count];
	if(c > 1){
		app2 = [ary objectAtIndex:1];
		int r = (int)app2.index;
		[categories.listOfEvents replaceObjectAtIndex:r withObject:app2];
	}
	
	//categories.listOfEvents = self.eventlist;
	[categories.tableView reloadData];
}


- (void)rewTable:(NSNotification *)notif
{	
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	ary = [notif object];
	
	AppEvents *app = [[AppEvents alloc] init];
	AppEvents *app2 = [[AppEvents alloc] init];
	
	app = [ary objectAtIndex:0];
	int n = app.index2;
	[fav.listOfItems replaceObjectAtIndex:n withObject:app];
	
	int c = [ary count];
	if(c > 1){
		app2 = [ary objectAtIndex:1];
		int r = (int)app2.index2;
		[fav.listOfItems replaceObjectAtIndex:r withObject:app2];
	}
	
	[fav.tableView reloadData];
}


- (void)rwTable:(NSNotification *)notif
{	
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	ary = [notif object];
	
	AppEvents *app = [[AppEvents alloc] init];
	AppEvents *app2 = [[AppEvents alloc] init];
	
	app = [ary objectAtIndex:0];
	int n = app.index3;
	[search.tabledata replaceObjectAtIndex:n withObject:app];
	
	int c = [ary count];
	if(c > 1){
		app2 = [ary objectAtIndex:1];
		int r = (int)app2.index3;
		[search.tabledata replaceObjectAtIndex:r withObject:app2];
	}
	
	[search.tableView reloadData];
}




	// -------------------------------------------------------------------------------
	//	handleLoadedApps:notif
	// -------------------------------------------------------------------------------

- (void)handleLoadedApps:(NSArray *)loadedApps
{
    
    NSLog(@"%i",loadedApps.count);
    

    BOOL exist = NO;
	NSMutableArray *loadedApps2 = [[NSMutableArray alloc] init]; 
	
	for (int k=0;k<[loadedApps count];k++) {
		exist = NO;
		AppEvents *app = [loadedApps objectAtIndex:k];
        
		app.eventTitle = [app.eventTitle stringByReplacingOccurrencesOfString:@"&amp;" withString:@"and"];
        
       
        
		if ([loadedApps count] == 0) {
			[loadedApps2 addObject:app];
		}
		else {
          
            
            
			for (int j=0;j<[loadedApps2 count];j++) {
				//NSLog(@"LOADED %d", [loadedApps2 count]);
				if ([app.eventTitle isEqualToString:[[loadedApps2 objectAtIndex:j] eventTitle]]) {
					if (app.date2 == nil) {
						[[loadedApps2 objectAtIndex:j] setDate2:app.date];
					}
					else {
						[[loadedApps2 objectAtIndex:j] setDate2:app.date2];
                    
					}
					
					exist = YES;
				}
			}
			
			if (exist == NO) {
				[loadedApps2 addObject:app];
			}
		}
	}	
	
	//NSLog(@"%d", connectionInterrupted);
	if (connectionInterrupted == NO) {
		if (!lastSesion) {
			self.lastSesion = [[NSMutableArray alloc] init];
			[self.lastSesion addObjectsFromArray:loadedApps2];
			//NSLog(@"%d", [lastSesion count]);
		}
		else {
			[self.lastSesion removeAllObjects];
			[self.lastSesion addObjectsFromArray:loadedApps2];
			//NSLog(@"%d", [lastSesion count]);
		}
	}
	
	[self.eventlist3 addObjectsFromArray:lastSesion];
	categories.categList = self.eventlist3;	
	
	map.event = [[NSMutableArray alloc] init];
	[map.event addObjectsFromArray:lastSesion];
	
	search.list = [[NSMutableArray alloc] init];
	[search.list addObjectsFromArray:lastSesion];
	
	//map.event = lastSesion;
	
	NSDate *date = [NSDate date];
    
 
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:7];
    NSDate *sevenDaysafter = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    NSLog(@"\ncurrentDate: %@\nseven days ago: %@", date, sevenDaysafter);

    
	
	for (int h=0;h<[lastSesion count];h++) {
      //  NSLog(@"Last Session : %@",[[lastSesion objectAtIndex:h] date]);
       // NSLog(@"compare date %@",sevenDaysafter);
		NSComparisonResult result = [sevenDaysafter compare:[[lastSesion objectAtIndex:h] date]];		
      
       /* switch (result)
        {
            case NSOrderedAscending: NSLog(@"%@ is in future from %@", [[lastSesion objectAtIndex:h] date], date); break;
            case NSOrderedDescending: NSLog(@"%@ is in past from %@", [[lastSesion objectAtIndex:h] date], sevenDaysafter); break;
            case NSOrderedSame: NSLog(@"%@ is the same as %@", [[lastSesion objectAtIndex:h] date], date); break;
            default: NSLog(@"erorr dates %@, %@", [[lastSesion objectAtIndex:h] date], date); break;
        }*/
        
        
		if (result == NSOrderedDescending ) {       
			[self.eventlist addObject:[lastSesion objectAtIndex:h]];
		}
	}	
	
    
    
  
    
    
    
	//[self.eventlist removeAllObjects];
	categories.lista = [[NSMutableArray alloc] init];
	[categories.lista addObjectsFromArray:self.eventlist]; 
	

	NSMutableArray *ary = [[NSMutableArray alloc] init];
	[ary addObjectsFromArray:lastSesion];
	if ([self.eventlist count] != 0) {
		for (int o = 0;o<[self.eventlist count];o++) {
			for (int g=0;g<[ary count];g++) {	
				if ([[[self.eventlist objectAtIndex:o] eventTitle] isEqualToString:[[ary objectAtIndex:g] eventTitle]]
					&& [[self.eventlist objectAtIndex:o] time] == [[ary objectAtIndex:g] time]) {
					[ary removeObjectAtIndex:g];
				}
			}
		}
		
		categories.selectlist = [[NSMutableArray alloc] init];
		[categories.selectlist addObjectsFromArray:ary];
	}
	else{
		categories.selectlist = [[NSMutableArray alloc] init];
		[categories.selectlist addObjectsFromArray:self.eventlist3];
	}
	[ary release];
	
	//[categories.selectlist removeAllObjects];
	
	
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	NSMutableArray *ar = [[NSMutableArray alloc] init];
	[arr addObjectsFromArray:lastSesion];
	for (int g=0;g<[arr count];g++) {
		if ([[[arr objectAtIndex:g] wtshot] isEqual:@"Yes"]) {
			[ar addObject:[arr objectAtIndex:g]];
		}
	}
	
	//NSLog(@"%d", [ar count]);
	categories.wthot = [[NSMutableArray alloc] init];
    
     // modificat
	[categories.wthot addObjectsFromArray:ar];
	[arr release];
	[ar release];
	
	//[categories.wthot removeAllObjects];
	
	
	/*for (int h = 0;h<[eventlist2 count];h++) {
		for (int l=0;l<[search.list count];l++) {
			if (![[[eventlist2 objectAtIndex:h] eventTitle] isEqualToString:[[search.list objectAtIndex:l] eventTitle]]) {
				if (![[[eventlist2 objectAtIndex:h] imageURLString] isEqualToString:[[search.list objectAtIndex:l] imageURLString]]) {
					[search.list addObject:[eventlist2 objectAtIndex:l]];
				}
			}			
		}
	}*/
	
	
	if(fav.listOfItems != nil){
		if (categories.selectlist != nil && [categories.selectlist count] != 0) {
			for (int p = 0;p<[fav.listOfItems count];p++) {
				for (int g = 0;g<[categories.selectlist count];g++) {
					if ([[[fav.listOfItems objectAtIndex:p] eventTitle] isEqualToString:[[categories.selectlist objectAtIndex:g] eventTitle]]) {
						if ([[[fav.listOfItems objectAtIndex:p] imageURLString] isEqualToString:[[categories.selectlist objectAtIndex:g] imageURLString]]) {
							[categories.selectlist replaceObjectAtIndex:g withObject:[fav.listOfItems objectAtIndex:p]];
						}
					}
				}
			} 
		}
		if (categories.lista != nil && [categories.lista count] != 0) {
			for (int p = 0;p<[fav.listOfItems count];p++) {
				for (int g = 0;g<[categories.lista count];g++) {
					if ([[[fav.listOfItems objectAtIndex:p] eventTitle] isEqualToString:[[categories.lista objectAtIndex:g] eventTitle]]) {
						if ([[[fav.listOfItems objectAtIndex:p] imageURLString] isEqualToString:[[categories.lista objectAtIndex:g] imageURLString]]) {
							[categories.lista replaceObjectAtIndex:g withObject:[fav.listOfItems objectAtIndex:p]];
						}
					}
				}
			} 
		}
		if (categories.wthot != nil && [categories.wthot count] != 0) {
			for (int p = 0;p<[fav.listOfItems count];p++) {
				for (int g = 0;g<[categories.wthot count];g++) {
					if ([[[fav.listOfItems objectAtIndex:p] eventTitle] isEqualToString:[[categories.wthot objectAtIndex:g] eventTitle]]) {
						if ([[[fav.listOfItems objectAtIndex:p] imageURLString] isEqualToString:[[categories.wthot objectAtIndex:g] imageURLString]]) {
							[categories.wthot replaceObjectAtIndex:g withObject:[fav.listOfItems objectAtIndex:p]];
						}
					}
				}
			} 
		}
		if (search.list != nil && [search.list count] != 0) {
			for (int p = 0;p<[fav.listOfItems count];p++) {
				for (int g = 0;g<[search.list count];g++) {
					if ([[[fav.listOfItems objectAtIndex:p] eventTitle] isEqualToString:[[search.list objectAtIndex:g] eventTitle]]) {
						if ([[[fav.listOfItems objectAtIndex:p] imageURLString] isEqualToString:[[search.list objectAtIndex:g] imageURLString]]) {
							[search.list replaceObjectAtIndex:g withObject:[fav.listOfItems objectAtIndex:p]];
						}
					}
				}
			} 
		}
	}	
	
	if ([categories.lista count] == 0) {
		categories.emptyLista = YES;
	}
	else {
		categories.emptyLista = NO;
	}

	[categories.tableView reloadData];
}

	// -------------------------------------------------------------------------------
	//	didFinishParsing:appList
	// -------------------------------------------------------------------------------

- (void)didFinishParsing:(NSArray *)appList
{
    [self performSelectorOnMainThread:@selector(handleLoadedApps:) withObject:appList waitUntilDone:NO];
    
	self.queue = nil;   // we are finished with the queue and our ParseOperation
}

- (void)parseErrorOccurred:(NSError *)error
{
	//NSLog(@"%@", error);
    [self performSelectorOnMainThread:@selector(handleError:) withObject:error waitUntilDone:NO];
}

#pragma mark -
#pragma mark NSURLConnection delegate methods

	// -------------------------------------------------------------------------------
	//	handleError:error
	// -------------------------------------------------------------------------------

- (void)handleError:(NSError *)error
{
	//NSString *errorMessage = [error localizedDescription];
	connectionInterrupted = YES;
	categories.connectionInterrupted = YES;
	
	//NSArray *array = [NSArray array];
	//array = lastSesion;
	//[self performSelector:@selector(handleLoadedApps:) withObject:array];
	
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Server Not Responding"
														message:@"please check your internet connection"
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
	
	[categories.activity stopAnimating];
	[categories.img removeFromSuperview];
	
	//[categories.img removeFromSuperview];
	
	//categories.h = 1;
}


	// -------------------------------------------------------------------------------
	//	connection:didReceiveResponse:response
	// -------------------------------------------------------------------------------

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	self.appListData = [NSMutableData data];  
}

	// -------------------------------------------------------------------------------
	//	connection:didReceiveData:data               recive XML data
	// -------------------------------------------------------------------------------

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [appListData appendData:data];  
	//NSLog(@"%@", appListData);
}

	// -------------------------------------------------------------------------------
	//	connection:didFailWithError:error
	// -------------------------------------------------------------------------------

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
			// if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Internet Connection"
															 forKey:NSLocalizedDescriptionKey];
		
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
		
		[self handleError:noConnectionError];
    }
	else
	{
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Server Connection Interrupted"
															 forKey:NSLocalizedDescriptionKey];
		
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
		
		// otherwise handle the error generically
        [self handleError:noConnectionError];
    }
    
    self.appListFeedConnection = nil;   // release our connection
}

	// -------------------------------------------------------------------------------
	//	connectionDidFinishLoading:connection
	// -------------------------------------------------------------------------------

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.appListFeedConnection = nil;   
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
	
	self.queue = [[NSOperationQueue alloc] init];
		
    ParseOperation *parser = [[ParseOperation alloc] initWithData:appListData delegate:self];
    
    [queue addOperation:parser]; 
    
    [parser release];
	
    self.appListData = nil;
}




- (void)applicationDidEnterBackground:(UIApplication *)application {
	
	NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"file.plist"];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:fav.listOfItems];
	[data writeToFile:path atomically:YES];	
}


- (void)applicationWillTerminate:(UIApplication *)application {
	
	NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"file.plist"];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:fav.listOfItems];
	[data writeToFile:path atomically:YES];	
	
}



- (void)applicationWillEnterForeground:(UIApplication *)application{
	//NSLog(@"%@", @"perform selector in background");
	
	categories.y = 1;
	categories.isRefreshPressed = YES;
	categories.b = -1;
	
	categories.categList = nil;
	categories.listOfEvents = nil;
	[categories.lista release];
	[categories.selectlist release];
	[categories.wthot release];
	//[categories.tableView reloadData];
	
	categories.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	[categories.activity startAnimating];
	categories.activity.color = [UIColor blackColor];
	[self performSelectorOnMainThread:@selector(refreshEvents:) withObject:nil waitUntilDone:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	NSLog(@"%@", @"Memory warning!!!");
}

- (void)dealloc {
	
    [strMenuSelected release];
	[allPages release];
	
	[lastSesion release];
	[searchController release];
	[search release];
	
	[alert release];
	[event release];
	[eval release];
	[i release];
	[more release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshTable" object:nil];	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RedrawTable" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RewTable" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RWTable" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notifications" object:nil];	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshEvents" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"CategAlarm" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ObjIndex" object:nil];
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RememObj" object:nil];
	
	[eventlist2 release];
	[splashView release];
	[map release];
	[fav release];
	[eventlist release];	
	[appListFeedConnection release];
    [appListData release];
	[categories release];
	[eve release];
	
	//[event release];
	[navigationController3 release];
	[navigationController1 release];
	[navigationController2 release];
	[navigationController4 release];	
	[aTabBarController release];	
    [window release];
	[windowiPad release];
	[eventlist release];
	
    [super dealloc];
}

@end
