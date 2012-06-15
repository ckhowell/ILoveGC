    //
//  Maps.m
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import "Maps.h"
#import "ILoveGCAppDelegate.h"
#import "AppEvents.h"
#import "Event.h"
#import <CoreLocation/CoreLocation.h>
#import "MKMapView+ZoomLevel.h"
#import "Info.h"


#define kAppIconHeight 48
#define kIconHeight 200
#define kIconWidth 285
#define kVerySmallValue (0.000001)


enum
{
    kpinAnnotationIndex,
	koverlayIndex
};


@implementation Maps
@synthesize view1;

@synthesize map, ev, st, locationManager;
@synthesize lat, event, extremes, activity, duplicates;
@synthesize lon, eve, mapAnnotations, eve2, n, list;
@synthesize arts, community, showall, sport, food, customPinView;
@synthesize imageConnection, activeDownload, fromMaps,mapCat;

-(void) setMapCatagory{
	Sheet = [[UIActionSheet alloc] initWithTitle:@"Select categories" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	[Sheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	
	CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
	UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
	
	//pickerView.delegate = self;
	pickerView.showsSelectionIndicator = YES;
	pickerView.delegate = self;
	pickerView.dataSource = self;
	pickerView.tag = 0;
	[Sheet addSubview:pickerView];
	[pickerView release];
	
	UIToolbar *controlToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, Sheet.bounds.size.width, 44)];
	[controlToolBar setBarStyle:UIBarStyleBlack];
	[controlToolBar sizeToFit];
	
	UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *setButton = [[UIBarButtonItem alloc] initWithTitle:@"Set" style:UIBarButtonItemStyleDone target:self action:@selector(dismissMapCatSet)];
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDateSet)];
	
	[controlToolBar setItems:[NSArray arrayWithObjects:spacer, setButton, cancelButton, nil] animated:NO];
	[spacer release];
	[setButton release];
	[cancelButton release];
	[Sheet addSubview:controlToolBar];
	[controlToolBar release];
	
	[Sheet showInView:self.view1];
	[Sheet setBounds:CGRectMake(0,0,320, 485)];
	self.mapCat= [[NSString alloc]initWithFormat:@"%@",[mapCats objectAtIndex:0]];
    
	
}

- (void) cancelDateSet{
	[Sheet dismissWithClickedButtonIndex:0 animated:YES];
	[Sheet release];
    
}
-(void) dismissMapCatSet{
    
    
    
    NSString *output = [NSString stringWithFormat:@"%@",self.mapCat];
    if( [output isEqualToString:@"Show All"]){
        [self ShowAll];
        
    }
    else if([output isEqualToString:@"Arts"]){
        [self Arts];
    }
    else if([output isEqualToString:@"Community"]){
        [self Community];
    }
    
    else if([output isEqualToString:@"Food"]){
        [self Food];
    }
    
    else if([output isEqualToString:@"Sport"]){
        [self Sport];
    }
    
    [Sheet dismissWithClickedButtonIndex:0 animated:YES];
    [Sheet release];
	
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	    return mapCats.count;
    
}

//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
		return [mapCats objectAtIndex:row];
}

//PickerViewController.m
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
		NSLog(@"Selected ITEM: %@. Index of selected ITEM: %i", [mapCats objectAtIndex:row], row);
		self.mapCat = [[NSString alloc]initWithFormat:@"%@",[mapCats objectAtIndex:row]];
    
}




// --------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
	
	
	lat = eve.latitude;
	lon = eve.longitude;
    
	if(eve != nil){
		
		if(lat != 200 && lon != 200){
			
			self.map.frame = self.view.frame;
			
			MKCoordinateRegion newRegion;
			newRegion.center.latitude = lat;    
			newRegion.center.longitude = lon;   
			//newRegion.span.latitudeDelta = 0.005; 
			//newRegion.span.longitudeDelta = 0.005;   
            
			//[self.map setRegion:newRegion animated:YES];
            
			[map setCenterCoordinate:newRegion.center zoomLevel:15 animated:YES];			
			
			self.mapAnnotations = [[NSMutableArray alloc] init];	
            
			[self.mapAnnotations insertObject:eve atIndex:kpinAnnotationIndex];
		}
		else {
			self.map.frame = self.view.frame;
		}
	}
	
	
	self.map.delegate = self;	
	self.map.mapType = MKMapTypeStandard;
	
	//NSLog(@"%@", n);
	if([n isEqual:@"ms"]){
		map.showsUserLocation = TRUE;
		
		locationManager = [[CLLocationManager alloc] init];
		locationManager.delegate = self;
		[locationManager setDistanceFilter:kCLLocationAccuracyHundredMeters]; 
		[locationManager setDesiredAccuracy:kCLLocationAccuracyBest];	
		
		[locationManager startUpdatingLocation];
		//[locationManager startUpdatingHeading];
        
		if(locationManager.location != nil){
			
			//NSLog(@"%4f", locationManager.location.coordinate.latitude);
			
			//MKCoordinateRegion newRegion;
			//newRegion.center.latitude = locationManager.location.coordinate.latitude;    
			//newRegion.center.longitude = locationManager.location.coordinate.longitude;   
			//newRegion.span.latitudeDelta = 0.005; 
			//newRegion.span.longitudeDelta = 0.005; 
            
			//[map setRegion:newRegion animated:YES];
			
			//[map setCenterCoordinate:locationManager.location.coordinate zoomLevel:16 animated:YES];
            
		}
		
		//map.centerCoordinate = locationManager.location.coordinate;
        
		/*AppEvents *app = [[AppEvents alloc] init];
         app.latitude = locationManager.location.coordinate.latitude;
         app.longitude = locationManager.location.coordinate.longitude;
         app.eventTitle = [NSString stringWithFormat:@"%@", @"Current location"];
         app.category = [NSString stringWithFormat:@"%@", @"me"];
         NSLog(@"%@", app.category);
         
         [self.map addAnnotation:app];*/	
	}	
	
	
	if ([event count] != 0) {
		[self performSelector:@selector(centerMap:) withObject:event];
	}
	
	
	if(eve != nil){
		[self.map removeAnnotations:self.map.annotations];
		[self.map addAnnotations:self.mapAnnotations];
	}
	else {
		[self.map removeAnnotations:self.map.annotations];
        
        
        BOOL add = NO; 
        NSMutableArray *event2 = [[NSMutableArray alloc] init]; 
        for(AppEvents *ap in event)
            if (ap.latitude != 200 && ap.longitude != 200) 
                [event2 addObject:ap];
        
        duplicates = [[NSMutableArray alloc] init]; 
        multiple = [[NSMutableArray alloc] init]; 
        
        for (AppEvents *app in event) {
            for (int j=0;j<[event2 count];j++) {
                
                
  //              if (app.latitude == [[event2 objectAtIndex:j] latitude] && app.longitude == [[event2 objectAtIndex:j] longitude]) {
                if( [self firstDouble:app.latitude isEqualTo:[[event2 objectAtIndex:j] latitude]] == YES){
                    
                    
                if ([self firstDouble:app.longitude isEqualTo:[[event2 objectAtIndex:j] longitude]] == YES){
                    
                    if (![app.eventTitle isEqual:[[event2 objectAtIndex:j] eventTitle]]) {
                       // NSLog(@"app.eventtitle : %@",app.eventTitle);
                       // NSLog(@"event2.title : %@",[[event2 objectAtIndex:j] eventTitle]);
                        
                        add = YES;
                    }
                 }
                }
            }
            
            if (add == YES) {
                [duplicates addObject:app];
                add = NO;
            }
        }	
        
        [event removeAllObjects];
        [event addObjectsFromArray:event2];
        
        for(AppEvents *ap in event){
            if(ap != nil){
                [self.map addAnnotation:ap];
            }
        }
        
        /*for(int i=0;i<[event3 count];i++){
         NSLog(@"%@", [[event3 objectAtIndex:i] eventTitle]);
         NSLog(@"%f", [[event3 objectAtIndex:i] latitude]);
         NSLog(@"%f", [[event3 objectAtIndex:i] longitude]);
         }
         NSLog(@"%d", [event3 count]);*/
	}
	
	for (AppEvents *app in event) {	
		app.eventTitle = [app.eventTitle capitalizedString];
	}
	
	/*[self loadRoute];
     
     // add the overlay to the map
     if (nil != self.routeLine) {
     [self.map addOverlay:self.routeLine];
     }
     
     // zoom in on the route. 
     [self zoomInOnRoute];*/
   //  [self ShowAll];
    
}


- (BOOL)firstDouble:(double)first isEqualTo:(double)second {
    
    if(fabsf(first - second) < kVerySmallValue)
        return YES;
    else
        return NO;
}


- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // [self viewDidUnload];
    
    //if(eve != nil){
    NSLog(@"%@", self.navigationController.title) ;
    
    if ([self.navigationController.title isEqual:@"Maps"]) {
        app.showMapClicked = YES;
        self.title = @"Back";
        self.navigationController.title = @"Maps";
    }
    else if ([self.navigationController.title isEqual:@"Search"])
    {
        app.showMapClicked = YES;
        self.navigationController.title = @"Search";
    }
    else if ([self.navigationController.title isEqual:@"Favs"])
    {
        app.showMapClicked = YES;
                    self.title = @"Back";
        self.navigationController.title = @"Favs";
    }
    else if ([self.navigationController.title isEqual:@"More"])
    {
        app.showMapClicked = YES;
                    self.title = @"Back";
        self.navigationController.title = @"More";
    }
    else if ([self.navigationController.title isEqual:@"categories"])
    {
        app.showMapClicked = YES;
        self.title = @"Back";
        self.navigationController.title = @"categories";
    }
    else {
        app.showMapClicked = NO;
            self.title = @"Back";
            //s
    }

    

    
}
// --------------------------------------------------------------------------------
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:YES];
	  NSLog(@"%@", self.navigationController.title);
    
    
    
        
    
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    
    /*	if(eve != nil){
     ILoveGCAppDelegate *apd = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
     navTitle = apd.aTabBarController.selectedViewController.title;
     }*/
    ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	if([self.navigationController.title isEqualToString:@"Maps"] ){
        app.showMapClicked = NO;
    }
    
    
    
    if (app.showMapClicked == YES){
            self.title = eve.title;
                
        [self setMenuColor];
    }
    else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_default.png"]]];
        
        self.title = @"Maps";
        app.showMapClicked = NO;
        self.navigationController.navigationBar.tintColor  = [UIColor blackColor ];
        UIButton *mapButton1 =[[UIButton alloc] init];
        [mapButton1 setBackgroundImage:[UIImage imageNamed:@"btn_list.png"] forState:UIControlStateNormal];
        
        mapButton1.frame = CGRectMake(100, 100, 28, 28);
        UIBarButtonItem *mapButton =[[UIBarButtonItem alloc] initWithCustomView:mapButton1];
        [mapButton1 addTarget:self action:@selector(setMapCatagory) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = mapButton;
        
        //  UIBarButtonItem *mapBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(setMapCatagory)];
        self.navigationItem.leftBarButtonItem = mapButton;
        [mapButton release];	
        
        mapCats = [[NSMutableArray alloc] init];
        [mapCats addObject:@"Show All"];
        [mapCats addObject:@"Arts"];
        [mapCats addObject:@"Community"];
        [mapCats addObject:@"Food"];
        [mapCats addObject:@"Sport"];
    }
    
    
    
    
}

// --------------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
    ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.title isEqual:@"maps"]) {
        app.showMapClicked = NO;
    }
    else {
        app.showMapClicked = YES;
    }
    
    
    
     //[self showall];
	
	
}

- (void) setMenuColor{
    NSString *output = [NSString stringWithFormat:@"%@",self.mapCat];
    if( [output isEqualToString:@"Show All"]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
    }
    else if([output isEqualToString:@"Arts"]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_arts.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:206/255.f green:64/255.f blue:113/255.f alpha:1.0];
    }
    else if([output isEqualToString:@"Community"]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_comm.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:213/255.f green:96/255.f blue:36/255.f alpha:1.0];
    }
    
    else if([output isEqualToString:@"Food"]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_food.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:87/255.f alpha:1.0]; 	
    }
    
    else if([output isEqualToString:@"Sport"]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_sport.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:10/255.f alpha:1.0]; 
    }
}
// --------------------------------------------------------------------------------
-(void)centerMap:(NSMutableArray *)categ {
	
	double N;	
	double S;
	double E;	
	double V;
	NSMutableArray *latArray = [[NSMutableArray alloc] init];
	NSMutableArray *lonArray = [[NSMutableArray alloc] init];
	if ([categ count] != 0) {
		for (int i=0;i<[categ count];i++) {
			if ([[categ objectAtIndex:i] latitude] != 200) {
				double j = [[categ objectAtIndex:i] latitude];
				[latArray addObject:[NSNumber numberWithDouble:j]];
			}
			if ([[categ objectAtIndex:i] longitude] != 200) {
				double m = [[categ objectAtIndex:i] longitude];
				[lonArray addObject:[NSNumber numberWithDouble:m]];
			}
		}
		
		S = [[latArray objectAtIndex:0] doubleValue];
		N = [[latArray objectAtIndex:0] doubleValue];
		for (int i=0;i<[latArray count];i++) {
			if (N < [[latArray objectAtIndex:i] doubleValue]){
				N = [[latArray objectAtIndex:i] doubleValue];
			}
			if (S > [[latArray objectAtIndex:i] doubleValue]){
				S = [[latArray objectAtIndex:i] doubleValue];
			}
		}
		
		E = [[lonArray objectAtIndex:0] doubleValue];
		V = [[lonArray objectAtIndex:0] doubleValue];		
		for (int i=0;i<[lonArray count];i++) {
			if (E < [[lonArray objectAtIndex:i] doubleValue]){
				E = [[lonArray objectAtIndex:i] doubleValue];
			}
			if (V > [[lonArray objectAtIndex:i] doubleValue]){
				V = [[lonArray objectAtIndex:i] doubleValue];
			}
		}
		
		//NSLog(@"nord %6f", N);
		//NSLog(@"sud %6f", S);
		//NSLog(@"est %6f", E);
		//NSLog(@"vest %6f", V);
        
	}
	
	[latArray release];
	[lonArray release];
	
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake((N + S) / 2.0, (E + V) / 2.0), 1000.0, 1000.0);
	region.span.latitudeDelta = MAX(region.span.latitudeDelta, (N - S) * 1.05);
	region.span.longitudeDelta = MAX(region.span.longitudeDelta, (E - V) * 1.05);
	[map setRegion:region animated:YES];	
}
// --------------------------------------------------------------------------------
- (void)Arts {
	
	//self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:206/255.f green:64/255.f blue:113/255.f alpha:1.0]; 	
	
	[self.map removeAnnotations:self.map.annotations];
	
	/*MKCoordinateRegion region;
     region.center.latitude = 0.0;
     region.center.longitude = 0.0;
     [map setCenterCoordinate:region.center zoomLevel:0 animated:YES];*/
	
	NSMutableArray *categ = [[NSMutableArray alloc] init];
	for (int i=0;i<[event count];i++) {
		if ([[[event objectAtIndex:i] category] isEqual:@"Arts"]) {
			[categ addObject:[event objectAtIndex:i]];
		}
	}
	
	if ([categ count] != 0) {
		[self performSelector:@selector(centerMap:) withObject:categ];
	}
	else {
		/*UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
															message:@"There are no events in this category"
														   delegate:nil 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];	
		[alertview show];
		[alertview release];	*/
	}	
	[categ release];
	
	
	for(AppEvents *ap in event){
		if(ap != nil){
			if (ap.latitude != 200 && ap.longitude != 200){
				if([ap.category isEqual:@"Arts"]){
                    
                    
                    
					[self.map addAnnotation:ap];
				}
			}
		}
	}	
}
// --------------------------------------------------------------------------------


- (void)Community{	
	
	//self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:213/255.f green:96/255.f blue:36/255.f alpha:1.0];
	
	[self.map removeAnnotations:self.map.annotations];
	
	/*MKCoordinateRegion region;
     region.center.latitude = 0.0;
     region.center.longitude = 0.0;
     [map setCenterCoordinate:region.center zoomLevel:0 animated:YES];*/
	
	NSMutableArray *categ = [[NSMutableArray alloc] init];
	for (int i=0;i<[event count];i++) {
		if ([[[event objectAtIndex:i] category] isEqual:@"Community"]) {
			[categ addObject:[event objectAtIndex:i]];
		}
	}
	
	if ([categ count] != 0) {
		[self performSelector:@selector(centerMap:) withObject:categ];
	}
	else {
		/* UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
															message:@"There are no events in this category"
														   delegate:nil 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];	
		[alertview show];
		[alertview release];	*/
	}	
	[categ release];
	
	
	for(AppEvents *ap in event){
		if(ap != nil){
			if (ap.latitude != 200 && ap.longitude != 200){
				if([ap.category isEqual:@"Community"]){
					[self.map addAnnotation:ap];
				}
			}
		}
	}		
}
// --------------------------------------------------------------------------------
- (void)Sport {
	
	//self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:10/255.f alpha:1.0];
	
	/*MKCoordinateRegion region;
     region.center.latitude = 0.0;
     region.center.longitude = 0.0;
     [map setCenterCoordinate:region.center zoomLevel:0 animated:YES];*/
	
	NSMutableArray *categ = [[NSMutableArray alloc] init];
	for (int i=0;i<[event count];i++) {
		if ([[[event objectAtIndex:i] category] isEqual:@"Sport"]) {
			[categ addObject:[event objectAtIndex:i]];
		}
	}
	
	if ([categ count] != 0) {
		[self performSelector:@selector(centerMap:) withObject:categ];
	}
	else {
		/*UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
															message:@"There are no events in this category"
														   delegate:nil 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];	
		[alertview show];
		[alertview release];	*/
	}
	[categ release];
    
	
	[self.map removeAnnotations:self.map.annotations];
	
	for(AppEvents *ap in event){
		if(ap != nil){
			if (ap.latitude != 200 && ap.longitude != 200){
				if([ap.category isEqualToString:@"Sport"]){
					[self.map addAnnotation:ap];
				}
			}
		}
	}		
}

// --------------------------------------------------------------------------------
- (void)Food {
	
//	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:87/255.f alpha:1.0]; 
	
	/*MKCoordinateRegion region;
     region.center.latitude = 0.0;
     region.center.longitude = 0.0;
     [map setCenterCoordinate:region.center zoomLevel:0 animated:YES];*/
	
	NSMutableArray *categ = [[NSMutableArray alloc] init];
	for (int i=0;i<[event count];i++) {
		if ([[[event objectAtIndex:i] category] isEqual:@"Food"]) {
			[categ addObject:[event objectAtIndex:i]];
		}
	}
	
	if ([categ count] != 0) {
		[self performSelector:@selector(centerMap:) withObject:categ];
	}
	else {
		/*UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
															message:@"There are no events in this category"
														   delegate:nil 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];	
		[alertview show];
		[alertview release];	*/
	}
	[categ release];
	
	
	[self.map removeAnnotations:self.map.annotations];
	
	for(AppEvents *ap in event){
		if(ap != nil){
			if (ap.latitude != 200 && ap.longitude != 200){
				if([ap.category isEqualToString:@"Food"]){
					[self.map addAnnotation:ap];
				}
			}
		}
	}	
}
// --------------------------------------------------------------------------------

- (void)ShowAll {
	
	//self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0];
	
	MKCoordinateRegion region;
	region.center.latitude = 0.0;
	region.center.longitude = 0.0;
	[map setCenterCoordinate:region.center zoomLevel:0 animated:YES];
	
	if ([event count] != 0) {
		[self performSelector:@selector(centerMap:) withObject:event];
	}		
	
	
	[self.map removeAnnotations:self.map.annotations];
	
	for(AppEvents *ap in event){
		if(ap != nil){
			if (ap.latitude != 200 && ap.longitude != 200){
                [self.map addAnnotation:ap];
			}
		}
	}	
}


//- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView

/*- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
 
 CLLocation *whereIAm = userLocation.location;
 NSLog(@"I'm at %@", whereIAm.description);
 
 float latitude = whereIAm.coordinate.latitude;
 float longitude = whereIAm.coordinate.longitude;
 
 MKCoordinateRegion newRegion;
 newRegion.center.latitude = latitude;    
 newRegion.center.longitude = longitude; 
 
 if(userLocation.location != nil){	
 [map setCenterCoordinate:newRegion.center zoomLevel:16 animated:YES];
 }
 
 //map.centerCoordinate = locationManager.location.coordinate;
 
 [locationManager stopUpdatingLocation];
 }*/

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
	//locationManager.location.coordinate = newLocation.coordinate;
	//NSLog(@"Our current Latitude is %f",location2.coordinate.latitude);
	//NSLog(@"Our current Longitude is %f",location2.coordinate.longitude);	
	
	/*if (newLocation != oldLocation) {
     MKCoordinateRegion newRegion;
     newRegion.center.latitude = newLocation.coordinate.latitude;    
     newRegion.center.longitude = newLocation.coordinate.longitude;   
     //newRegion.span.latitudeDelta = 0.005; 
     //newRegion.span.longitudeDelta = 0.005;   
     
     //[self.map setRegion:newRegion animated:YES];
     
     [map setCenterCoordinate:newRegion.center zoomLevel:16 animated:YES];
     }*/
	
	//[self.map setCenterCoordinate:location2.coordinate animated:YES];	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  
{ 
	[manager stopUpdatingLocation];
	//NSLog(@"error%@",error);
	switch([error code])
	{
		case kCLErrorNetwork: 
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"please check your network connection or that you are not in airplane mode" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
			break;
		case kCLErrorDenied:{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"user has denied to use current Location " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
			break;
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"unknown network error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
			break;
	}
}


/*- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{ 
 
 NSLog(@"Problemas com on reverse geocoder"); 
 } 
 
 - (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark_{  
 
 placemark = placemark_;
 [map addAnnotation:placemark];
 }*/


/*- (void)gotoLocation:(NSNotification *)notif
 {
 //get user location
 if([[notif object] isEqual:@"ms"]){
 NSLog(@"%@", [notif object]);
 map.showsUserLocation = YES;
 
 self.reverseGeocoder = [[[MKReverseGeocoder alloc] initWithCoordinate:map.userLocation.location.coordinate] autorelease];
 reverseGeocoder.delegate = self;
 [reverseGeocoder start];
 }
 }*/




- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.mapAnnotations = nil;
	self.map = nil;
}


- (void)dealloc {
	
	fromMaps = NO;
	
	[multiple release];
	[list release];
	[duplicates release];
	
	[activeDownload release];
	[imageConnection release];
	
	[customPinView release];
	//[overlays release];
	//[startLocation release];
	[eve2 release];
	//[placemark release];
	
	//[mylocation release];
	//[pin release];
	[mapAnnotations release];
	[event release];	
	[eve release];
	[locationManager release];
	[st release];
	[ev release];
	[map release];
	[n release];
    [super dealloc];
	
	if (eve == nil) {
		[showall release];	
		[arts release];
		[community release];
		[sport release];
		[food release];
	}
}


/*- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
 {
 NSString *errorMessage = [error localizedDescription];
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot obtain address."
 message:errorMessage
 delegate:nil
 cancelButtonTitle:@"OK"
 otherButtonTitles:nil];
 [alertView show];
 [alertView release];
 }
 
 - (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
 {
 PlacemarkViewController *placemarkViewController =
 [[PlacemarkViewController alloc] initWithNibName:@"PlacemarkViewController" bundle:nil];
 placemarkViewController.placemark = placemark;
 [self presentModalViewController:placemarkViewController animated:YES];
 }
 
 - (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
 {
 // we have received our current location, so enable the "Get Current Address" button
 //[getAddressButton setEnabled:YES];
 }*/


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
	if ([annotation isKindOfClass:[MKUserLocation class]])
		return nil;  	
	
	
	if ([annotation isKindOfClass:[AppEvents class]]) 
	{	
		
		static NSString *StartPinIdentifier = @"StartPinIdentifier";
		MKPinAnnotationView *startPin = (MKPinAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:StartPinIdentifier];
        
		startPin = nil;
		
		if (!startPin)
		{
			
			customPinView = [[MKPinAnnotationView alloc]
                             initWithAnnotation:annotation reuseIdentifier:StartPinIdentifier];
			customPinView.animatesDrop = YES;
			customPinView.enabled = YES;
			
			BOOL isDuplicated = NO;
			for (AppEvents *ap in duplicates) 
				if ([[(AppEvents *)annotation eventTitle] isEqual:ap.eventTitle]) 
					isDuplicated = YES;
            
			if (isDuplicated==NO) {
				customPinView.canShowCallout = YES;
			}
			
            
			
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(-27, -27, 70, 90)];
			
            
            if(isDuplicated == YES)
            {
                 NSString *output = [NSString stringWithFormat:@"%@",self.mapCat];
                NSLog(@"%@", output);
                if( [output isEqualToString:@"Show All"] || [output isEqualToString:@"(null)"] ){
                    UIImage *image = [UIImage imageNamed:@"blue.png"];
                    imgView.image = image;
                    [customPinView addSubview:imgView];   
                }else {
                    if([[(AppEvents *)annotation category] isEqualToString:@"Arts"])
                    {
                        UIImage *image = [UIImage imageNamed:@"pink.png"];
                        imgView.image = image;
                        [customPinView addSubview:imgView];
                    }	
                    else if([[(AppEvents *)annotation category] isEqualToString:@"Community"])
                    {
                        UIImage *image = [UIImage imageNamed:@"orange.png"];
                        imgView.image = image;
                        [customPinView addSubview:imgView];
                    }	
                    else if([[(AppEvents *)annotation category] isEqualToString:@"Food"])
                    {
                        UIImage *image = [UIImage imageNamed:@"green.png"];
                        imgView.image = image;
                        [customPinView addSubview:imgView];
                    }	
                    else if([[(AppEvents *)annotation category] isEqualToString:@"Sport"])
                    {
                        UIImage *image = [UIImage imageNamed:@"yellow2.png"];
                        imgView.image = image;
                        [customPinView addSubview:imgView];
                    }
                }
                
                
            }
            else {
                
                if([[(AppEvents *)annotation category] isEqualToString:@"Arts"])
                {
                    UIImage *image = [UIImage imageNamed:@"pink.png"];
                    imgView.image = image;
                    [customPinView addSubview:imgView];
                }	
                else if([[(AppEvents *)annotation category] isEqualToString:@"Community"])
                {
                    UIImage *image = [UIImage imageNamed:@"orange.png"];
                    imgView.image = image;
                    [customPinView addSubview:imgView];
                }	
                else if([[(AppEvents *)annotation category] isEqualToString:@"Food"])
                {
                    UIImage *image = [UIImage imageNamed:@"green.png"];
                    imgView.image = image;
                    [customPinView addSubview:imgView];
                }	
                else if([[(AppEvents *)annotation category] isEqualToString:@"Sport"])
                {
                    UIImage *image = [UIImage imageNamed:@"yellow2.png"];
                    imgView.image = image;
                    [customPinView addSubview:imgView];
                }
                
            }

			
			//if(eve != nil){
            
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
			//}
			
			
			return customPinView;
            
		}
		else
		{
			startPin.annotation = annotation;
		}
	}
	
	return nil;
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
	//[activity stopAnimating];
}


/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 
 return YES;
 }*/



- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)annotationView
{
    
    NSLog(@"ASD");
    
	[map setCenterCoordinate:annotationView.annotation.coordinate zoomLevel:16 animated:YES];
 	
	fromTable = NO;
    
	eve2 = (AppEvents *)annotationView.annotation;
    
    NSLog(@"%@",eve2.eventTitle); 
    NSLog(@"%f",eve2.longitude);
    NSLog(@"%f",eve2.latitude);
    
    
	if (eve == nil) {
		BOOL isIN = NO;
		if ([duplicates containsObject:eve2]) {
			isIN = YES;
		}
		if (isIN == YES) {
            NSLog(@"IS IN");
			
            
            
            [multiple removeAllObjects];
			
			//imv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
            //imv = [[UIImageView alloc] initWithFrame: CGRectMake(20, 80, 280, 100)];
            imv = [[UIImageView alloc] initWithFrame: CGRectMake(20, 35, 280, 120)];
			imv.backgroundColor = [UIColor blackColor];
			imv.alpha = 0.7;
			imv.layer.cornerRadius = 5;
			imv.layer.masksToBounds = YES;
			
           // list = [[UITableView alloc] initWithFrame: CGRectMake(20, 80, 280, 80)];
			//list = [[UITableView alloc] initWithFrame:CGRectMake(20, 80, 280, 60)];
           // list = [[UITableView alloc] initWithFrame: CGRectMake(20, 40, 280, 80)];
            list = [[UITableView alloc] initWithFrame:CGRectMake(20, 35, 280, 120)];
			list.delegate = self;
			list.dataSource = self;
			//list.separatorStyle = UITableViewCellSeparatorStyleNone;
           // list.separatorStyle = UITableViewCellSelectionStyleGray;
           
			list.backgroundColor = [UIColor clearColor];
			list.layer.cornerRadius = 5;
			list.layer.masksToBounds = YES;
			list.showsVerticalScrollIndicator = YES;
			list.scrollEnabled = YES;
			//[list setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
            
			list.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 1);
        
            
			im = [[UIImageView alloc] initWithFrame:CGRectMake(143, 154, 33, 17)];
			im.image = [UIImage imageNamed:@"arrow.png"];
            im.alpha = 0.9;
            
            
			
			[map addSubview:imv];
			[map addSubview:list];
            [map addSubview:im];
			//[imv bringSubviewToFront:list];
            
            
			for (AppEvents *ap in duplicates) {
                
                NSString *output = [NSString stringWithFormat:@"%@",self.mapCat];
                
                if( [output isEqualToString:@"Show All"] || [output isEqualToString:@"(null)"]){

                    if(eve2.latitude == ap.latitude && eve2.longitude == ap.longitude){	
                        [multiple addObject:ap];
                        
                        fromTable = YES;
                    }
                }
                else if([output isEqualToString:@"Arts"]){
                    if(eve2.latitude == ap.latitude && eve2.longitude == ap.longitude && eve2.category == ap.category){	
                        [multiple addObject:ap];
                        
                        fromTable = YES;
                    }
                }
                else if([output isEqualToString:@"Community"]){
                    if(eve2.latitude == ap.latitude && eve2.longitude == ap.longitude && eve2.category == ap.category){	
                        [multiple addObject:ap];
                        
                        fromTable = YES;
                    }
                }
                
                else if([output isEqualToString:@"Food"]){
                    if(eve2.latitude == ap.latitude && eve2.longitude == ap.longitude && eve2.category == ap.category){	
                        [multiple addObject:ap];
                        
                        fromTable = YES;
                    }
                }
                
                else if([output isEqualToString:@"Sport"]){
                    if(eve2.latitude == ap.latitude && eve2.longitude == ap.longitude && eve2.category == ap.category){	
                        [multiple addObject:ap];
                        
                        fromTable = YES;
                    }
                }
                    
                
             
				
			}
		}
	}
    
    
   /* NSLog(@"dup : %i",duplicates.count);

    for (AppEvents *ap in duplicates){
    
        NSLog(@"Event Title : %@",ap.eventTitle);
        //NSLog(@"%@", [eve2 eventTitle]);
        NSLog(@"%f", [ap latitude]);
        NSLog(@"%f", [ap longitude]);

    }*/
    
	
	self.activeDownload = [NSMutableData data];
	
	//NSLog(@"%@", eve2.imageURLString);
	
    
	if(![eve2.imageURLString isEqualToString:@""]){
		self.imageConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:
                                                                         [NSURL URLWithString:[NSString stringWithFormat:@"%@", eve2.imageURLString]]] delegate:self];
	}
	
	/*if ([annotationView.annotation isKindOfClass:[AppEvents class]]) 
     {
     MKCoordinateRegion newRegion;
     newRegion.center = annotationView.annotation.coordinate;      
     newRegion.span.latitudeDelta = 0.005; 
     newRegion.span.longitudeDelta = 0.005; 
     
     [map setRegion:newRegion animated:YES];
     }*/
}


- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
	//NSLog(@"%@", @"REGION CHANGED");
	[imv  removeFromSuperview];
	[list removeFromSuperview];
	[im removeFromSuperview];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	// Clear the activeDownload property to allow later attempts
	NSLog(@"%@", error);
    self.activeDownload = nil;
    
	// Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
	UIImage *image2 = [[UIImage alloc] initWithData:self.activeDownload];
    
	if (image.size.width != kAppIconHeight && image.size.height != kAppIconHeight)
	{
        CGSize itemSize = CGSizeMake(kAppIconHeight, kAppIconHeight);
		UIGraphicsBeginImageContext(itemSize);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[image drawInRect:imageRect];
		self.eve2.eventImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
    }
    else
    {
        self.eve2.eventImage = image;
	}
	
	self.eve2.eventImage2 = image2;
	
	//self.appRecord.eventImage2 = image2;
    
    self.activeDownload = nil;
    [image release];
	[image2 release];
    
	// Release the connection now that it's finished
    self.imageConnection = nil;
	
	// call our delegate and tell it that our icon is ready for display
}




- (void)showDetails:(UIButton *)sender
{
	if (eve != nil) {
		Info *inf = [[[Info alloc] init]autorelease];
		inf.title = @"Info";
		inf.app = eve;
		[self.navigationController pushViewController:inf animated:YES];
		//[inf release];
	}
	else {
		Event *mapevent = [[[Event alloc] init]autorelease];
		mapevent.fromCategories = NO;
		mapevent.fromFavourites = NO;
		mapevent.fromMaps = YES;
		mapevent.fromSearch = NO;
		
		if (showall.selected == YES) {
			mapevent.isShowAll = YES;
		}
		else {
			mapevent.isShowAll = NO;
		}
		
		
		if (fromTable == YES) {
            
			mapevent.event = [multiple objectAtIndex:[list indexPathForCell:(UITableViewCell *)sender.superview.superview].row];
			//objindex = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row;		
		}
		else {
			mapevent.event = eve2;
		}
		
		[self.navigationController pushViewController:mapevent animated:YES];
		//[mapevent release];
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Multiple : %i",[multiple count]);
	return [multiple count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    NSLog(@"TBLVewi");
	static NSUInteger const TitleLabelTag = 2;
	static NSUInteger const ButtonTag = 3;
	
	UILabel *titleLabel = nil;	
	UIButton *showEvent = nil;
	
	static NSString *CellIdentifier = @"Cell";	
	UITableViewCell *cell = [list dequeueReusableCellWithIdentifier:CellIdentifier];
    
	AppEvents *listEvent = [multiple objectAtIndex:indexPath.row];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle =   UITableViewCellSelectionStyleNone;
       
		
		//titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 235, 20)] autorelease];
        titleLabel = [[[UILabel alloc] initWithFrame: CGRectMake(10, (cell.frame.size.height ) / 2.0 - 8.0, 235, 20)] autorelease];
		titleLabel.tag = TitleLabelTag;
		titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.textAlignment = UITextAlignmentLeft;
		titleLabel.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:titleLabel];
		
		showEvent = [[UIButton buttonWithType:UIButtonTypeDetailDisclosure] retain];
		[showEvent setFrame:CGRectMake(
                                     243,
                                     cell.frame.size.height/2 - 13,
                                     showEvent.frame.size.width,
                                     showEvent.frame.size.height)];
		showEvent.tag = ButtonTag;
		[showEvent addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
		//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        //[cell setAccessoryAction:@selector(showDetails:)];
        [cell.contentView addSubview:showEvent];
	}
	else{
		titleLabel = (UILabel *)[cell.contentView viewWithTag:TitleLabelTag];
		showEvent = (UIButton *)[cell.contentView viewWithTag:ButtonTag];
	}	
	
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.text = listEvent.eventTitle; 
	
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//return 30;	
    return 50;
}



@end
