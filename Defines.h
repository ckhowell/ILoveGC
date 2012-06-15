//
//  Defines.h
//  ShyBreaker
//
//  Created by Cristian Spissack.
//

#import <MapKit/MapKit.h>

#define TEST_MODE			0


//--------------------------------------------------------------------------------
@class Facebook;



int logged_user_id;
NSMutableString* logged_user_id_fb_string;
NSString* account_facebook;
NSString* account_twitter;
UIImage * myFacebookProfileImage;
NSMutableString* myFacebookName;
Facebook *facebook;
BOOL account_private;

//BOOL flash_screen_did_load_once;

NSFileHandle *cacheFile, *cacheFile2;
CLLocationCoordinate2D last_message_coords;

#pragma mark Florin
	UIActivityIndicatorView *myIndicator;
	UIActivityIndicatorView *mIndicator;
	UIActivityIndicatorView *loading_spot;


int min_day, max_day;

//NSString *deviceID;