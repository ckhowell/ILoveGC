//
//  EventAlert.h
//  MyProject
//
//  Created by ANDREI A on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Alarms;
@class AppEvents;


@interface EventAlert : UIViewController {
	
	UITableView *tableview;
	UINavigationBar *navbar;
	UIBarButtonItem *cancel;
	UIBarButtonItem *done;
	UINavigationItem *item;
	NSMutableArray *list;
	
	NSString *datestr;
	NSString *etitle;
	
	NSDateFormatter *datef;
	NSDate *currdate;
	Alarms *al;
	AppEvents *apev;
	
	int day;
	int hour;
	int minutes;
	int year;
	int month;
	NSString *pm;
	
	NSString *alert;
	
	//NSArray *notifications;
	UILocalNotification *localNotif;
	
	int j;
	int code;
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) IBOutlet UINavigationBar *navbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cancel;
@property (nonatomic, retain) IBOutlet UINavigationItem *item;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *done;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) NSString *datestr;
@property (nonatomic, retain) NSString *etitle;
@property (nonatomic, retain) NSDateFormatter *datef;
@property (nonatomic, retain) NSDate *currdate;
@property (nonatomic, retain) Alarms *al;
@property (nonatomic, retain) AppEvents *apev;
//@property (nonatomic, retain) NSArray *notifications;

@property (nonatomic, retain) UILocalNotification *localNotif;

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minutes;
@property (nonatomic, retain) NSString *pm;

@property (nonatomic, retain) NSString *alert;

-(IBAction) Cancel;
-(IBAction) Done;

@end
