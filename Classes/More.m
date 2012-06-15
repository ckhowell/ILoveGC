//
//  More.m
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "More.h"
#import "AboutGC.h"
#import "GCApplication.h"
#import "Twitter.h"
#import "GCSite.h"
#import "GoldCoast.h"
#import "MFacebook.h"
#import "FBDialog.h"
#import "MoreObject.h"


@implementation More


@synthesize tableView3, listOfItems, count, index, previewsIndex, aview;

// ---------------------------------------------------------------------
- (void)viewDidLoad {
	[super viewDidLoad];
  
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    //Initializing the array.
	listOfItems = [[NSMutableArray alloc] init] ;
	
    //add items
	for (int i = 0; i < 6; i++) {
		MoreObject *more = [[MoreObject alloc] init] ;
		more.idcode = i;
        
        switch (i) {
            case 0:
            {
                [more setTitleStr: @"About I Love GC"];
            }
                break;
            case 1:
                [more setTitleStr: @"See i Love GC on Twitter"];
                break;
            case 2:
                [more setTitleStr: @"See I Love GC on Facebook"];
                break;
            case 3:
                [more setTitleStr: @"I Love GC website"];
                break;
            case 4:
                [more setTitleStr: @"Visiting the Gold Coast"];
                break;
            case 5:
                [more setTitleStr: @"Disclaimer"];
                break;
            default:
                break;
        }
        
		[listOfItems addObject:more];
	}
    
    count = [listOfItems count];
	
    tableView3.scrollEnabled = NO;
 
    //setting the title
	self.navigationItem.title = @"More";
	
    // initializing back button
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;

	[backButton release];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:0/255.f green:152/255.f blue:179/255.f alpha:1.0]; 
    
}
// ---------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
// ---------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
// ---------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return count;
}
// ---------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSUInteger const LabelTag = 2;
	static NSUInteger const IndicatorTag = 3;
	
    
    
	UILabel *label = nil;
	UIImageView *indicator = nil;
	
	static NSString *CellIdentifier = @"Cell";
    

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   
    
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		//label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 330, 20)];
        
        //label = [[UILabel alloc] initWithFrame: CGRectMake(15, 20, 320, 20.0)];
        label = [[UILabel alloc] initWithFrame: CGRectMake(15, (cell.frame.size.height) / 2.0, 320, 20.0)];
		label.tag = LabelTag;
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont boldSystemFontOfSize:16];
		[cell.contentView addSubview:label];
		
        // 280 initWithFrame:CGRectMake(286.6, 20.2, 22.8, 22.8)] autorelease];
		indicator = [[UIImageView alloc] initWithFrame:CGRectMake(286.6, 20.2, 22.8, 22.8)];
        
		indicator.tag = IndicatorTag;
		indicator.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:indicator];
	}
	else {
		label = (UILabel *)[cell.contentView viewWithTag:LabelTag];
		indicator = (UIImageView *)[cell.contentView viewWithTag:IndicatorTag];
	}

	MoreObject *more = [[[MoreObject alloc] init]autorelease];
	
	if(count > 0){
		
		more = [listOfItems objectAtIndex:indexPath.row];
		NSString *cellValue = [[listOfItems objectAtIndex:indexPath.row] titleStr];
       // label.textAlignment = UITextAlignmentCenter;
        label.textAlignment = UITextAlignmentLeft;
        
        
		label.text = cellValue;
        
	}
	
    
	if(count < 7){
       
	if (more.inChange==0) {
			aview = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 330, cell.frame.size.height)] ;
        
             
			aview.image = [UIImage imageNamed:@"back_tab_OFF.png"];
			cell.backgroundView = aview;	
    
			
			label.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
        
			
			indicator.image = [UIImage imageNamed:@"icon_arrow_default.png"];
		}
    
    
    

	else {
        
        
             CGFloat width = [UIScreen mainScreen].bounds.size.width;
			aview = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 330, cell.frame.size.height)];
			aview.image = [UIImage imageNamed:@"back_tab_ON.png"];
			cell.backgroundView = aview;	
			
			label.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
			
			indicator.image = [UIImage imageNamed:@"icon_arrow_default.png"];
		}

	}
    
	else{
		self.tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
	}
    
	
    return cell;
	
}


// ---------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    return 60;
}
// ---------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *selectedEvent = [[listOfItems objectAtIndex:indexPath.row] titleStr];
	
	if(indexPath.row == 0){
		[[listOfItems objectAtIndex:0] setInChange:1];
		for (int i=0;i<[listOfItems count];i++) {
			if (i!=0) {
				[[listOfItems objectAtIndex:i] setInChange:0];
			}
		}	
		
		[self.tableView3 reloadData];
		
		AboutGC *ab = [[AboutGC alloc] init] ;
		ab.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:ab animated:YES];
		[ab release];
	}
	else if(indexPath.row == 1){
		[[listOfItems objectAtIndex:1] setInChange:1];
		for (int i=0;i<[listOfItems count];i++) {
			if (i!=1) {
				[[listOfItems objectAtIndex:i] setInChange:0];
			}
		}		
		
		[self.tableView3 reloadData];
        
		
		Twitter *gct = [[Twitter alloc] init] ;
		gct.title = @"i Love GC Twitter";
		gct.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:gct animated:YES];
		[gct release];		
	}
	else if(indexPath.row == 2){
		[[listOfItems objectAtIndex:2] setInChange:1];
		for (int i=0;i<[listOfItems count];i++) {
			if (i!=2) {
				[[listOfItems objectAtIndex:i] setInChange:0];
			}
		}
		
		[self.tableView3 reloadData];
		
		MFacebook *gcf = [[MFacebook alloc] init] ;
		gcf.title = @"i Love GC Facebook";
		gcf.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:gcf animated:YES];
		[gcf release];	
	}
    
	else if(indexPath.row == 3){
		[[listOfItems objectAtIndex:3] setInChange:1];
		for (int i=0;i<[listOfItems count];i++) {
			if (i!=3) {
				[[listOfItems objectAtIndex:i] setInChange:0];
			}
		}
		
		[self.tableView3 reloadData];
		
		GCSite *gcs = [[GCSite alloc] init] ;
		gcs.title = selectedEvent;
		gcs.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:gcs animated:YES];
		[gcs release];		
	}
	else if(indexPath.row == 4){
		[[listOfItems objectAtIndex:4] setInChange:1];
		for (int i=0;i<[listOfItems count];i++) {
			if (i!=4) {
				[[listOfItems objectAtIndex:i] setInChange:0];
			}
		}
		
		[self.tableView3 reloadData];
		
		GoldCoast *gc = [[GoldCoast alloc] init] ;
		gc.title = @"Tourism Gold Coast";
		gc.hidesBottomBarWhenPushed = YES;
		[self.navigationController pushViewController:gc animated:YES];
		[gc release];		
	}
	else if(indexPath.row == 5){
		[[listOfItems objectAtIndex:5] setInChange:1];
		for (int i=0;i<[listOfItems count];i++) {
			if (i!=5) {
				[[listOfItems objectAtIndex:i] setInChange:0];
			}
		}
		
		[self.tableView3 reloadData];
		
		GCApplication *gca = [[GCApplication alloc] init] ;
		gca.title = selectedEvent;
		gca.hidesBottomBarWhenPushed =YES;
		[self.navigationController pushViewController:gca animated:YES];
		[gca release];
	}
}
// ---------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath 
{	
	if (cell.highlighted || cell.selected) {
		cell.textLabel.textColor = [UIColor blackColor];
		cell.textLabel.shadowColor = [UIColor clearColor];
	} 
    else {
		cell.textLabel.shadowColor = [UIColor whiteColor];
		cell.textLabel.shadowColor = [UIColor clearColor];
	}
}
// ---------------------------------------------------------------------
- (void)viewDidUnload {
    [super viewDidUnload];
}
// ---------------------------------------------------------------------
- (void)dealloc {
	[previewsIndex release];
	[index release];
	[listOfItems release];
	[tableView3 release];
    [super dealloc];
}
@end

