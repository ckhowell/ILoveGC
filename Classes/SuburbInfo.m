//
//  FirstPage.m
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ILoveGCAppDelegate.h"
#import "SuburbInfo.h"
#import "Event.h"
#import "Favourites.h"
#import "AppEvents.h"
#import "ParseOperation.h"
#import "Maps.h"
#import <CFNetwork/CFNetwork.h>
#import "Alarms.h"

#import "Suburb.h"

#define kCustomRowHeight    63.0
#define kDiscIcon 25

#define BTN_TAG_ALL    185
#define BTN_TAG_ARTS   186
#define BTN_TAG_COMMUNITY   187
#define BTN_TAG_FOOD    188
#define BTN_TAG_SPORT   189

@interface SuburbInfo ()

- (void)startIconDownload:(AppEvents *)appRecord forIndexPath:(NSIndexPath *)indexPath;

@end


@implementation SuburbInfo

@synthesize ev, arts, community, list, showall, sport, food, lista, wthot, connectionInterrupted;
@synthesize listOfEvents, tableView, categList, imageDownloadsInProgress, notifications, alarmButton;
@synthesize dateFormatter, mapView, activity, tool, events, img, selectlist, refresh, segment, arrow;
@synthesize dateFormatter2, imgview;
@synthesize viewMenu, viewBtnBack;
@synthesize _category;/////////////

- (void)viewDidLoad {
	[super viewDidLoad];
	ILoveGCAppDelegate *appDelegate = (ILoveGCAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.strMenuSelected = @"ALL";
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	
	self.tableView.userInteractionEnabled = NO;
	
	
	activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activity.center = CGPointMake(160,180);	
    activity.color = [UIColor blackColor];
    
	
	self.tableView.rowHeight = kCustomRowHeight;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;	
	
    
    // Filter buttons
	arrow = [[UIImageView alloc] initWithFrame:CGRectMake(25, 63, 15.5, 7)]; 
	UIImage *arw = [UIImage imageNamed:@"Show_All_Arrow.png"];
	arrow.image = arw;
	arrow.backgroundColor = [UIColor clearColor];	
	[self.view addSubview:arrow];
    
	showall = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	showall.frame = CGRectMake(0, 4, 64, 59);
	showall.backgroundColor = [UIColor blackColor];
	[showall setBackgroundImage:[UIImage imageNamed:@"Show_All_Off.png"] forState:UIControlStateNormal];
	[showall setBackgroundImage:[UIImage imageNamed:@"Show_All_On.png"] forState:UIControlStateSelected];
	[showall setSelected:YES];
    showall.tag = BTN_TAG_ALL;
	[showall addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:showall];	
	
	arts = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	arts.frame = CGRectMake(64, 4, 64, 59);
	arts.backgroundColor = [UIColor blackColor];
	[arts setBackgroundImage:[UIImage imageNamed:@"Arts_Off.png"] forState:UIControlStateNormal];
	[arts setBackgroundImage:[UIImage imageNamed:@"Arts_On.png"] forState:UIControlStateSelected];
    arts.tag = BTN_TAG_ARTS;
	[arts addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:arts];	
	
	community = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	community.frame = CGRectMake(128, 4, 64, 59);
	community.backgroundColor = [UIColor blackColor];
	[community setBackgroundImage:[UIImage imageNamed:@"Comm_Off.png"] forState:UIControlStateNormal];
	[community setBackgroundImage:[UIImage imageNamed:@"Comm_On.png"] forState:UIControlStateSelected];
    community.tag = BTN_TAG_COMMUNITY;
	[community addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:community];	
	
	food = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	food.frame = CGRectMake(192, 4, 64, 59);
	food.backgroundColor = [UIColor blackColor];
	[food setBackgroundImage:[UIImage imageNamed:@"Food_Off.png"] forState:UIControlStateNormal];
	[food setBackgroundImage:[UIImage imageNamed:@"Food_On.png"] forState:UIControlStateSelected];
    food.tag = BTN_TAG_FOOD;
	[food addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:food];	
	
	sport = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	sport.frame = CGRectMake(256, 4, 64, 59);
	sport.backgroundColor = [UIColor blackColor];
	[sport setBackgroundImage:[UIImage imageNamed:@"Sport_Off.png"] forState:UIControlStateNormal];
	[sport setBackgroundImage:[UIImage imageNamed:@"Sport_On.png"] forState:UIControlStateSelected];
    sport.tag = BTN_TAG_SPORT;
	[sport addTarget:self action:@selector(clickMenuBtn:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:sport];	
	
	
    // toolbar
	imgview = [[UIImageView alloc] initWithFrame:tool.frame];
	imgview.backgroundColor = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0];
	tool.tintColor = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
	[tool insertSubview:imgview atIndex:0];
    
	// gesture pink
    UILongPressGestureRecognizer *longpressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewShowHideMenu:)];
    [viewMenu addGestureRecognizer:longpressGesture];
    [longpressGesture release];
    
    
	events = [[NSMutableArray alloc] init];
    
	
	if ([UIApplication sharedApplication].networkActivityIndicatorVisible == YES) {
        
		[food setUserInteractionEnabled:NO];
		[sport setUserInteractionEnabled:NO];
		[showall setUserInteractionEnabled:NO];
		[community setUserInteractionEnabled:NO];
		[arts setUserInteractionEnabled:NO];
		[tool setUserInteractionEnabled:NO];
		[self.tableView setUserInteractionEnabled:NO];
	}
	else {
		
		[food setUserInteractionEnabled:YES];
		[sport setUserInteractionEnabled:YES];
		[showall setUserInteractionEnabled:YES];
		[community setUserInteractionEnabled:YES];
		[arts setUserInteractionEnabled:YES];
		[tool setUserInteractionEnabled:YES];
		[self.tableView setUserInteractionEnabled:YES];
	}
	
	img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	img.backgroundColor = [UIColor whiteColor];
	img.alpha = 0.2;
	
	[self.view addSubview:img];
	[self.img addSubview: activity];
	[activity startAnimating];
	
	showAlert = YES;
	
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
    
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil)
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    
    //Set the title
	self.navigationItem.title = @"gold-iron";
    
	
    UIColor * colorTool = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
    if (showall.selected == YES) {
        colorTool = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
    } else if (arts.selected == YES) {
        colorTool = [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0];  
    } else if (community.selected == YES) {
        colorTool = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];  
    } else if (food.selected == YES){
        colorTool = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0]; 
    } else if (sport.selected == YES) {
        colorTool = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
    }
	//self.navigationController.navigationBar.tintColor  = colorTool;
    
    if (bShowMenuBar == NO) {
        self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
        
        self.tableView.frame = CGRectMake(0, 113-70, 320, 255 + 70);
        
        arrow.alpha = 0.0;
    } else {
        self.viewMenu.frame = CGRectMake(0, 70, viewMenu.frame.size.width, viewMenu.frame.size.height);
        self.tableView.frame = CGRectMake(0, 113, 320, 255);
        
        arrow.alpha = 1.0;
    }

}



- (void)dealloc {
	
	[imgview release];
	
	[arrow release];
	[alarmButton release];
	
	[events release];
	[activity release];
	
	[imageDownloadsInProgress release];
	[dateFormatter release];
	[dateFormatter2 release];
	
	[showall release];	
	[categList release];
	[notifications release];
	
	[list release];
	[arts release];
	[community release];
	[sport release];
	[food release];
	
	[img release];
	[tool release];
	[segment release];
	[ev release];
	
	//[selectlist release];
	[tableView release];
	//[listOfEvents release];
	//[lista release];
	//[wthot release];
	
	[mapView release];
	
    [viewMenu release];
    [viewBtnBack release];
    
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	
	NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
	[allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
}




- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
		[dateFormatter setDateFormat:@"dd MMMM yyyy"];
	}
    return dateFormatter;
}

- (NSDateFormatter *)dateFormatter2 {
    if (dateFormatter2 == nil) {
        dateFormatter2 = [[NSDateFormatter alloc] init];
		[dateFormatter2 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateFormatter2 setTimeZone:[NSTimeZone localTimeZone]];
		[dateFormatter2 setDateFormat:@"dd MMMM yyyy"];
	}
    return dateFormatter2;
}


- (void)viewDidUnload {
	[super viewDidUnload];
}


-(IBAction)Refresh{

    Suburb * controller = [[Suburb alloc] init];
    [controller setParent:self];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
//	showAlert = YES;
//	y = 1;
//	isRefreshPressed = YES;
//	b = -1;
//	
//	categList = nil;
//	listOfEvents = nil;
//	[lista release];
//	[selectlist release];
//	[wthot release];
//	[self.tableView reloadData];
//	
//	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
//	
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshEvents" object:nil];
//	
//	[activity startAnimating];	
}

- (void)clickMenuBtn:(UIButton *)sender {
	int tag = sender.tag;
    ILoveGCAppDelegate *appDelegate = (ILoveGCAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    UIColor * colorTool;
    switch (tag) {
        case BTN_TAG_ALL:
            colorTool = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
            break;
        case BTN_TAG_ARTS:
            colorTool = [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0];  
            break;
        case BTN_TAG_COMMUNITY:
            colorTool = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];  
            break;
        case BTN_TAG_FOOD:
            colorTool = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0]; 
            break;
        case BTN_TAG_SPORT:
            colorTool = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
            break;
    }
	tool.tintColor = colorTool; 
	imgview.backgroundColor = colorTool;
	//self.navigationController.navigationBar.tintColor  = colorTool; 	
	
    [showall setSelected:NO];
	[arts setSelected:NO];
	[community setSelected:NO];
    [food setSelected:NO];
	[sport setSelected:NO];
    switch (tag) {
        case BTN_TAG_ALL:
            appDelegate.strMenuSelected = @"ALL";
            arrow.frame = CGRectMake(25, 63, 15.5, 7);
            arrow.image = [UIImage imageNamed:@"Show_All_Arrow.png"];
            
            [showall setSelected:YES];
            break;
        case BTN_TAG_ARTS:
           	arrow.frame = CGRectMake(89, 63, 15.5, 7);
            arrow.image = [UIImage imageNamed:@"Arts_Arrow.png"];
            
            [arts setSelected:YES];
            break;
        case BTN_TAG_COMMUNITY:
            arrow.frame = CGRectMake(153, 63, 15.5, 7);
            arrow.image = [UIImage imageNamed:@"Comm_Arrow.png"];
            
            [community setSelected:YES];
            break;
        case BTN_TAG_FOOD:
            arrow.frame = CGRectMake(217, 63, 15.5, 7);
            arrow.image = [UIImage imageNamed:@"Food_Arrow.png"];
            
            [food setSelected:YES];
            break;
        case BTN_TAG_SPORT:
            arrow.frame = CGRectMake(280, 63, 15.5, 7);
            arrow.image = [UIImage imageNamed:@"Sport_Arrow.png"];
            
            [sport setSelected:YES];
            break;
    }
	
	if (categ == 0) {
		if ([_category.lista count] != 0) {
			[listOfEvents removeAllObjects];
			[listOfEvents addObjectsFromArray:_category.lista];
		}
	}
	else if (_category->categ == 1) {
		if ([_category.selectlist count] != 0) {
			[listOfEvents removeAllObjects];
			[listOfEvents addObjectsFromArray:_category.selectlist];
		}
	}
	else if (_category->categ == 2) {
		if ([_category.wthot count] != 0) {
			[listOfEvents removeAllObjects];
			[listOfEvents addObjectsFromArray:_category.wthot];
		}
	}
	
	for (int i=0;i<[listOfEvents count];i++) {
		AppEvents *ap = [listOfEvents objectAtIndex:i];
		if(ap.intr == 1){
			ap.intr = 0;
			ap.img = 0;
			[listOfEvents replaceObjectAtIndex:i withObject:ap];
		}
	}
	
	[tableView reloadData];
	
	if ([listOfEvents count] != 0) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
	}
	
}



- (void)viewShowHideMenu:(UIGestureRecognizer *)gestureRecognizer {
    if ( gestureRecognizer.state == UIGestureRecognizerStateEnded ) {
        if (bShowMenuBar == NO) {
            self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
            
            self.tableView.frame = CGRectMake(0, 113-70, 320, 255 + 70);
            
            arrow.alpha = 0.0;
        } else {
            self.viewMenu.frame = CGRectMake(0, 70, viewMenu.frame.size.width, viewMenu.frame.size.height);
            self.tableView.frame = CGRectMake(0, 113, 320, 255);
            
            arrow.alpha = 1.0;
        }
        
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDidStopSelector:@selector(endAnimation)];
        
        if (bShowMenuBar == NO){
            self.viewMenu.frame = CGRectMake(0, 70, viewMenu.frame.size.width, viewMenu.frame.size.height);
            self.tableView.frame = CGRectMake(0, 113, 320, 255);
            
            arrow.alpha = 1.0;
        } else {
            self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
            self.tableView.frame = CGRectMake(0, 113-70, 320, 255 + 70);
            
            arrow.alpha = 0.0;
        }
        
        [UIView commitAnimations];
        
    }

}
- (void) endAnimation{
    bShowMenuBar = !bShowMenuBar;
}


- (IBAction)setCategory:(id)sender
{
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    
    [listOfEvents removeAllObjects];

	
	if (((UISegmentedControl *)sender).selectedSegmentIndex == 0) {
        categ = 0;
        [listOfEvents addObjectsFromArray:lista];
		
	}
	else if (((UISegmentedControl *)sender).selectedSegmentIndex == 1) {
        categ = 1;
		
		[listOfEvents addObjectsFromArray:selectlist];
        
	}
	else if (((UISegmentedControl *)sender).selectedSegmentIndex == 2) {
        categ = 2;
        
		[listOfEvents addObjectsFromArray:wthot];

	}
    
    for (int i=0;i<[listOfEvents count];i++) {
        AppEvents *ap = [listOfEvents objectAtIndex:i];
        if(ap.intr == 1){
            ap.intr = 0;
            ap.img = 0;
            [listOfEvents replaceObjectAtIndex:i withObject:ap];
        }
    }
    
    [tableView reloadData];
    
    if ([listOfEvents count] != 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//NSLog(@"%d", [categList count]);
	
	if ([UIApplication sharedApplication].networkActivityIndicatorVisible == NO) {
		
		[activity stopAnimating];
		[activity setHidden:YES];
		[img removeFromSuperview];
		activity.center = CGPointMake(160, 240);
		[self.view addSubview:activity];
		
		[food setUserInteractionEnabled:YES];
		[sport setUserInteractionEnabled:YES];
		[showall setUserInteractionEnabled:YES];
		[community setUserInteractionEnabled:YES];
		[arts setUserInteractionEnabled:YES];
		[tool setUserInteractionEnabled:YES];
		[self.tableView setUserInteractionEnabled:YES];
		
        
        // today
		if(categ == 0){
			
			if (isRefreshPressed == YES || secondRefresh == YES) {
				if (secondRefresh == YES) {
					[listOfEvents removeAllObjects];
					[listOfEvents addObjectsFromArray:lista];
					
					secondRefresh = NO;
				}
				
				isRefreshPressed = NO;
				secondRefresh = YES;
			}			
			else {
				if ([lista count] == 0) {
					[listOfEvents removeAllObjects];
				}
			}
			
			if (arts.selected == YES) {
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Arts"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];	
				
				if ([listOfEvents count] == 0) {
					emptyList = YES;
				}
				else {
					emptyList = NO;
				}	
				
				if ([listOfEvents count] == 0 && [lista count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[lista count];i++) {
						if ([[[lista objectAtIndex:i] category] isEqual:@"Arts"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}
				}
			}
			else if(food.selected == YES){
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Food"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				if ([listOfEvents count] == 0) {
					emptyList = YES;
				}
				else {
					emptyList = NO;
				}	
				
				if ([listOfEvents count] == 0 && [lista count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[lista count];i++) {
						if ([[[lista objectAtIndex:i] category] isEqual:@"Food"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}						
				}
			}
			else if(sport.selected == YES){
                
                NSLog(@"PRESSED SPORT");
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Sport"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				if ([listOfEvents count] == 0) {
					emptyList = YES;
				}
				else {
					emptyList = NO;
				}					
				
				
				if ([listOfEvents count] == 0 && [lista count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[lista count];i++) {
						if ([[[lista objectAtIndex:i] category] isEqual:@"Sport"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}	
				}
			}
			else if(community.selected == YES){
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Community"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				
				if ([listOfEvents count] == 0 && [lista count] != 0) {
					
					emptyList = YES;
				
					
					for (int i = 0;i<[lista count];i++) {
						if ([[[lista objectAtIndex:i] category] isEqual:@"Community"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}						
				}
			}
			else {
				/*if ([listOfEvents count] == 0) {
					emptyList = YES;
				}
				else{
					emptyList = NO;
				}*/
			}
			
			for (AppEvents *ap in listOfEvents) {
				if(ap.eventImage){
					[activity stopAnimating];
					[activity setHidden:YES];
				}
			}	
			
			if ([listOfEvents count] == 0) {
				[activity stopAnimating];
				[activity setHidden:YES];
			}
			
			
			if ([UIApplication sharedApplication].networkActivityIndicatorVisible == NO) {
				if ([listOfEvents count] == 0 && categ == 0 && emptyList == NO && emptyLista == YES) { //&& y == 0) {
					if (connectionInterrupted == NO) {
						/*UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																			message:@"There are no events for today"
																		   delegate:nil 
																  cancelButtonTitle:@"Ok"
																  otherButtonTitles:nil];	
						[alertview show];
						[alertview release];*/
						
						emptyList = YES;
					}
					
					y = 1;
				}
				
			}			
		}	
		
        // ---------------------------------------------------------------------------------------------------------
        // coming soon
		else if(categ == 1){
			
			if (isRefreshPressed == YES || secondRefresh == YES) {
				if (secondRefresh == YES) {
					[listOfEvents removeAllObjects];
					[listOfEvents addObjectsFromArray:selectlist];
					
					/*for (int i=0;i<[listOfEvents count];i++) {
						AppEvents *ap = [listOfEvents objectAtIndex:i];
						if(ap.intr == 1){
							ap.intr = 0;
							ap.img = 0;
							[listOfEvents replaceObjectAtIndex:i withObject:ap];
						}
					}*/
					
					secondRefresh = NO;
				}
				
				isRefreshPressed = NO;
				secondRefresh = YES;
			}
			else {
				if ([selectlist count] == 0) {
					[listOfEvents removeAllObjects];
				}
			}
			
			if (arts.selected == YES) {
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Arts"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				//NSLog(@"%d", [listOfEvents count]);
				[arr release];
				
				for (int i = 0;i<[selectlist count];i++) {
					if ([[[selectlist objectAtIndex:i] category] isEqual:@"Arts"]) {
						showAlert = NO;
					}
				}
				
				if (showAlert==YES) {
					/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                     message:@"There are no events in this category"
                     delegate:nil 
                     cancelButtonTitle:@"Ok"
                     otherButtonTitles:nil];	
                     [alertview show];
                     [alertview release];*/
					showAlert = NO;
				}
			}
			else if(food.selected == YES){
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Food"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				for (int i = 0;i<[selectlist count];i++) {
					if ([[[selectlist objectAtIndex:i] category] isEqual:@"Food"]) {
						showAlert = NO;
					}
				}
				
				if (showAlert==YES) {
					/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                     message:@"There are no events in this category"
                     delegate:nil 
                     cancelButtonTitle:@"Ok"
                     otherButtonTitles:nil];	
                     [alertview show];
                     [alertview release];*/
					showAlert = NO;
				}
			}
            
			else if(sport.selected == YES){
                
                
                NSLog(@"SPORTS HERE");
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Sport"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
                
                NSLog(@"NUMBER OF ROWS IN SECTION %d", [selectlist count]);
                int nr=0;
				for (int i = 0;i<[selectlist count];i++) {
					if ([[[selectlist objectAtIndex:i] category] isEqual:@"Sport"]) {
                        nr++;
						showAlert = NO;
					}
				}
                NSLog(@"NR %d", nr);
				
				if (showAlert==YES) {
					/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                     message:@"There are no events in this category"
                     delegate:nil 
                     cancelButtonTitle:@"Ok"
                     otherButtonTitles:nil];	
                     [alertview show];
                     [alertview release];*/
					showAlert = NO;
				}
			}
			else if(community.selected == YES){
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Community"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				//NSLog(@"%d", [listOfEvents count]);
				[arr release];
				
				for (int i = 0;i<[selectlist count];i++) {
					if ([[[selectlist objectAtIndex:i] category] isEqual:@"Community"]) {
						showAlert = NO;
					}
				}
				
				if (showAlert==YES) {
					/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                     message:@"There are no events in this category"
                     delegate:nil 
                     cancelButtonTitle:@"Ok"
                     otherButtonTitles:nil];	
                     [alertview show];
                     [alertview release];*/
					showAlert = NO;
				}
			}
			else {

			}
			
			//Events on the next 3 months
			
			for (AppEvents *ap in listOfEvents) {
				if(ap.eventImage){
					[activity stopAnimating];
					[activity setHidden:YES];
				}
			}	
			
			if ([listOfEvents count] == 0) {
				[activity stopAnimating];
				[activity setHidden:YES];
			}
		}
		else if(categ == 2){
			
			
			if (isRefreshPressed == YES || secondRefresh == YES) {
				if (secondRefresh == YES) {
					[listOfEvents removeAllObjects];
					[listOfEvents addObjectsFromArray:wthot];
					
					
					secondRefresh = NO;
				}
				
				isRefreshPressed = NO;
				secondRefresh = YES;
			}			
			else {
				if ([wthot count] == 0) {
					[listOfEvents removeAllObjects];
				}
			}

			
			if (arts.selected == YES) {
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];	
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Arts"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				
				if ([listOfEvents count] == 0 && [wthot count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[wthot count];i++) {
						if ([[[wthot objectAtIndex:i] category] isEqual:@"Arts"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}	
				}

			}
			else if(food.selected == YES){
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Food"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				

				if ([listOfEvents count] == 0 && [wthot count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[wthot count];i++) {
						if ([[[wthot objectAtIndex:i] category] isEqual:@"Food"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}
				}
			}
			else if(sport.selected == YES){
                
             
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Sport"]) {
                        NSLog(@"EVENT %@", ap.eventTitle);
                        [arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				if ([listOfEvents count] == 0 && [wthot count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[wthot count];i++) {
						if ([[[wthot objectAtIndex:i] category] isEqual:@"Sport"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}
				}
			}
			else if(community.selected == YES){
				self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
				
				[activity startAnimating];
				[activity setHidden:NO];
				
				NSMutableArray *arr = [[NSMutableArray alloc] init];
				for(AppEvents *ap in listOfEvents){
					if([ap.category isEqual:@"Community"]) {
						[arr addObject:ap];
					}
				}	
				
				[listOfEvents removeAllObjects];
				[listOfEvents addObjectsFromArray:arr];
				[arr release];
				
				if ([listOfEvents count] == 0 && [wthot count] != 0) {
					
					emptyList = YES;
					
					for (int i = 0;i<[wthot count];i++) {
						if ([[[wthot objectAtIndex:i] category] isEqual:@"Community"]) {
							showAlert = NO;
						}
					}
					
					if (showAlert==YES) {
						/*	UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                         message:@"There are no events in this category"
                         delegate:nil 
                         cancelButtonTitle:@"Ok"
                         otherButtonTitles:nil];	
                         [alertview show];
                         [alertview release];*/
						showAlert = NO;
					}	
				}
			}
			else {

			}
			
			for (AppEvents *ap in listOfEvents) {
				if(ap.eventImage){
					[activity stopAnimating];
					[activity setHidden:YES];
				}
			}	
			
			if ([listOfEvents count] == 0) {
				[activity stopAnimating];
				[activity setHidden:YES];
			}
			
			
			if ([UIApplication sharedApplication].networkActivityIndicatorVisible == NO) {
				if ([listOfEvents count] == 0 && categ == 2 && emptyList == NO) { //&& y == 0) {
					if (connectionInterrupted == NO) {
						/*UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																			message:@"There are no events for What's Hot"
																		   delegate:nil 
																  cancelButtonTitle:@"Ok"
																  otherButtonTitles:nil];	
						[alertview show];
						[alertview release];*/
						
						emptyList = YES;
					}
					
					y = 1;
				}
			}			
		}
	}
			
	int count = [listOfEvents count];
	return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	isRefreshPressed = NO;
	
	static NSUInteger const TitleLabelTag = 2;
	static NSUInteger const LocationLabelTag = 3;
	static NSUInteger const DateLabelTag = 4;
	static NSUInteger const AccesoryTag = 5;
	//static NSUInteger const AlarmButtonTag = 6;
    
	UIImageView *accesory = nil;
	UILabel *titleLabel = nil;
	UILabel *locationLabel = nil;
	UILabel *dateLabel = nil;
		
	static NSString *CellIdentifier = @"EventsTableCell";
	
	int nodeCount = [self.listOfEvents count];	
	
	AppEvents *appRecord = [self.listOfEvents objectAtIndex:indexPath.row];
	//NSLog(@"%d", indexPath.row);
	
	NSCalendar *calendar = [NSCalendar currentCalendar];			
	NSDateComponents *components = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | 
														 kCFCalendarUnitDay) fromDate:appRecord.date];
	
	NSDateComponents *components2 = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | 
														  kCFCalendarUnitDay) fromDate:appRecord.date2];			
	int year = [components year];
	int month = [components month];
	int day = [components day];
	
	int year2 = [components2 year];
	int month2 = [components2 month];
	int day2 = [components2 day];
	
	if(month==month2 && year==year2 && day==day2){
		appRecord.date2 = nil;
		[self.dateFormatter setDateFormat:@"dd MMMM yyyy"];
	}
	else if(month==month2 && year==year2){
		[self.dateFormatter setDateFormat:@"dd"];
	}
	else {
		[self.dateFormatter setDateFormat:@"dd MMMM yyyy"];
	}	
	
	
	int n = appRecord.intr;
		
		UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
		
			titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 20, 215, 20)] autorelease];
			titleLabel.tag = TitleLabelTag;
			titleLabel.backgroundColor = [UIColor clearColor];
			titleLabel.font = [UIFont boldSystemFontOfSize:16];
			[cell.contentView addSubview:titleLabel];
		
			locationLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 43, 215, 14)] autorelease];
			locationLabel.tag = LocationLabelTag;
			locationLabel.backgroundColor = [UIColor clearColor];
			locationLabel.font = [UIFont italicSystemFontOfSize:12];
			[cell.contentView addSubview:locationLabel];
		
			dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 6, 215, 14)] autorelease];
			dateLabel.tag = DateLabelTag;
			dateLabel.backgroundColor = [UIColor clearColor];
			dateLabel.font = [UIFont boldSystemFontOfSize:12];
			[cell.contentView addSubview:dateLabel];
			
			
			/*alarmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
			alarmButton.frame = CGRectMake(250, 4, 25, 55);
			alarmButton.backgroundColor = [UIColor clearColor];
			alarmButton.tag = AlarmButtonTag;
			[alarmButton setUserInteractionEnabled:YES];
			[alarmButton setHidden:NO];
			[cell.contentView addSubview:alarmButton];
			[alarmButton addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];				
			*/
		
			accesory = [[[UIImageView alloc] initWithFrame:CGRectMake(286.6, 20.2, 22.8, 22.8)] autorelease];
			accesory.tag = AccesoryTag;
			[cell.contentView addSubview:accesory];
					
		}
		else{
		
			titleLabel = (UILabel *)[cell.contentView viewWithTag:TitleLabelTag];
			locationLabel = (UILabel *)[cell.contentView viewWithTag:LocationLabelTag];
			dateLabel = (UILabel *)[cell.contentView viewWithTag:DateLabelTag];
			//alarmButton = (UIButton *)[cell.contentView viewWithTag:AlarmButtonTag];
			accesory = (UIImageView *)[cell.contentView viewWithTag:AccesoryTag];
		}
		
		if (nodeCount > 0)
		{
			if(n == 0){
				UIImageView *aview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 63)] autorelease];
				aview.image = [UIImage imageNamed:@"back tab 1.png"];
				cell.backgroundView = aview;	
				
				titleLabel.textColor = [UIColor whiteColor];
				locationLabel.textColor = [UIColor whiteColor];
				dateLabel.textColor =  [UIColor grayColor];
				
				/*UIImage *buttonImage;
				if ([appRecord.alarmbut isEqual:@"aa"]) {
					buttonImage = [UIImage imageNamed:@"bell_magenta.png"];
					[alarmButton setImage:buttonImage forState:UIControlStateNormal];
				}*/
			}
			else{
				UIImageView *aview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 63)] autorelease];
				aview.image = [UIImage imageNamed:@"back tab 2.png"];
				cell.backgroundView = aview;	
				
				titleLabel.textColor = [UIColor blackColor];
				locationLabel.textColor = [UIColor blackColor];
				dateLabel.textColor =  [UIColor grayColor];
				
				/*UIImage *buttonImage;
				if ([appRecord.alarmbut isEqual:@"aa"]) {
					buttonImage = [UIImage imageNamed:@"bell_magenta.png"];
					[alarmButton setImage:buttonImage forState:UIControlStateNormal];
				}*/
			}
			
			
			/*if([appRecord.alarmbut isEqual:@"aa"]){
				[alarmButton setUserInteractionEnabled:YES];
				[alarmButton setHidden:NO];
			}
			else{
				[alarmButton setUserInteractionEnabled:NO];
				[alarmButton setHidden:YES];	
			}	*/	
			
			
			titleLabel.text = appRecord.eventTitle;
			locationLabel.text = [appRecord.region capitalizedString];
			
			if(appRecord.date2 == nil && appRecord.date != nil){
				dateLabel.text = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:appRecord.date]];
			}
			else{
				if(appRecord.date == nil){
					dateLabel.text = @"";
				}
				else{
					dateLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:appRecord.date], [self.dateFormatter2 stringFromDate:appRecord.date2]];	
				}
			}
			
			
			if (!appRecord.eventImage)
			{
				if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
				{
					if(![appRecord.imageURLString isEqualToString:@""]){
						[self startIconDownload:appRecord forIndexPath:indexPath];	
					}
					else {
						[activity stopAnimating];
					}
				}
					// if a download is deferred or in progress, return a placeholder image
				cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
			}	                
			else
			{
				cell.imageView.image = appRecord.eventImage;
			}
			
			
			int j = appRecord.img;
			if (j == 1){
				if ([appRecord.category isEqualToString:@"Arts"]) {
                    UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_arts.png"];
                    accesory.image = indicatorImage2;
                    
                }
                if ([appRecord.category isEqualToString:@"Community"]) {
                    UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_comm.png"];
                    accesory.image = indicatorImage2;
                    
                }
                if ([appRecord.category isEqualToString:@"Food"]) {
                    UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_food.png"];
                    accesory.image = indicatorImage2;
                    
                }
                if ([appRecord.category isEqualToString:@"Sport"]) {
                    UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_sports.png"];
                    accesory.image = indicatorImage2;
                }
			}
			else {
				if ([appRecord.category isEqualToString:@"Arts"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_arts.png"];
                    accesory.image = indicatorImage;
                    
                }
                if ([appRecord.category isEqualToString:@"Community"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_comm.png"];
                    accesory.image = indicatorImage;
                    
                }
                if ([appRecord.category isEqualToString:@"Food"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_food.png"];
                    accesory.image = indicatorImage;
                    
                }
                if ([appRecord.category isEqualToString:@"Sport"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_sports.png"];
                    accesory.image = indicatorImage;
                }
				
			}
		}	
		
	return cell;		
}


- (void)didPressedButton:(UIButton *)sender 
{
	Alarms *alar = [[Alarms alloc] init];
	
	alar.ape = [listOfEvents objectAtIndex:[self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row];
	objindex = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row;
	
	[self.navigationController pushViewController:alar animated:YES];
	
	[alar release];
}



- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	AppEvents *selectedEvent = [listOfEvents objectAtIndex:indexPath.row];
	
	Event *evn = [[Event alloc] init];
		
	if (showall.selected == YES) {
		evn.isShowAll = YES;
	}
	else {
		evn.isShowAll = NO;
	}
	
	evn.event = selectedEvent;
	evn.fromCategories = YES;
	evn.fromMaps = NO;
	evn.fromFavourites = NO;
	evn.fromSearch = NO;
	
	if(!evn.events){
		evn.events = [[NSMutableArray alloc] init];
		[evn.events addObjectsFromArray:notifications];
	}
	
	ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UINavigationController *navigationController = app.navigationController1;
	
	[navigationController pushViewController:evn animated:YES];
	
	selectedEvent.img = 1;
	selectedEvent.intr = 1;
	selectedEvent.index = indexPath.row; 
	
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	[ary  addObject:selectedEvent];
	
	if(b != -1){
		AppEvents *ap = [[AppEvents alloc] init];
		ap = [listOfEvents objectAtIndex:b];
		if(![ap.eventTitle isEqual:selectedEvent.eventTitle]){
			ap.intr = 0;
			ap.img = 0;
			[ary addObject:ap];
		}
		else if(ap.idcod != selectedEvent.idcod){
			ap.intr = 0;
			ap.img = 0;
			[ary addObject:ap];
		}
	}
	
	b = indexPath.row;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"RedrawTable" object:ary];
	
	[selectedEvent release];
	[evn release];
}


#pragma mark -
#pragma mark ImageDownloader

	

- (void)startIconDownload:(AppEvents *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

	// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.listOfEvents count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            AppEvents *appRecord = [self.listOfEvents objectAtIndex:indexPath.row];
            
			if (!appRecord.eventImage) // avoid the app icon download if the app already has an icon
			{
				[self startIconDownload:appRecord forIndexPath:indexPath];
				p = 0;
				
				/*NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
				for (int i=0;i<[visiblePaths count];i++) {
					int n = [[visiblePaths objectAtIndex:i] row];
					AppEvents *ap = [self.listOfEvents objectAtIndex:n];
					if (ap.eventImage != nil) {
						[activity stopAnimating];
						[activity setHidden:YES];
						self.tableView.userInteractionEnabled = YES;	
					}
				}*/
			}
			else {
				p = 1;
			}
        }
    }
}

	// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];     
		
		//NSLog(@"%d", iconDownloader.indexPathInTableView.row);
		cell.imageView.image = iconDownloader.appRecord.eventImage;
		
		[activity stopAnimating];
		[activity setHidden:YES];
		self.tableView.userInteractionEnabled = YES;
		//[img removeFromSuperview];
		
		[food setUserInteractionEnabled:YES];
		[sport setUserInteractionEnabled:YES];
		[showall setUserInteractionEnabled:YES];
		[community setUserInteractionEnabled:YES];
		[arts setUserInteractionEnabled:YES];
		[tool setUserInteractionEnabled:YES]; 
	}
}


	// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
	
	if (p != 1){
		
		[activity startAnimating];
		[activity setHidden:NO];
		self.tableView.userInteractionEnabled = NO;
		
		NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
		for (int i=0;i<[visiblePaths count];i++) {
			int n = [[visiblePaths objectAtIndex:i] row];
			AppEvents *ap = [self.listOfEvents objectAtIndex:n];
			if (ap.eventImage != nil) {
				[activity stopAnimating];
				[activity setHidden:YES];
				self.tableView.userInteractionEnabled = YES;	
			}
		}

		p = 0;
		
		NSDate *acum = [NSDate date];
		acum = [acum dateByAddingTimeInterval:2];
		NSTimer *tim = [[NSTimer alloc] initWithFireDate:acum interval:0 target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
		
		NSRunLoop *runner = [NSRunLoop mainRunLoop];
		[runner addTimer:tim forMode: NSDefaultRunLoopMode];
		[tim release];
	}
	//[self.view addSubview:img];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

	[activity stopAnimating];
	[activity setHidden:YES];
	self.tableView.userInteractionEnabled = YES;
}


-(void)stopAnimation{
	[activity stopAnimating];
	[activity setHidden:YES];
	self.tableView.userInteractionEnabled = YES;
}



@end
