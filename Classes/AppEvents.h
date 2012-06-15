
#import <Foundation/Foundation.h>
	//#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>



@interface AppEvents: NSObject <MKAnnotation, NSCoding>
{
	NSString *alarmbut;
	
	NSString *eventTitle;
	NSString *description;
	UIImage *eventImage;
	UIImage *eventImage2; 
	NSString *imageURLString;
	NSString *imageURLString2;
	NSString *cost;	
	NSDate *date;
	NSDate *date2; 
	NSDate *time;
	NSDate *time2;
	NSDate *completdate;
	NSString *comdate;
	NSString *email;
	NSString *phone;
	NSString *web;
	
	double latitude;
	double longitude;
	
	NSString *category;
	NSString *location;
	NSString *street;
	NSString *postcode;
	NSString *country;
	NSString *region;
	
	NSData *data;
	NSData *data2;
	
	NSString *cmsoon;
	NSString *wtshot;
	
	NSString *alarme;
	
	int index;
	int intr;
	int img;
	
	int index2;
	int intr2;
	int img2;
	
	int index3;
	int intr3;
	int img3;	
	
	int invalid;
	int favs;
	
	int idcod;
}

@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *eventTitle;
@property (nonatomic, retain) UIImage *eventImage;
@property (nonatomic, retain) UIImage *eventImage2;
@property (nonatomic, retain) NSString *imageURLString;
@property (nonatomic, retain) NSString *imageURLString2;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *cost;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSDate *date2;
@property (nonatomic, retain) NSDate *time;
@property (nonatomic, retain) NSDate *time2;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *web;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSData *data;
@property (nonatomic, retain) NSData *data2;
@property (nonatomic, retain) NSDate *completdate;

@property (nonatomic, retain) NSString *comdate;
@property (nonatomic, retain) NSString *alarmbut;
@property (nonatomic, retain) NSString *cmsoon;
@property (nonatomic, retain) NSString *wtshot;

@property (nonatomic, retain) NSString *alarme;
@property (nonatomic, assign) int intr;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) int img;

@property (nonatomic, assign) int intr2;
@property (nonatomic, assign) int index2;
@property (nonatomic, assign) int img2;

@property (nonatomic, assign) int intr3;
@property (nonatomic, assign) int index3;
@property (nonatomic, assign) int img3;

@property (nonatomic, assign) int invalid;
@property (nonatomic, assign) int favs;

@property (nonatomic, assign) int idcod;

@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *postcode;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *region;
@property (nonatomic, retain) NSString * shURL;

@end