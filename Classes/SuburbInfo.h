
	//
//  FirstPage.h
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"
#import <QuartzCore/QuartzCore.h>
#import "ILoveGCAppDelegate.h"

@class Event;
@class AppEvents;
@class Maps;


@interface SuburbInfo : UIViewController <UITableViewDelegate ,UIScrollViewDelegate,
                                        UIActionSheetDelegate, IconDownloaderDelegate>
{
	
	UIButton *arts;
	UIButton *community;
	UIButton *showall;
	UIButton *food;
	UIButton *sport;
	
	
	Event *ev;
	
	NSMutableArray *categList;
	NSMutableArray *listOfEvents;
	NSMutableArray *notifications;
	NSMutableArray *events;
	NSMutableArray *selectlist;
	NSMutableArray *lista;
	NSMutableArray *wthot;
	
	UIToolbar *tool;
	UIImageView *imgview;
	UISegmentedControl *segment;
	
	UITableView *tableView;
	
	NSArray *list;
	NSDateFormatter *dateFormatter;
	NSDateFormatter *dateFormatter2;
	NSMutableDictionary *imageDownloadsInProgress; 
	
	UIActivityIndicatorView *activity;	

@public	
	int b;	/////////////////////
	//int h;
	int p;
	int y;
	int categ;
	int objindex;
	
	BOOL isRefreshPressed;
	BOOL secondRefresh;
	BOOL connectionInterrupted;
	BOOL emptyList;
	BOOL emptyLista;///////////
	
	UIImageView *arrow;
	UIImageView *img;
	BOOL showAlert;
    
    BOOL bShowMenuBar;
}
@property (nonatomic, retain) Categories * _category;///////

@property (nonatomic, assign) BOOL connectionInterrupted;
//@property (nonatomic, assign) int y;
//@property (nonatomic, assign) int b;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter2;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic, retain) IBOutlet UIToolbar *tool;
@property (nonatomic, retain) IBOutlet UIImageView *imgview;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segment;

@property (nonatomic, retain) IBOutlet UIImageView *img;
@property (nonatomic, retain) IBOutlet UIImageView *arrow;

//@property (nonatomic, assign) int h;

@property (nonatomic, retain) IBOutlet UIButton *arts;
@property (nonatomic, retain) IBOutlet UIButton *community;
@property (nonatomic, retain) IBOutlet UIButton *showall;
@property (nonatomic, retain) IBOutlet UIButton *sport;
@property (nonatomic, retain) IBOutlet UIButton *food;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *refresh;

@property (nonatomic, retain) IBOutlet UIButton *alarmButton;

@property (nonatomic, retain) IBOutlet Maps *mapView;

@property (nonatomic, retain) Event *ev;

@property (nonatomic, retain) NSMutableArray *categList;
@property (nonatomic, retain) NSMutableArray *listOfEvents;
@property (nonatomic, retain) NSMutableArray *notifications;
@property (nonatomic, retain) NSMutableArray *events;
@property (nonatomic, retain) NSMutableArray *selectlist;
@property (nonatomic, retain) NSMutableArray *lista;
@property (nonatomic, retain) NSMutableArray *wthot;

@property (nonatomic, retain) NSArray *list;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;

@property (nonatomic, retain) IBOutlet UIView * viewBtnBack;
@property (nonatomic, retain) IBOutlet UIView * viewMenu;

- (void)appImageDidLoad:(NSIndexPath *)indexPath; 

- (IBAction) setCategory:(id)sender;
- (IBAction)Refresh;

@end






