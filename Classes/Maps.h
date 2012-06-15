//
//  Maps.h
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "MKMapView+ZoomLevel.h"
#import <QuartzCore/QuartzCore.h>


@class Event;
@class AppEvents;
//@class MapPin;
//@class Info;


@interface Maps : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIApplicationDelegate, MKMapViewDelegate,
CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource> {
	
	CLLocationManager *locationManager;
	IBOutlet UIView *view1;
	//MKReverseGeocoder *reverseGeocoder;
    
    //UIBarButtonItem *getAddressButton;
	
	//MKUserLocation *userloc;
	
	//CLLocationCoordinate2D location;
	
	//MKPlacemark *placemark;
	
	//MKPolyline *_routeLine;
	//MKPolylineView *_routeLineView;
	//MKMapRect _routeRect;
	
	MKPinAnnotationView *customPinView;
	
	double lat;
	double lon;
    UIActionSheet *Sheet;
    
    NSMutableArray *mapCats;
    NSString *mapCat;
	
	AppEvents *eve;
	AppEvents *eve2;
	MKMapView *map;
	Event *ev;
	NSString *st;
	
	NSMutableArray *event;
	NSMutableArray *mapAnnotations;
	NSMutableArray *extremes;
	NSMutableArray *duplicates;
	//NSMutableArray *overlays;
	
	//MapPin *pin;
	//Info *inf;
	
	//IBOutlet UIView *portrait;
	//IBOutlet UIView *landscape;
	
	NSString *n;
	
	//NSMutableArray *mylocation;
	
	//CLLocation *startLocation;
	
	UIButton *arts;
	UIButton *community;
	UIButton *showall;
	UIButton *food;
	UIButton *sport;
	
	UIActivityIndicatorView *activity;
	
	NSURLConnection *imageConnection;
	NSMutableData *activeDownload;
	
	BOOL fromMaps;
	NSString *navTitle;
	
	UITableView *list;
	UIImageView *im;
	UIImageView *imv;
	NSMutableArray *multiple;
	BOOL fromTable;
}

@property(nonatomic,retain) NSString *mapCat;
@property (nonatomic, assign) BOOL fromMaps;
@property(nonatomic,retain)UIView *view1;
@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

@property (nonatomic, retain) IBOutlet UIButton *arts;
@property (nonatomic, retain) IBOutlet UIButton *community;
@property (nonatomic, retain) IBOutlet UIButton *showall;
@property (nonatomic, retain) IBOutlet UIButton *sport;
@property (nonatomic, retain) IBOutlet UIButton *food;
@property (nonatomic, retain) IBOutlet UITableView *list;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic, retain) IBOutlet MKPinAnnotationView *customPinView;

//@property (nonatomic, retain) MKUserLocation *userloc;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet MKMapView *map;
//@property (nonatomic, readonly) CLLocationCoordinate2D location;
//@property (nonatomic, retain) IBOutlet MKPlacemark *placemark;

@property (nonatomic, retain) NSMutableArray *event;
@property (nonatomic, retain) NSMutableArray *mapAnnotations;
@property (nonatomic, retain) NSMutableArray *extremes;
@property (nonatomic, retain) NSMutableArray *duplicates;
//@property (nonatomic, retain) NSMutableArray *mylocation;
//@property (nonatomic, retain) NSMutableArray *overlays;

@property (nonatomic, retain) NSString *n;

@property (nonatomic, retain) AppEvents *eve;
@property (nonatomic, retain) AppEvents *eve2;
@property (nonatomic, retain) Event *ev;
@property (nonatomic, retain) NSString *st;  
//@property (nonatomic, retain) Info *inf; 

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;

//@property (nonatomic, retain) MapPin *pin;

//@property(nonatomic,retain) UIView *portrait;
//@property(nonatomic,retain) UIView *landscape;

//@property (nonatomic, retain) CLLocation *startLocation;

//@property (nonatomic, retain) MKPolyline* routeLine;
//@property (nonatomic, retain) MKPolylineView* routeLineView;


//-(void) loadRoute;

	// use the computed _routeRect to zoom in on the route. 
//-(void) zoomInOnRoute;

@end

