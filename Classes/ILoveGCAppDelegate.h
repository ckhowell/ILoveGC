//
//  MyProjectAppDelegate.h
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


	//http://www.mobisoftinfotech.com/blog/iphone/iphone-open-source-applications/


#import <UIKit/UIKit.h>
#import "ParseOperation.h"
#import "AppEvents.h"
#import "SHK2.h"

@class Categories;
@class Favourites;
@class Maps;
@class More;
@class Event;
@class EventAlert;
@class Search;

//@protocol ILoveGCAppDelegateDelegate;


@interface ILoveGCAppDelegate : NSObject <UIApplicationDelegate, ParseOperationDelegate> {
	
	//id <ILoveGCAppDelegateDelegate> delegate;
	
	UIWindow *window;
	UIWindow *windowiPad;
	
	UINavigationController *navigationController1;
	UINavigationController *navigationController2;
	UINavigationController *navigationController3;
	UINavigationController *navigationController4;
	UINavigationController *searchController;
	UITabBarController *aTabBarController;
    
	
	EventAlert *eval;
    
	More *more;
	AppEvents *event;
	Favourites *fav;
	Event *eve;
    Categories      *categories;
	Maps *map;
	Search *search;
	
	
	NSMutableArray   *eventlist;
	NSArray          *eventlist2; 
	NSMutableArray	 *eventlist3;
	NSMutableArray   *lastSesion;
	
	NSMutableArray   *allPages;
	
    NSOperationQueue		*queue;
    
    NSURLConnection         *appListFeedConnection;
    NSMutableData           *appListData;
	
    BOOL showMapClicked;
	UIImageView *splashView;
	
	BOOL applicationStart;
	BOOL connectionInterrupted;
	
	AppEvents *i;
	
	UIAlertView *alert;
	
	BOOL remove;
	
	AppEvents *objindex;
    NSString *strMenuSelected;
    
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIWindow *windowiPad;

@property (nonatomic, assign) BOOL showMapClicked;
@property (nonatomic, retain) IBOutlet UITabBarController *aTabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController1;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController2;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController3;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController4;
@property (nonatomic, retain) IBOutlet UINavigationController *searchController;
@property (nonatomic, retain) IBOutlet UIImageView *splashView;

@property (nonatomic, retain) IBOutlet UIAlertView *alert;

@property (nonatomic, retain) AppEvents *objindex; 

@property (nonatomic, retain) IBOutlet Categories *categories;
@property (nonatomic, retain) IBOutlet Event *eve;
@property (nonatomic, retain) IBOutlet Maps *map;
@property (nonatomic, retain) AppEvents *event;
@property (nonatomic, retain) IBOutlet More *more;
@property (nonatomic, retain) IBOutlet Search *search;

@property (nonatomic, retain) EventAlert *eval;

@property (nonatomic, retain) IBOutlet Favourites *fav;

@property (nonatomic, retain) NSMutableArray *eventlist;
@property (nonatomic, retain) NSArray *eventlist2;
@property (nonatomic, retain) NSMutableArray *eventlist3;
@property (nonatomic, retain) NSMutableArray *lastSesion;

@property (nonatomic, retain) NSMutableArray *allPages;

@property (nonatomic, retain) NSOperationQueue *queue;

@property (nonatomic, retain) NSURLConnection *appListFeedConnection;
@property (nonatomic, retain) NSMutableData *appListData;

@property (nonatomic, retain) AppEvents *i;
@property (nonatomic, retain) NSString *strMenuSelected;

//@property (nonatomic, assign) id <ILoveGCAppDelegateDelegate> delegate;

- (void)handleError:(NSError *)error;

@end


//@protocol ILoveGCAppDelegateDelegate

//- (void)appFinishLoading:(NSString *)string;

//@end





