//
//  Favourites.h
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Event.h"

@class Categories;
@class ILoveGCAppDelegate;
@class Event;
@class Alarms;

@interface Favourites : UIViewController {
	
	UITableView *tableView;
	NSMutableArray *listOfItems;
	NSMutableArray *altaLista;
	AppEvents *fevent;
	
	Alarms *alarms;
	
	UIButton *editButton;
	UIButton *alarmButton;
	NSDateFormatter *dateFormatter;	
	NSDateFormatter *dateFormatter2;	
	NSString *alarm;
	UIImage *plistPath;
	
	int objindex;
	int b;
}



@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *altaLista;
@property (nonatomic, retain) AppEvents *fevent;

@property (nonatomic, retain) Alarms *alarms;

@property (nonatomic, retain) UIButton *editButton;
@property (nonatomic, retain) UIButton *alarmButton;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDateFormatter *dateFormatter2;

@property (nonatomic, retain) NSString *alarm;
@property (nonatomic, retain) UIImage *plistPath;

@property (nonatomic, retain) UILabel       *loading_lb;
@property (nonatomic, retain) UIImageView   *loading_iv;

	//-(IBAction)Alarm;

@end



