//
//  Event.h
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Categories.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FBConnect.h"


@class AppEvents;
@class Favourites;
@class Maps;
@class Alarms;
@class Categories;


@interface Event : UIViewController <MFMailComposeViewControllerDelegate, 
UITabBarControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate,
UIAlertViewDelegate, UINavigationControllerDelegate, FBSessionDelegate, FBRequestDelegate, FBDialogDelegate> {
    
    int shortenMyUrl;
    NSString *shortURL;
	
	UIScrollView *scrollView;
	
	NSString *selectedEvent;
	
	UIButton *favs;
	UIButton *share;
	UIButton *alarm;
	UIButton *map;
	
	UIButton *emailb;
	UIButton *phoneb;
	
    UILabel *addToFav;
    UILabel *showMap;
    UILabel *addAlarm;
    UILabel *sharelbl;
    
	UILabel *web2;
	UILabel *phone2;
	UILabel *email2;	
	UILabel *time;
	UILabel *eventtitle;
	UILabel *eventlocation;
	UILabel *location;
	UILabel *eventtime;
	UILabel *eventdate;
	UILabel *date;
	UILabel *address;
	UILabel *address2;
	UILabel *web;
	UILabel *email;
	UILabel *phone;
	UITextView *textview;
	UIImageView *eventimage;
	
	UIAlertView *alert;
	UIAlertView *alert2;	
	
	double elatitude;
	double elongitude;
	
	NSDateFormatter *dateFormatter;
	NSDateFormatter *timeFormatter;
	
	AppEvents *event;	
	Alarms *alarms;
	Categories *cat;


	NSNotificationCenter *notificationCenter;
	UIActionSheet *action;
	
	NSMutableArray *events;
	NSArray *notifications;
	
	int al2;
	int v;
	int h;
	int d;
	
	BOOL isFriendsMail;
	BOOL isShowAll;
	BOOL isDealloc;
	BOOL fromCategories;
	BOOL fromFavourites;
	BOOL fromMaps;
	BOOL fromSearch;
	
	NSString *navTitle;
	
	NSString *feedbackMsg;
	
	//Facebook *facebook;
	NSArray *permisionsFB;
}

@property (nonatomic, retain) NSArray *permisionsFB;

@property (nonatomic, assign) BOOL isShowAll;
@property (nonatomic, assign) BOOL fromCategories;
@property (nonatomic, assign) BOOL fromFavourites;
@property (nonatomic, assign) BOOL fromMaps;
@property (nonatomic, assign) BOOL fromSearch;

@property (nonatomic, retain) NSString *feedbackMsg;
@property (nonatomic, retain) NSMutableArray *events;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIImageView *eventimage;

@property (nonatomic, retain) IBOutlet UIAlertView *alert;
@property (nonatomic, retain) IBOutlet UIActionSheet *action;
	
@property (nonatomic, retain) IBOutlet UIAlertView *alert2;


@property (nonatomic, retain) IBOutlet UIButton *share;
@property (nonatomic, retain) IBOutlet UIButton *favs;
@property (nonatomic, retain) IBOutlet UIButton *alarm;
@property (nonatomic, retain) IBOutlet UIButton *map;
@property (nonatomic, retain) IBOutlet UIButton *emailb;
@property (nonatomic, retain) IBOutlet UIButton *phoneb;

@property (nonatomic, retain) IBOutlet UILabel *addToFav;
@property (nonatomic, retain) IBOutlet UILabel *showMap;
@property (nonatomic, retain) IBOutlet UILabel *addAlarm;
@property (nonatomic, retain) IBOutlet UILabel *sharelbl;

@property (nonatomic, retain) IBOutlet UILabel *web2;
@property (nonatomic, retain) IBOutlet UILabel *email2;
@property (nonatomic, retain) IBOutlet UILabel *phone2;
@property (nonatomic, retain) IBOutlet UILabel *eventtitle;
@property (nonatomic, retain) IBOutlet UILabel *eventlocation;
@property (nonatomic, retain) IBOutlet UILabel *eventtime;
@property (nonatomic, retain) IBOutlet UILabel *location;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) IBOutlet UILabel *eventdate;
@property (nonatomic, retain) IBOutlet UILabel *date;
@property (nonatomic, retain) IBOutlet UILabel *address;
@property (nonatomic, retain) IBOutlet UILabel *address2;
@property (nonatomic, retain) IBOutlet UILabel *web;
@property (nonatomic, retain) IBOutlet UILabel *email;
@property (nonatomic, retain) IBOutlet UILabel *phone;
@property (nonatomic, retain) IBOutlet UITextView *textview;

@property (nonatomic, assign) double elatitude;
@property (nonatomic, assign) double elongitude;

@property (nonatomic, readonly, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, readonly, retain) NSDateFormatter *timeFormatter;

@property (nonatomic, retain) AppEvents *event;
@property (nonatomic, retain) Alarms *alarms;
@property (nonatomic, retain) Categories *cat;



@property (nonatomic, retain) NSArray *notifications;


-(void) execute;
-(void)displayMailComposerSheet;
@end



