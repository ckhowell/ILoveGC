//
//  FirstPage.m
//  MyProject
//
//  Created by ANDREI A on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ILoveGCAppDelegate.h"
#import "Suburb.h"
#import "Event.h"
#import "Favourites.h"
#import "AppEvents.h"
#import "ParseOperation.h"
#import "Maps.h"
#import <CFNetwork/CFNetwork.h>
#import "Alarms.h"
#import "SuburbCategories.h"


#define kCustomRowHeight    63.0
#define kDiscIcon 25

#define BTN_TAG_ALL    85
#define BTN_TAG_ARTS   86
#define BTN_TAG_COMMUNITY   87
#define BTN_TAG_FOOD    88
#define BTN_TAG_SPORT   89

static int n = 0;



@implementation Suburb

@synthesize arts, community, showall, sport, food;
@synthesize tableView;
@synthesize tool, img, segment, arrow, imgview;

@synthesize listOfEvents;
@synthesize suburbArray;
@synthesize _category;

@synthesize viewMenu, viewBtnBack;



-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    return string;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
    
    self.tableView.frame = CGRectMake(0, 113-70, 320, 255 + 70);
    
    arrow.alpha = 0.0;
    self.suburbArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.listOfEvents = [[NSMutableArray alloc] initWithCapacity:10]; 
    [self.listOfEvents sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
	//self.tableView.userInteractionEnabled = YES;
	
	
	self.tableView.rowHeight = kCustomRowHeight;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;	
	 	
    [self menuBar];
	
    // toolbar
	imgview = [[UIImageView alloc] initWithFrame:tool.frame];
	imgview.backgroundColor = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0];
	tool.tintColor = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
	[tool insertSubview:imgview atIndex:0];

	// gesture pink
    
    UILongPressGestureRecognizer *longpressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewShowHideMenu:)];
    [viewMenu addGestureRecognizer:longpressGesture];
    [longpressGesture release];

      
    int categ = _category->categ;
    [self setOptionBtn:categ];
	
}
-  (void) menuBar{
    ILoveGCAppDelegate *appDelegate = (ILoveGCAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.strMenuSelected = @"ALL";
    arrow = [[UIImageView alloc] initWithFrame:CGRectMake(25, 63, 15.5, 7)]; 
	UIImage *arw = [UIImage imageNamed:@"Show_All_Arrow.png"];
	arrow.image = arw;
    arrow.tag = 32;
	arrow.backgroundColor = [UIColor clearColor];	
	[self.view addSubview:arrow];
    
    
	showall = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	showall.frame = CGRectMake(0, 4, 64, 59);
	//showall.backgroundColor = [UIColor blackColor];
    //[showall setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_logo.png"]]];
	//showall.titleLabel.font = [UIFont systemFontOfSize: 10];
	//showall.titleEdgeInsets = UIEdgeInsetsMake(63,3,2,2);; 
	[showall setBackgroundImage:[UIImage imageNamed:@"Nav_showall_off.png"] forState:UIControlStateNormal];
	[showall setBackgroundImage:[UIImage imageNamed:@"Nav_showall_on.png"] forState:UIControlStateSelected];
	[showall setSelected:YES];
	//[showall setTitle:@"Show All" forState:UIControlStateNormal];
	//[showall setTitle:@"Show All" forState:UIControlStateSelected];
	//[showall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[showall setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
	[showall addTarget:self action:@selector(ShowAll:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:showall];	
	
	arts = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	arts.frame = CGRectMake(64, 4, 64, 59);
	//arts.backgroundColor = [UIColor blackColor];
	//arts.titleLabel.font = [UIFont systemFontOfSize: 10];
	//arts.titleEdgeInsets = UIEdgeInsetsMake(63,3,2,2);
	[arts setBackgroundImage:[UIImage imageNamed:@"Nav_accomm_off.png"] forState:UIControlStateNormal];
	[arts setBackgroundImage:[UIImage imageNamed:@"Nav_accomm_on.png"] forState:UIControlStateSelected];
	//[arts setTitle:@"Arts" forState:UIControlStateNormal];
	//[arts setTitle:@"Arts" forState:UIControlStateSelected];
	//[arts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[arts setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
	[arts addTarget:self action:@selector(Arts:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:arts];	
	
	community = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	community.frame = CGRectMake(128, 4, 64, 59);
	//community.backgroundColor = [UIColor blackColor];
	//community.titleLabel.font = [UIFont systemFontOfSize: 10];
	//community.titleEdgeInsets = UIEdgeInsetsMake(63,4,2,2);
	[community setBackgroundImage:[UIImage imageNamed:@"Nav_comm_off.png"] forState:UIControlStateNormal];
	[community setBackgroundImage:[UIImage imageNamed:@"Nav_comm_on.png"] forState:UIControlStateSelected];
	//[community setTitle:@"Community" forState:UIControlStateNormal];
	//[community setTitle:@"Community" forState:UIControlStateSelected];
	//[community setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[community setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
	[community addTarget:self action:@selector(Community:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:community];	
	
	food = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	food.frame = CGRectMake(192, 4, 64, 59);
	//food.backgroundColor = [UIColor blackColor];
	//food.titleLabel.font = [UIFont systemFontOfSize: 10];
	//food.titleEdgeInsets = UIEdgeInsetsMake(63,3,2,2);
	[food setBackgroundImage:[UIImage imageNamed:@"Nav_food_off.png"] forState:UIControlStateNormal];
	[food setBackgroundImage:[UIImage imageNamed:@"Nav_food_on.png"] forState:UIControlStateSelected];
	//[food setTitle:@"Food" forState:UIControlStateNormal];
	//[food setTitle:@"Food" forState:UIControlStateSelected];
	//[food setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[food setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
	[food addTarget:self action:@selector(Food:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:food];	
	
	sport = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	sport.frame = CGRectMake(256, 4, 64, 59);
	//sport.backgroundColor = [UIColor blackColor];
	//sport.titleLabel.font = [UIFont systemFontOfSize: 10];
	//sport.titleEdgeInsets = UIEdgeInsetsMake(63,4,2,2);
	[sport setBackgroundImage:[UIImage imageNamed:@"Nav_sport_off.png"] forState:UIControlStateNormal];
	[sport setBackgroundImage:[UIImage imageNamed:@"Nav_sport_on.png"] forState:UIControlStateSelected];
	//[sport setTitle:@"Sport" forState:UIControlStateNormal];
	//[sport setTitle:@"Sport" forState:UIControlStateSelected];
	//[sport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[sport setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
	[sport addTarget:self action:@selector(Sport:) forControlEvents:UIControlEventTouchUpInside];	
	[self.viewBtnBack addSubview:sport];	
    
    [self removeMenuBar];
    
}
- (void) removeMenuBar{
    UIView *tmpView = (UIView *)[self.view viewWithTag:32]; 
    //ViewWithTag Number should be same as used while allocating
    [tmpView removeFromSuperview];
    
    self.viewBtnBack.hidden = YES;
}
- (void) showMenuBar{
    arrow.alpha = 1;
    self.viewBtnBack.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
    
    //Set the title
	self.navigationItem.title = @"By Suburb";
	UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    
    // buttons color
    UIColor * colorTool = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
    /*if (_category.showall.selected == YES) {
        colorTool = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
        
        arrow.frame = CGRectMake(25, 63, 15.5, 7);
        arrow.image = [UIImage imageNamed:@"Show_All_Arrow"];
        [showall setSelected:YES];
    } else if (_category.arts.selected == YES) {
        colorTool = [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0];  
        
        arrow.frame = CGRectMake(89, 63, 15.5, 7);
        arrow.image = [UIImage imageNamed:@"Arts_Arrow"];
        
        [arts setSelected:YES];
        
    } else if (_category.community.selected == YES) {
        colorTool = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];  
        
        arrow.frame = CGRectMake(153, 63, 15.5, 7);
        arrow.image = [UIImage imageNamed:@"Comm_Arrow"];
        
        [community setSelected:YES];
        
    } else if (_category.food.selected == YES){
        colorTool = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0]; 
        
        arrow.frame = CGRectMake(217, 63, 15.5, 7);
        arrow.image = [UIImage imageNamed:@"Food_Arrow"];
        
        [food setSelected:YES];
        
    } else if (_category.sport.selected == YES) {
        colorTool = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
        
        arrow.frame = CGRectMake(280, 63, 15.5, 7);
        arrow.image = [UIImage imageNamed:@"Sport_Arrow"];
        
        [sport setSelected:YES];
        
    }*/
    tool.tintColor = colorTool; 
	imgview.backgroundColor = colorTool;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_default.png"]]];
    
    [self removeMenuBar];
    self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
    
    self.tableView.frame = CGRectMake(0, 113-70, 320, 255 + 70);
    
    arrow.alpha = 0.0;
    
/*    if (_category->bShowMenuBar == NO) {
        [self removeMenuBar];
        self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
        
        self.tableView.frame = CGRectMake(0, 113-70, 320, 303 + 70);
        
        arrow.alpha = 0.0;
    } else {
        [self showMenuBar];
        self.viewMenu.frame = CGRectMake(0, 70, viewMenu.frame.size.width, viewMenu.frame.size.height);
        self.tableView.frame = CGRectMake(0, 113, 320, 303);
        
        arrow.alpha = 1.0;
    }*/
}


- (void)dealloc {
	
	[imgview release];
	[arrow release];
	
	[showall release];	
	[arts release];
	[community release];
	[sport release];
	[food release];
	
	[img release];
	[tool release];
	[segment release];
	
	[tableView release];
	
    [listOfEvents release];
    [suburbArray release];
    
    [viewMenu release];
    [viewBtnBack release];
    
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{    
    Categories * categoriesController = self._category;

    UISegmentedControl *sender = categoriesController.segment;
    sender.selectedSegmentIndex = segment.selectedSegmentIndex;
    [categoriesController setCategory:sender];
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    //Set the title
	self.navigationItem.title = @"Back";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void) setParent:(Categories *)_parent {
    self._category = _parent;
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
	
	if (_category->categ == 0) {
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
        
        [self removeMenuBar];
        self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
        
        self.tableView.frame = CGRectMake(0, 113-70, 320, 255 + 70);
        
        arrow.alpha = 0.0;
        
/*        if (_category->bShowMenuBar == NO) {
            
            self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
            
            self.tableView.frame = CGRectMake(0, 113-70, 320, 303 + 70);
            
            arrow.alpha = 0.0;
        } else {
            
            self.viewMenu.frame = CGRectMake(0, 70, viewMenu.frame.size.width, viewMenu.frame.size.height);
            self.tableView.frame = CGRectMake(0, 113, 320, 303);
            
            arrow.alpha = 1.0;
        }*/
        
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDidStopSelector:@selector(endAnimation)];
        
        /*if (_category->bShowMenuBar == NO){
            [self showMenuBar];
            self.viewMenu.frame = CGRectMake(0, 70, viewMenu.frame.size.width, viewMenu.frame.size.height);
            self.tableView.frame = CGRectMake(0, 113, 320, 303);
            
            arrow.alpha = 1.0;
        } else {
            [self removeMenuBar];
            self.viewMenu.frame = CGRectMake(0, 0, viewMenu.frame.size.width, viewMenu.frame.size.height);
            self.tableView.frame = CGRectMake(0, 113-70, 320, 303 + 70);
            
            arrow.alpha = 0.0;
        }
        */
        [UIView commitAnimations];
        
    }
    
}
- (void) endAnimation{
    _category->bShowMenuBar = _category->bShowMenuBar;
}


- (IBAction)setCategory:(id)sender
{
	if (((UISegmentedControl *)sender).selectedSegmentIndex == 0) {
        [self setOptionBtn: 0];
	}
	else if (((UISegmentedControl *)sender).selectedSegmentIndex == 1) {
		[self setOptionBtn: 1];
	}
	else if (((UISegmentedControl *)sender).selectedSegmentIndex == 2) {
        [self setOptionBtn: 2];
	}
}

- (void) setOptionBtn : (int) _categ {
    
    [listOfEvents removeAllObjects];
    
    switch (_categ) {
        case 0:
            [listOfEvents addObjectsFromArray:_category.lista];
            break;
        case 1:
            [listOfEvents addObjectsFromArray:_category.selectlist];
            break;
        case 2:
            [listOfEvents addObjectsFromArray:_category.wthot];
            break;
    }
    NSLog(@"%d", [listOfEvents count]);
    
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

    [self.suburbArray removeAllObjects];
    
    for(AppEvents *ap in listOfEvents){
        if ([self.suburbArray count] == 0) {
            NSMutableDictionary *dicNew = [NSMutableDictionary dictionaryWithCapacity:10];
            [dicNew setObject:ap.region forKey:@"region"];//[dicNew setObject:ap.country forKey:@"country"];
            [dicNew setObject:[NSMutableArray arrayWithCapacity:10] forKey:@"array"];
            [[dicNew objectForKey:@"array"] addObject:ap];
            [self.suburbArray addObject:dicNew];
        }
        else {
            BOOL bFind = FALSE;
            for (int i=0; i<[self.suburbArray count]; i++) {
                NSMutableDictionary *dicCategory = [self.suburbArray objectAtIndex:i];
                //if ([ap.country isEqualToString:[dicCategory objectForKey:@"country"]]) {
                if ([ap.region isEqualToString:[dicCategory objectForKey:@"region"]]) {
                    [[dicCategory objectForKey:@"array"] addObject:ap];
                    bFind = TRUE;
                    break;
                }
            }
            
            if (!bFind) {
                NSMutableDictionary *dicNew = [NSMutableDictionary dictionaryWithCapacity:10];
                [dicNew setObject:ap.region forKey:@"region"];//[dicNew setObject:ap.country forKey:@"country"];
                [dicNew setObject:[NSMutableArray arrayWithCapacity:10] forKey:@"array"];
                [[dicNew objectForKey:@"array"] addObject:ap];
                [self.suburbArray addObject:dicNew];
            }
        }
    }	
    
    NSSortDescriptor *sorter;
    
    sorter = [[NSSortDescriptor alloc]initWithKey:@"region" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sorter];
    
    [self.suburbArray sortUsingDescriptors:sortDescriptors];
    [sorter release];
    //[self.suburbArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return [self.suburbArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSUInteger const TitleLabelTag = 2;
    static NSUInteger const AccesoryTag = 5;
    
	UILabel *titleLabel = nil;
		
	static NSString *CellIdentifier = @"SuburbTableCell";
	
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
        titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 225, 48)] autorelease];
        titleLabel.tag = TitleLabelTag;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
       // titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
        
        [cell.contentView addSubview:titleLabel];
    }
    else{
        titleLabel = (UILabel *)[cell.contentView viewWithTag:TitleLabelTag];
    }
    
    //	AppEvents *appRecord = [self.suburbArray objectAtIndex:indexPath.row];
    NSMutableDictionary *dic = [self.suburbArray objectAtIndex:indexPath.row];

		
    UIImageView *aview = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 68)] autorelease];
    aview.image = [UIImage imageNamed:@"back_tab_OFF.png"];
    cell.backgroundView = aview;	

    
    NSString* title = [dic objectForKey:@"region"];//[dic objectForKey:@"country"];
    NSMutableArray * array = [dic objectForKey:@"array"]; 
	titleLabel.text = [self htmlEntityDecode:[NSString stringWithFormat:@"%@ (%d)", [title capitalizedString], [array count]]];
    
    
    UIImageView *accesory = [[[UIImageView alloc] initWithFrame:CGRectMake(286, 20, 22.9, 22.9)] autorelease];
    accesory.tag = AccesoryTag;
    [cell.contentView addSubview:accesory];

    UIImage *indicatorImage;
    indicatorImage = [UIImage imageNamed:@"icon_arrow_default.png"];
    accesory.image = indicatorImage;
	
    //NSLog(@"(%d)", ++n);
			
	return cell;		
}




- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dic = [self.suburbArray objectAtIndex:indexPath.row];
    NSString *regionTitle = [dic objectForKey:@"region"];
    
    SuburbCategories *controller = [[SuburbCategories alloc] init];
    controller.suburbTitle = regionTitle;    
    [controller setParent:self];
    
    controller.categList = _category.categList;
	controller.listOfEvents = _category.listOfEvents;
	controller.notifications = _category.notifications;
	controller.events = _category.events;
	controller.selectlist = _category.selectlist;
	controller.lista = _category.lista;
	controller.wthot = _category.wthot;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    controller.segment.selectedSegmentIndex = segment.selectedSegmentIndex;
    [controller setOptionBtn:segment.selectedSegmentIndex];
    
//    NSMutableArray * array = [dic objectForKey:@"array"]; 
//        
//
//	AppEvents *selectedEvent = [listOfEvents objectAtIndex:indexPath.row];
//	
//	Event *evn = [[Event alloc] init];
//		
//	if (showall.selected == YES) {
//		evn.isShowAll = YES;
//	}
//	else {
//		evn.isShowAll = NO;
//	}
//	
//	evn.event = selectedEvent;
//	evn.fromCategories = YES;
//	evn.fromMaps = NO;
//	evn.fromFavourites = NO;
//	evn.fromSearch = NO;
//	
//	if(!evn.events){
//		evn.events = [[NSMutableArray alloc] init];
//		[evn.events addObjectsFromArray:notifications];
//	}
//	
//	ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
//	
//	UINavigationController *navigationController = app.navigationController1;
//	
//	[navigationController pushViewController:evn animated:YES];
//	
//	selectedEvent.img = 1;
//	selectedEvent.intr = 1;
//	selectedEvent.index = indexPath.row; 
//	
//	NSMutableArray *ary = [[NSMutableArray alloc] init];
//	[ary  addObject:selectedEvent];
//	
//	if(b != -1){
//		AppEvents *ap = [[AppEvents alloc] init];
//		ap = [listOfEvents objectAtIndex:b];
//		if(![ap.eventTitle isEqual:selectedEvent.eventTitle]){
//			ap.intr = 0;
//			ap.img = 0;
//			[ary addObject:ap];
//		}
//		else if(ap.idcod != selectedEvent.idcod){
//			ap.intr = 0;
//			ap.img = 0;
//			[ary addObject:ap];
//		}
//	}
//	
//	b = indexPath.row;
//	
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"RedrawTable" object:ary];
//	
//	[selectedEvent release];
//	[evn release];
}





	// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
//        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [self loadImagesForOnscreenRows];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

	self.tableView.userInteractionEnabled = YES;
}


-(void)stopAnimation{
	self.tableView.userInteractionEnabled = YES;
}



@end
