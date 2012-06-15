//
//  Alarms.h
//  MyProject
//
//  Created by ANDREI A on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppEvents;


@interface Alarms : UIViewController {
	
	UITableView *tableView;
	NSMutableArray *alerts;
	NSDateFormatter *dateFormatter;
	NSDateFormatter *dateFormatter2;
	NSDateFormatter *timeFormatter;
	AppEvents *ape;
	UIButton *editButton;
	UINavigationController *nav;
	NSString *str;
	NSString *alr;
	
	int h;
	NSString *navTitle;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *alerts;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, retain, readonly) NSDateFormatter *dateFormatter2;
@property (nonatomic, retain, readonly) NSDateFormatter *timeFormatter;
@property (nonatomic, retain) UIButton *editButton;
@property (nonatomic, retain) UINavigationController *nav;
@property (nonatomic, retain) NSString *str;
@property (nonatomic, retain) NSString *alr;

@property (nonatomic, retain) AppEvents *ape;
@property (nonatomic, assign) int h;

@end
