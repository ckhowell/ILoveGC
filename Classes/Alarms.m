//
//  Alarms.m
//  MyProject
//
//  Created by ANDREI A on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Alarms.h"
#import "AppEvents.h"
#import "Favourites.h"
#import "EventAlert.h"

@implementation Alarms

@synthesize tableView;
@synthesize alerts;
@synthesize ape;
@synthesize dateFormatter;
@synthesize dateFormatter2;
@synthesize timeFormatter;
@synthesize editButton, nav, str, alr, h;


-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	self.navigationItem.title = @"Alarms";
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[self.navigationItem.rightBarButtonItem setTarget:self];
	[self.navigationItem.rightBarButtonItem setAction:@selector(editPressed)];
	
	self.tableView.backgroundColor = [UIColor grayColor];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(changeAlarm:)
											     name:@"ChangeAlarm" 
											   object:nil];	
}


- (void)changeAlarm:(NSNotification *)notif
{	
	alr = [notif object];
	NSLog(@"%@", alr);
	[self.tableView reloadData];
}


-(void)editPressed{
	
	EventAlert *alert = [[EventAlert alloc] init];
	
	/*NSDateFormatter *dtr = [[NSDateFormatter alloc] init];
	[dtr setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dtr setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	[dtr setDateFormat:@"dd MMM yyyy hh:mm a"];*/
	alert.datestr = ape.comdate;
	//NSLog(@"date str = %@", alert.datestr);
	
	alert.etitle = [NSString stringWithFormat:@"%@", ape.eventTitle];
	alert.apev = ape;
	
	[self.navigationController presentModalViewController:alert animated:YES];
	
	[alert release];
	
}


-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:YES];
	
	//NSLog(@"%@", self.navigationController.title);
	if (![navTitle isEqual:self.navigationController.title]) {
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	
	ILoveGCAppDelegate *apd = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	navTitle = apd.aTabBarController.selectedViewController.title;
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
	[alr release];
	[str release];
	[nav release];
	[editButton release];
	[ape release];
	[timeFormatter release];
	[dateFormatter release];
	[alerts release];
	[tableView release];
    [super dealloc];
}

- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
		[dateFormatter setDateFormat:@"EEEE, dd MMM yyyy"];
	}
    return dateFormatter;
}
	
- (NSDateFormatter *)dateFormatter2 {
	if (dateFormatter2 == nil) {
		dateFormatter2 = [[NSDateFormatter alloc] init];
		[dateFormatter2 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateFormatter2 setTimeZone:[NSTimeZone localTimeZone]];
		[dateFormatter2 setDateFormat:@"dd MMM yyyy"];
	}
	return dateFormatter2;
}

- (NSDateFormatter *)timeFormatter {
    if (timeFormatter == nil) {
		timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
		[timeFormatter setDateFormat:@"hh:mm' 'a"];
    }
	return timeFormatter;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(indexPath.row == 0){
		
		static NSUInteger const TitleLabelTag = 2;
		static NSUInteger const TimeTag = 3;
		static NSUInteger const DateLabelTag = 4;
    
	
		UILabel *titleLabel = nil;
		UILabel *timeLabel = nil;
		UILabel *dateLabel = nil;	
	
	
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;			
			
			titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 13, 280, 20)] autorelease];
			titleLabel.tag = TitleLabelTag;
			titleLabel.font = [UIFont boldSystemFontOfSize:18];
			[cell.contentView addSubview:titleLabel];
		
			timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 54, 240, 14)] autorelease];
			timeLabel.tag = TimeTag;
			timeLabel.font = [UIFont systemFontOfSize:12];
			[cell.contentView addSubview:timeLabel];
		
			dateLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 36, 280, 14)] autorelease];
			dateLabel.tag = DateLabelTag;
			dateLabel.font = [UIFont systemFontOfSize:12];
			[cell.contentView addSubview:dateLabel];
		
		}
		else{
		
			titleLabel = (UILabel *)[cell.contentView viewWithTag:TitleLabelTag];
			timeLabel = (UILabel *)[cell.contentView viewWithTag:TimeTag];
			dateLabel = (UILabel *)[cell.contentView viewWithTag:DateLabelTag];
		}	
    
	
		titleLabel.text = ape.eventTitle;
		
		if(ape.time2 == nil && ape.time != nil){
			timeLabel.text = [NSString stringWithFormat:@"%@", [self.timeFormatter stringFromDate:ape.time]];
		}
		else{
			if(ape.time == nil){
				timeLabel.text = @"";
			}
			else{
				timeLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.timeFormatter stringFromDate:ape.time], [self.timeFormatter stringFromDate:ape.time2]];
			}
		}
		
		if(ape.date2 == nil && ape.date != nil){
			dateLabel.text = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:ape.date]];
		}
		else{
			if(ape.date2 == nil){
				dateLabel.text = @"";
			}
			else{
				dateLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:ape.date], [self.dateFormatter2 stringFromDate:ape.date2]];	
			}
		}
		
		return cell;
	}
	else{
		
		static NSUInteger const TitleTag = 2;
		static NSUInteger const AlertTag = 3;
		
		UILabel *alarmLabel = nil;
		UILabel *alertLabel = nil;
		
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:CellIdentifier] autorelease];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			alarmLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 180, 20)] autorelease];
			alarmLabel.tag = TitleTag;
			alarmLabel.font = [UIFont boldSystemFontOfSize:18];
			[cell.contentView addSubview:alarmLabel];
			
			alertLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 35, 180, 14)] autorelease];
			alertLabel.tag = AlertTag;
			alertLabel.font = [UIFont systemFontOfSize:12];
			[cell.contentView addSubview:alertLabel];
			
		}
		else{
			
			alarmLabel = (UILabel *)[cell.contentView viewWithTag:TitleTag];
			alertLabel = (UILabel *)[cell.contentView viewWithTag:AlertTag];

		}	
		
		alarmLabel.text = @"Alarm";
		if(alr != nil){
			alertLabel.text = alr;;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"RememObj" object:alr];
		}
		else{
			if(ape.alarme == nil){
				alertLabel.text = @"1 day before";
			}
			else{
				alertLabel.text = ape.alarme;
			}
		}
		
		return cell;
	}		

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if(indexPath.row == 0) return 80;
	else return 60;
	
}



@end
