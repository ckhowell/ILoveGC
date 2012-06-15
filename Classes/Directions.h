//
//  Directions.h
//  MyProject
//
//  Created by ANDREI A on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>

@interface Directions : UIViewController {

	MKMapView *map;
}

@property (nonatomic, retain) IBOutlet MKMapView *map;

@end
