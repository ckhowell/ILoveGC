
	//
//  FirstPage.h
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "ILoveGCAppDelegate.h"

#import "Categories.h"

@class Event;
@class AppEvents;

@interface Suburb : UIViewController <UITableViewDelegate ,UIScrollViewDelegate,UIActionSheetDelegate>
{
	
	UIButton *arts;
	UIButton *community;
	UIButton *showall;
	UIButton *food;
	UIButton *sport;

	UIToolbar *tool;
	UIImageView *imgview;
	UISegmentedControl *segment;
	
	UITableView *tableView;
	
    NSArray *sortedArray;
    
	UIImageView *arrow;
	UIImageView *img;

}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, retain) IBOutlet UIToolbar *tool;
@property (nonatomic, retain) IBOutlet UIImageView *imgview;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segment;

@property (nonatomic, retain) IBOutlet UIImageView *img;
@property (nonatomic, retain) IBOutlet UIImageView *arrow;

@property (nonatomic, retain) IBOutlet UIButton *arts;
@property (nonatomic, retain) IBOutlet UIButton *community;
@property (nonatomic, retain) IBOutlet UIButton *showall;
@property (nonatomic, retain) IBOutlet UIButton *sport;
@property (nonatomic, retain) IBOutlet UIButton *food;

@property (nonatomic, retain) NSMutableArray * listOfEvents;
@property (nonatomic, retain) NSMutableArray *suburbArray;
@property (nonatomic, retain) Categories * _category;

@property (nonatomic, retain) IBOutlet UIView * viewBtnBack;
@property (nonatomic, retain) IBOutlet UIView * viewMenu;


- (IBAction) setCategory:(id)sender;
- (IBAction) Refresh;

- (void) setParent: (Categories*) _parent;
- (void) setOptionBtn : (int) _categ;


@end






