//
//  Favourites.m
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Favourites.h"
#import "ILoveGCAppDelegate.h"
#import "Event.h"
#import "Categories.h"
#import "AppEvents.h"
#import "ParseOperation.h"
#import "Alarms.h"

#define kCustomRowHeight    63.0
#define kAppIconHeight 48
#define kDiscIcon 25

@implementation Favourites

@synthesize tableView, alarmButton, dateFormatter2;
@synthesize listOfItems, altaLista, alarm, plistPath;
@synthesize fevent, editButton, dateFormatter, alarms;

@synthesize loading_iv, loading_lb;


- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView.rowHeight = kCustomRowHeight;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
		//Set the title
	self.navigationItem.title = @"Favourites";
	self.navigationItem.rightBarButtonItem = self.editButtonItem;


	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];	
	

		//[alarmButton addTarget:self action:@selector(addAlarm:) forControlEvents:UIControlEventTouchUpInside];
	altaLista = [[[NSMutableArray alloc] init] autorelease];
	
	alarms = [[[Alarms alloc] init] autorelease];
	[self.tableView reloadData];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(rememObj:)
											     name:@"RememObj" 
											   object:nil];		
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(dismissAlarm:)
											     name:@"NoAlarm" 
											   object:nil];
	
	b = -1;
    
    loading_lb = [[UILabel alloc] initWithFrame:CGRectMake(50, -40, 220, 20)];
    loading_lb.backgroundColor = [UIColor clearColor];
    loading_lb.textColor = [UIColor colorWithRed:109.0/255.0 green:109.0/255.0 blue:109.0/255.0 alpha:1.0];
    loading_lb.font = [UIFont boldSystemFontOfSize:16];
    loading_lb.textAlignment = UITextAlignmentCenter;
    [loading_lb setText:@"Pull down to refresh..."];
    
    loading_iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, -50, 22, 41)];
    loading_iv.image = [UIImage imageNamed:@"arrow_down"];
    [loading_iv setTag:100];

}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_default.png"]]];
    
	//self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0];
}


-(void)dismissAlarm:(NSNotification *)notif
{
	for(int g=0;g<[listOfItems count];g++){
		if ([[listOfItems objectAtIndex:g] idcod] == [[notif object] idcod]) {
			[listOfItems replaceObjectAtIndex:g withObject:[notif object]];
			[self.tableView reloadData];
		}
	}
}


- (void)rememObj:(NSNotification *)notif
{	
	
	alarm = [NSString stringWithFormat:@"%@", [notif object]];
	
	NSLog(@"objindexreturn = %d", objindex);
	
	AppEvents *apev = [listOfItems objectAtIndex:objindex];
	apev.alarme = [NSString stringWithFormat:@"%@", alarm];
	
	NSLog(@"alarmtext = %@", apev.alarme);
	
	[listOfItems replaceObjectAtIndex:objindex withObject:apev];
	
	[self.tableView reloadData];
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


- (NSString *) saveFilePath
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	int count = [listOfItems count];
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	int pos = 215;
	
	static NSUInteger const TitleLabelTag = 2;
	static NSUInteger const LocationLabelTag = 3;
	static NSUInteger const DateLabelTag = 4;
	static NSUInteger const AccesoryTag = 5;
	static NSUInteger const AlarmButtonTag = 6;
	
	UIImageView *accessory = nil;
	UILabel *titleLabel = nil;
	UILabel *locationLabel = nil;
	UILabel *dateLabel = nil;
    
	static NSString *CellIdentifier = @"Cell";
	
	int nodeCount = [listOfItems count];
	
	AppEvents *appRecord = [self.listOfItems objectAtIndex:indexPath.row];
    
	int n = appRecord.intr2;
	
		UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
		
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
			
			titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 20, pos, 20)] autorelease];
			titleLabel.tag = TitleLabelTag;
			titleLabel.backgroundColor = [UIColor clearColor];
			titleLabel.font = [UIFont boldSystemFontOfSize:16];
			[cell.contentView addSubview:titleLabel];
		
			locationLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 43, pos, 14)] autorelease];
			locationLabel.tag = LocationLabelTag;
			locationLabel.backgroundColor = [UIColor clearColor];
			locationLabel.font = [UIFont italicSystemFontOfSize:12];
			[cell.contentView addSubview:locationLabel];
		
			dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(65, 6, pos, 14)] autorelease];
			dateLabel.tag = DateLabelTag;
			dateLabel.backgroundColor = [UIColor clearColor];
			dateLabel.font = [UIFont boldSystemFontOfSize:12];
			[cell.contentView addSubview:dateLabel];		
		
			alarmButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
			alarmButton.frame = CGRectMake(248, 5, 25, 55);
			alarmButton.backgroundColor = [UIColor clearColor];
			alarmButton.tag = AlarmButtonTag;
			[alarmButton setUserInteractionEnabled:YES];
			[alarmButton setHidden:NO];
			[cell.contentView addSubview:alarmButton];
			[alarmButton addTarget:self action:@selector(didPressedButton:) forControlEvents:UIControlEventTouchUpInside];			
			
			accessory = [[[UIImageView alloc] initWithFrame:CGRectMake(286.6, 20.2, 22.8, 22.8)] autorelease];
			accessory.tag = AccesoryTag;
			[cell.contentView addSubview:accessory];
            
            if (indexPath.row == 0) {
                /*[cell.contentView addSubview:loading_iv];
                [cell.contentView addSubview:loading_lb];*/
            }

		}
		else{
			
			titleLabel = (UILabel *)[cell.contentView viewWithTag:TitleLabelTag];
			locationLabel = (UILabel *)[cell.contentView viewWithTag:LocationLabelTag];
			dateLabel = (UILabel *)[cell.contentView viewWithTag:DateLabelTag];	
			alarmButton = (UIButton *)[cell.contentView viewWithTag:AlarmButtonTag];
			accessory = (UIImageView *)[cell.contentView viewWithTag:AccesoryTag];
		}   
	
	
		if([appRecord.alarmbut isEqual:@"aa"]){	
			pos = 180;
			titleLabel.frame = CGRectMake(65, 20, pos, 20);
			locationLabel.frame = CGRectMake(65, 43, pos, 14);
			dateLabel.frame = CGRectMake(65, 6, pos, 14);	
		}
	
		
		if (nodeCount > 0)
		{	
	
			if(n == 0){
				UIImageView *aview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 63)];
				aview.image = [UIImage imageNamed:@"back_tab_OFF.png"];
				cell.backgroundView = aview;	
				
				/*titleLabel.textColor = [UIColor whiteColor];
				locationLabel.textColor = [UIColor whiteColor];
				dateLabel.textColor = [UIColor grayColor];*/
                
                titleLabel.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
				locationLabel.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
				dateLabel.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];
				
				
				UIImage *buttonImage;
				if ([appRecord.alarmbut isEqual:@"aa"]) {
					if([appRecord.category isEqual:@"Arts"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_arts.png"];
					}
					else if([appRecord.category isEqual:@"Community"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_comm.png"];
					}
					else if([appRecord.category isEqual:@"Food"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_food.png"];
					}
					else if([appRecord.category isEqual:@"Sport"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_sports.png"];
					}
					[alarmButton setImage:buttonImage forState:UIControlStateNormal];
				}
				else if([appRecord.alarmbut isEqual:@"bb"]){
					buttonImage = [UIImage imageNamed:@"bell.png"];
					[alarmButton setImage:buttonImage forState:UIControlStateNormal];
				}
			}
			else{
				UIImageView *aview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 330, 63)];
				aview.image = [UIImage imageNamed:@"back_tab_ON.png"];
				cell.backgroundView = aview;	
				
				titleLabel.textColor = [UIColor blackColor];
				locationLabel.textColor = [UIColor blackColor];
				dateLabel.textColor = [UIColor grayColor];
				
				UIImage *buttonImage;
				if ([appRecord.alarmbut isEqual:@"aa"]) {
					if([appRecord.category isEqual:@"Arts"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_arts.png"];
					}
					else if([appRecord.category isEqual:@"Community"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_comm.png"];
					}
					else if([appRecord.category isEqual:@"Food"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_food.png"];
					}
					else if([appRecord.category isEqual:@"Sport"]){
						buttonImage = [UIImage imageNamed:@"icon_alarm_sports.png"];
					}
					[alarmButton setImage:buttonImage forState:UIControlStateNormal];
				}
				else if([appRecord.alarmbut isEqual:@"bb"]){
					buttonImage = [UIImage imageNamed:@"bell_blk.png"];
					[alarmButton setImage:buttonImage forState:UIControlStateNormal];
				}
			}
			
			
			
			titleLabel.text = appRecord.eventTitle ;
			locationLabel.text = [appRecord.region capitalizedString];
			
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
			
			
			if(appRecord.date2 == nil && appRecord != nil){
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
	
					
			if([appRecord.alarmbut isEqual:@"aa"]){
				[alarmButton setUserInteractionEnabled:YES];
				[alarmButton setHidden:NO];
			}
			else if([appRecord.alarmbut isEqual:@"bb"]){
				[alarmButton setUserInteractionEnabled:NO];
				[alarmButton setHidden:YES];	
			}
			/*else {
				[alarmButton setUserInteractionEnabled:NO];
				[alarmButton setHidden:YES];	
			}*/

	
		
			cell.imageView.image = [self maskImage:appRecord.eventImage];//[self maskImage:appRecord.eventImage withMask:circle];appRecord.eventImage;
			

			if (appRecord.img2 == 1){
				if ([appRecord.category isEqualToString:@"Arts"]) {
                    UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_arts.png"];
                    accessory.image = indicatorImage2;
				}
				if ([appRecord.category isEqualToString:@"Community"]) {
			        UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_comm.png"];
                    accessory.image = indicatorImage2;
				}
				if ([appRecord.category isEqualToString:@"Food"]) {
			        UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_food.png"];
                    accessory.image = indicatorImage2;
				}
				if ([appRecord.category isEqualToString:@"Sport"]) {
                    UIImage *indicatorImage2 = [UIImage imageNamed:@"icon_arrow_sports.png"];
                    accessory.image = indicatorImage2;
				}
			}
			else {
				
                if ([appRecord.category isEqualToString:@"Arts"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_arts.png"];
                    accessory.image = indicatorImage;
                    
				}
				if ([appRecord.category isEqualToString:@"Community"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_comm.png"];
                    accessory.image = indicatorImage;
					
				}
				if ([appRecord.category isEqualToString:@"Food"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_food.png"];
                    accessory.image = indicatorImage;
					
				}
				if ([appRecord.category isEqualToString:@"Sport"]) {
                    UIImage *indicatorImage = [UIImage imageNamed:@"icon_arrow_sports.png"];
                    accessory.image = indicatorImage;
				}

			}
		}
	
    return cell;
	
}

- (UIImage*) maskImage:(UIImage *)image  {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIImage *maskImage = [UIImage imageNamed:@"Thumb_mask.png"];
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    } 
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

- (void)didPressedButton:(UIButton *)sender 
{
	Alarms *alar = [[Alarms alloc] init];
	
	alar.ape = [listOfItems objectAtIndex:[self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row];
	objindex = [self.tableView indexPathForCell:(UITableViewCell *)sender.superview.superview].row;
	
	ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	UINavigationController *navigationController = app.navigationController2;
	[navigationController pushViewController:alar animated:YES];
	
	[alar release];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	
	AppEvents *selectedEvent = [listOfItems objectAtIndex:indexPath.row];
	
	Event *event = [[Event alloc] initWithNibName:@"Event" bundle:nil];
	
	event.isShowAll = YES;
	event.event = selectedEvent;
	event.fromCategories = NO;
	event.fromFavourites = YES;
	event.fromMaps = NO;
	event.fromSearch = NO;
	
	event.events = [[NSMutableArray alloc] init];
	[event.events addObjectsFromArray:listOfItems];
	
	ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];

	UINavigationController *navigationController = app.navigationController2;
	
	[navigationController pushViewController:event animated:YES];
	
	selectedEvent.img2 = 1;
	selectedEvent.intr2 = 1;
	selectedEvent.index2 = indexPath.row; 
	
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	[ary  addObject:selectedEvent];
	NSLog(@"%i",b);
    NSLog(@"%i",indexPath.row);
    NSLog(@"%i",listOfItems.count);
	if(b != -1){
        if (b == listOfItems.count)
            b = b - 1	;
        AppEvents *ap = [[AppEvents alloc] init];
		ap = [listOfItems objectAtIndex:b];
        NSLog(@"eventTitle:%@",ap.eventTitle);
        NSLog(@"selectedEventTitle:%@",selectedEvent.eventTitle);
        
		if(![ap.eventTitle isEqual:selectedEvent.eventTitle]){
			ap.intr2 = 0;
			ap.img2 = 0;
			[ary addObject:ap];
		}
		else if(ap.idcod != selectedEvent.idcod){
			ap.intr2 = 0;
			ap.img2 = 0;
			[ary addObject:ap];
		}
	}
	
	b = indexPath.row;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"RewTable" object:ary];
	
	[selectedEvent release];
	[event release];	
}
 
 

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [tableView setEditing:editing animated:YES];
    if (editing) {
        editButton.enabled = YES;
    } else {
        [self.tableView reloadData];
        editButton.enabled = NO;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath{
	
	[self.tableView reloadData];
	
	if(editingStyle == UITableViewCellEditingStyleDelete){
		
		AppEvents *ap = [listOfItems objectAtIndex:indexPath.row];
		
		UIApplication *app = [UIApplication sharedApplication];
		
		NSArray *notifications = [app scheduledLocalNotifications];
		
		NSLog(@"nr. of notf. %d", [notifications count]);
		
		if(notifications != nil){
			NSMutableArray *ar = [[NSMutableArray alloc] init];
			[ar addObjectsFromArray:notifications];
			//NSLog(@"nr. of notifications = %d", [ar count]);
			//NSLog(@"alarm date = %@", ap.completdate);
			for (int i=0;i<[ar count];i++) {
				if([[[ar objectAtIndex:i] alertBody] isEqualToString:ap.eventTitle])
				{
					int info = [[[[ar objectAtIndex:i] userInfo] objectForKey:@"time"] intValue];
					
					//NSLog(@"fire date = %@", info);
					/*NSDateFormatter *date = [[[NSDateFormatter alloc] init] autorelease];
					[date setDateFormat:@"dd MMM yyyy hh:mm a"];
					NSString *eventtime = [NSString stringWithFormat:@"%@", [date stringFromDate:ap.completdate]];*/
					
					if(info == ap.idcod){
						[app cancelLocalNotification:[ar objectAtIndex:i]];
						//NSLog(@"notification = %@", [[ar objectAtIndex:i] alertBody]);
						
						NSLog(@"nr. of notf. %d", [[app scheduledLocalNotifications] count]);
					}
				}
			}
		}
		
		ap.favs = 0;
		ap.alarmbut = @"bb";
		ap.invalid = 0;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Notifications" object:ap];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"CategAlarm" object:ap];
		
		[listOfItems removeObjectAtIndex:indexPath.row];
		
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];		
		
		[self.tableView reloadData];
	}	
}


- (void)didReceiveMemoryWarning {
 
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -50) {
        if (loading_iv.tag == 100) {
            [loading_iv setTag:101];
            
            CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            spinAnimation.duration = 0.3;
            spinAnimation.fromValue = [NSNumber numberWithFloat:0];
            spinAnimation.toValue = [NSNumber numberWithFloat:-M_PI];
            [loading_iv.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
            loading_iv.transform = CGAffineTransformMakeRotation(-M_PI);
            
            //            [UIView beginAnimations:@"crazyRotate" context:nil];
            //            [UIView setAnimationDuration:0.3];
            //            loading_iv.transform = CGAffineTransformMakeRotation(-M_PI);
            //            [UIView commitAnimations];
            loading_lb.text = @"Release to refresh...";
        }
	}
    else {
        if (loading_iv.tag == 101) {
            [loading_iv setTag:100];
            
            CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            spinAnimation.duration = 0.3;
            spinAnimation.fromValue = [NSNumber numberWithFloat:-M_PI];
            spinAnimation.toValue = [NSNumber numberWithFloat:0];
            [loading_iv.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
            
            loading_iv.transform = CGAffineTransformMakeRotation(0);
            
            
            //            [UIView beginAnimations:@"crazyRotate" context:nil];
            //            [UIView setAnimationDuration:0.3];
            //            loading_iv.transform = CGAffineTransformMakeRotation(0);
            //            [UIView commitAnimations];
            loading_lb.text = @"Pull down to refresh...";
        }
    }
}

- (void)dealloc {
	
	[altaLista release];
	[plistPath release];
	[alarm release];
	[alarms release];
	[dateFormatter release];
	[alarmButton release];
	[editButton release];
	[fevent release];
	[listOfItems release];
	[tableView release];
    
    
    [loading_iv release];
    [loading_lb release];
    
    [super dealloc];
}


@end
