//
//  Categories.h
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"

@class Categories;

@interface Search : UIViewController <UISearchBarDelegate, UITableViewDelegate, 
UIScrollViewDelegate, IconDownloaderDelegate>
{	
	
	UISearchBar *searchBar;
	UITableView *tableView;
	
	
	UIButton *alarmButton;
	
	NSMutableArray *list;
	NSMutableArray *tabledata;
	NSMutableArray *searchArray;
	NSMutableArray *last;

	NSDateFormatter *datef;
	NSDateFormatter *datef2;
	
	NSMutableDictionary *imageDownloadsInProgress;
	UIActivityIndicatorView *activity;
	
	int b;
	int g;
	int objindex;
	
	BOOL textChanged;
}


@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic, retain) IBOutlet UIButton *alarmButton;

@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) NSMutableArray *tabledata;
@property (nonatomic, retain) NSMutableArray *searchArray;
@property (nonatomic, retain) NSMutableArray *last;

@property (nonatomic, retain) NSDateFormatter *datef;
@property (nonatomic, retain) NSDateFormatter *datef2;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;

@property (nonatomic, retain) UILabel       *loading_lb;
@property (nonatomic, retain) UIImageView   *loading_iv;


- (void)appImageDidLoad:(NSIndexPath *)indexPath;

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end
