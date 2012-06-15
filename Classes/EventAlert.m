//
//  EventAlert.m
//  MyProject
//
//  Created by ANDREI A on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAlert.h"
#import "Alarms.h"
#import "ILoveGCAppDelegate.h"


@implementation EventAlert

@synthesize tableview, navbar, cancel, item, done, list, etitle, pm, alert;
@synthesize datestr, datef, currdate, al, year, month, hour, day, minutes;
@synthesize localNotif, apev;


- (void)viewDidLoad{
	
	[super viewDidLoad];
	
	list = [[NSMutableArray alloc] init];
	
		//Add items
	[list addObject:@"None"];   
	[list addObject:@"30 minutes before"];
	[list addObject:@"1 hour before"];
	[list addObject:@"2 hours before"];
	[list addObject:@"1 day before"];
	[list addObject:@"2 days before"];
	[list addObject:@"On date of event"];
	
	self.tableview.backgroundColor = [UIColor grayColor];
	
	UIApplication *app = [UIApplication sharedApplication];
	
	NSArray *notifications = [app scheduledLocalNotifications];
	NSLog(@"nr of not = %d", [notifications count]);
	
	for (UILocalNotification *notf in notifications) {
	
		NSString *not = [notf.alertBody stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSString *et = [etitle stringByReplacingOccurrencesOfString:@" " withString:@""];
		if([not isEqualToString:et])
		{
			if (notf.userInfo != nil) {
				int info = [[notf.userInfo objectForKey:@"time"] intValue];
			
				if(info == apev.idcod){
					if (localNotif == nil) {
						localNotif = [[UILocalNotification alloc] init];
					
						localNotif.fireDate = notf.fireDate;
						NSLog(@"Notification will be shown on: %@",localNotif.fireDate);
						localNotif.timeZone = [NSTimeZone localTimeZone];
					
						localNotif.alertBody = [NSString stringWithFormat:@"%@", etitle];
						localNotif.alertAction = [NSString stringWithFormat:@"i Love GC12"]; 
						localNotif.hasAction = YES;
					
						localNotif.soundName = UILocalNotificationDefaultSoundName;
						localNotif.applicationIconBadgeNumber = -1;
						
						NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:apev.idcod] forKey:@"time"];
						localNotif.userInfo = infoDict;
						
					}
					
					[app cancelLocalNotification:notf];
					NSLog(@"nr. of notifications = %d", [[app scheduledLocalNotifications] count]);
				}
			}
		}
	}	

	
	j = 0;
}


-(IBAction) Cancel{
	
	UIApplication *app = [UIApplication sharedApplication];
	 
	NSArray *notifications = [app scheduledLocalNotifications];

	NSLog(@"nr. of notifications = %d", [notifications count]);
	
	for (UILocalNotification *notf in notifications) {
		
		NSString *not = [notf.alertBody stringByReplacingOccurrencesOfString:@" " withString:@""];
		NSString *et = [etitle stringByReplacingOccurrencesOfString:@" " withString:@""];		
		
		if([not isEqualToString:et])
		{
			if (notf.userInfo != nil) {
				int info = [[notf.userInfo objectForKey:@"time"] intValue];
				NSLog(@"info = %d", info);
				
				/*NSDateFormatter *date = [[[NSDateFormatter alloc] init] autorelease];
				[date setDateFormat:@"dd MMM yyyy hh:mm a"];
				NSString *eventtime = [NSString stringWithFormat:@"%@", [date stringFromDate:apev.completdate]];
			
				NSLog(@"eventtime = %@", eventtime);
				NSLog(@"info = %@", info);*/
				
				if(info == apev.idcod){
					[app cancelLocalNotification:notf];
					NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);	
					apev.alarmbut = @"bb";
					[[NSNotificationCenter defaultCenter] postNotificationName:@"NoAlarm" object:apev];
				}
			}
		}
	}
	 
	
	if(localNotif != nil){
		//NSLog(@"not body = %@", [localNotif alertBody]);
		[app scheduleLocalNotification:localNotif];
		apev.alarmbut = @"aa";
		[[NSNotificationCenter defaultCenter] postNotificationName:@"NoAlarm" object:apev];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"CategAlarm" object:apev];
	}
	//NSLog(@"localNotif = %@", localNotif.alertBody);
	
	NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);
	
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) Done{
	
	if (j != 1) {
		UIApplication *app = [UIApplication sharedApplication];
		//NSLog(@"body = %@", [localNotif alertBody]);		
		if(localNotif != nil){
			[app scheduleLocalNotification:localNotif];
			NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);
		}
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeAlarm" object:alert];
	
	[self dismissModalViewControllerAnimated:YES];	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	int count = [list count];
	return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"EventsTableCell";
	
	UITableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	NSString *cellValue = [list objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
	cell.textLabel.text =  cellValue;
	
	if ([apev.alarme isEqualToString:cellValue]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
			
	
	NSString *cellValue = [list objectAtIndex:indexPath.row];
	alert = cellValue;
	j = 1;
	
	
	for(int i=0;i<[list count];i++){		
		UITableViewCell *cell = [[self tableview] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]; 
		[cell setSelected:NO animated:YES];
		[cell setAccessoryType:UITableViewCellAccessoryNone];	
	}
	UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
	[newCell setSelected:YES animated:YES];
	[newCell setAccessoryType:UITableViewCellAccessoryCheckmark];
	
	
	if(indexPath.row == 0){
		
		UIApplication *app = [UIApplication sharedApplication];
		
		NSArray *notifications = [app scheduledLocalNotifications];
	
		NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);		
		
		if ([notifications count] != 0) {
		  for (UILocalNotification *notf in notifications) {
				
			NSString *not = [notf.alertBody stringByReplacingOccurrencesOfString:@" " withString:@""];
			NSString *et = [etitle stringByReplacingOccurrencesOfString:@" " withString:@""];	
			  
			if([not isEqualToString:et])
			{
				if (notf .userInfo != nil) {
					int info = [[notf.userInfo objectForKey:@"time"] intValue];
				//NSLog(@"fire date = %@", info);
				/*NSDateFormatter *date = [[[NSDateFormatter alloc] init] autorelease];
				[date setDateFormat:@"dd MMM yyyy hh:mm a"];
				NSString *eventtime = [NSString stringWithFormat:@"%@", [date stringFromDate:apev.completdate]];
				NSLog(@"eventtime = %@", eventtime);*/
				
					if(info == apev.idcod){
						[app cancelLocalNotification:notf];
						NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);	
					}
				}
			}
		  }
		}
		
		apev.alarmbut = @"bb";
		[[NSNotificationCenter defaultCenter] postNotificationName:@"NoAlarm" object:apev];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"CategAlarm" object:apev];
	}
	else if (indexPath.row == 1){
		
			//NSString *dt = [[NSString alloc] init];
			//dt = @"18 May 2011 2:20 pm";
			//NSLog(@"dt = %@", dt);		
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMM yyyy hh:mm a"];
		self.currdate = [datef dateFromString:apev.comdate];
		//NSLog(@"currdate = %@",currdate);
		
		NSDate *earlierdate = [currdate dateByAddingTimeInterval:-(60*30)];	
		//NSLog(@"earlierdate = %@", earlierdate);		
		
		NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
		[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateff setTimeZone:[NSTimeZone localTimeZone]];
		[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
		NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:earlierdate]];
		//NSLog(@"data = %@",data);
		
		NSScanner *scanner = [NSScanner scannerWithString:data];
		
		int day1;
		if ([scanner scanInt:&day1]) {
			day = day1;
			
			if([scanner scanString:@"-" intoString:NULL])
			{			
				int month1;
				if ([scanner scanInt:&month1]) {
					month = month1;
					
					if([scanner scanString:@"-" intoString:NULL])
					{
						int year1;
						if ([scanner scanInt:&year1]) {
							year = year1;
							
							if([scanner scanString:@"-" intoString:NULL])
							{
								int hour1;
								if ([scanner scanInt:&hour1]) {
									hour = hour1;
									
									if([scanner scanString:@":" intoString:NULL])
									{
										int min1;
										if ([scanner scanInt:&min1]) {
											minutes = min1;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		
		//NSLog(@"day = %d", day);  
		//NSLog(@"month = %d", month);  
		//NSLog(@"year = %d", year);  
		//NSLog(@"hour = %d", hour);  
		//NSLog(@"minutes = %d", minutes);  
		
		[components setDay:day];
		[components setMonth:month];
		[components setYear:year];
		[components setMinute:minutes];
		[components setHour:hour];
		
		NSDate *myNewDate = [calendar dateFromComponents:components];
		//NSLog(@"myNewDate = %@", myNewDate);
		
		[components release];
		
		
		[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
		
	}
	else if (indexPath.row == 2){
		
			//NSString *dt = [[NSString alloc] init];
			//dt = @"18 May 2011 2:20 pm";
			//NSLog(@"dt = %@", dt);		
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMM yyyy hh:mm a"];
		self.currdate = [datef dateFromString:datestr];
		//NSLog(@"currdate = %@",currdate);
		
		NSDate *earlierdate = [currdate dateByAddingTimeInterval:-(60*60)];	
		//NSLog(@"earlierdate = %@", earlierdate);		
		
		NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
		[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateff setTimeZone:[NSTimeZone localTimeZone]];
		[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
		NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:earlierdate]];
		//NSLog(@"data = %@",data);
		
		NSScanner *scanner = [NSScanner scannerWithString:data];
		
		int day1;
		if ([scanner scanInt:&day1]) {
			day = day1;
			
			if([scanner scanString:@"-" intoString:NULL])
			{			
				int month1;
				if ([scanner scanInt:&month1]) {
					month = month1;
					
					if([scanner scanString:@"-" intoString:NULL])
					{
						int year1;
						if ([scanner scanInt:&year1]) {
							year = year1;
							
							if([scanner scanString:@"-" intoString:NULL])
							{
								int hour1;
								if ([scanner scanInt:&hour1]) {
									hour = hour1;
									
									if([scanner scanString:@":" intoString:NULL])
									{
										int min1;
										if ([scanner scanInt:&min1]) {
											minutes = min1;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		
		//NSLog(@"day = %d", day);  
		//NSLog(@"month = %d", month);  
		//NSLog(@"year = %d", year);  
		//NSLog(@"hour = %d", hour);  
		//NSLog(@"minutes = %d", minutes);  
		
		[components setDay:day];
		[components setMonth:month];
		[components setYear:year];
		[components setMinute:minutes];
		[components setHour:hour];
		
		NSDate *myNewDate = [calendar dateFromComponents:components];
		//NSLog(@"myNewDate = %@", myNewDate);
		
		[components release];
		
		
		[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
		
	}
	else if (indexPath.row == 3){
		
		/*NSString *dt = [[NSString alloc] init];
		dt = @"16 May 2011 2:21 pm";
		NSLog(@"dt = %@", dt);	*/	
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMM yyyy hh:mm a"];
		self.currdate = [datef dateFromString:datestr];
		//NSLog(@"currdate = %@",currdate);
		
		NSDate *earlierdate = [currdate dateByAddingTimeInterval:-(2*(60*60))];	
		//NSLog(@"earlierdate = %@", earlierdate);		
		
		NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
		[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateff setTimeZone:[NSTimeZone localTimeZone]];
		[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
		NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:earlierdate]];
		//NSLog(@"data = %@",data);
		
		NSScanner *scanner = [NSScanner scannerWithString:data];
		
		int day1;
		if ([scanner scanInt:&day1]) {
			day = day1;
			
			if([scanner scanString:@"-" intoString:NULL])
			{			
				int month1;
				if ([scanner scanInt:&month1]) {
					month = month1;
					
					if([scanner scanString:@"-" intoString:NULL])
					{
						int year1;
						if ([scanner scanInt:&year1]) {
							year = year1;
							
							if([scanner scanString:@"-" intoString:NULL])
							{
								int hour1;
								if ([scanner scanInt:&hour1]) {
									hour = hour1;
									
									if([scanner scanString:@":" intoString:NULL])
									{
										int min1;
										if ([scanner scanInt:&min1]) {
											minutes = min1;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		
		//NSLog(@"day = %d", day);  
		//NSLog(@"month = %d", month);  
		//NSLog(@"year = %d", year);  
		//NSLog(@"hour = %d", hour);  
		//NSLog(@"minutes = %d", minutes);  
		
		[components setDay:day];
		[components setMonth:month];
		[components setYear:year];
		[components setMinute:minutes];
		[components setHour:hour];
		
		NSDate *myNewDate = [calendar dateFromComponents:components];
		//NSLog(@"myNewDate = %@", myNewDate);
		
		[components release];
		
		
		[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
	
	}
	else if (indexPath.row == 4){
		
		/*NSString *dt = [[NSString alloc] init];
		dt = @"16 May 2011 2:21 pm";
		NSLog(@"dt = %@", dt);	*/	
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMM yyyy hh:mm a"];
		self.currdate = [datef dateFromString:datestr];
		//NSLog(@"currdate = %@",currdate);
		
		NSDate *earlierdate = [currdate dateByAddingTimeInterval:-(60*60*24)];	
		//NSLog(@"earlierdate = %@", earlierdate);		
		
		NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
		[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateff setTimeZone:[NSTimeZone localTimeZone]];
		[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
		NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:earlierdate]];
		//NSLog(@"data = %@",data);
		
		NSScanner *scanner = [NSScanner scannerWithString:data];
		
		int day1;
		if ([scanner scanInt:&day1]) {
			day = day1;
			
			if([scanner scanString:@"-" intoString:NULL])
			{			
				int month1;
				if ([scanner scanInt:&month1]) {
					month = month1;
					
					if([scanner scanString:@"-" intoString:NULL])
					{
						int year1;
						if ([scanner scanInt:&year1]) {
							year = year1;
							
							if([scanner scanString:@"-" intoString:NULL])
							{
								int hour1;
								if ([scanner scanInt:&hour1]) {
									hour = hour1;
									
									if([scanner scanString:@":" intoString:NULL])
									{
										int min1;
										if ([scanner scanInt:&min1]) {
											minutes = min1;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		
		//NSLog(@"day = %d", day);  
		//NSLog(@"month = %d", month);  
		//NSLog(@"year = %d", year);  
		//NSLog(@"hour = %d", hour);  
		//NSLog(@"minutes = %d", minutes);  
		
		[components setDay:day];
		[components setMonth:month];
		[components setYear:year];
		[components setMinute:minutes];
		[components setHour:hour];
		
		NSDate *myNewDate = [calendar dateFromComponents:components];
		//NSLog(@"myNewDate = %@", myNewDate);
		
		[components release];
		
		
		[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
		
	}
	else if (indexPath.row == 5){
		
		/*NSString *dt = [[NSString alloc] init];
		dt = @"16 May 2011 2:21 pm";
		NSLog(@"dt = %@", dt);	*/	
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMM yyyy hh:mm a"];
		self.currdate = [datef dateFromString:datestr];
		//NSLog(@"currdate = %@",currdate);
		
		NSDate *earlierdate = [currdate dateByAddingTimeInterval:-(2*(60*60*24))];	
		//NSLog(@"earlierdate = %@", earlierdate);		
		
		NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
		[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateff setTimeZone:[NSTimeZone localTimeZone]];
		[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
		NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:earlierdate]];
		//NSLog(@"data = %@",data);
		
		NSScanner *scanner = [NSScanner scannerWithString:data];
		
		int day1;
		if ([scanner scanInt:&day1]) {
			day = day1;
			
			if([scanner scanString:@"-" intoString:NULL])
			{			
				int month1;
				if ([scanner scanInt:&month1]) {
					month = month1;
					
					if([scanner scanString:@"-" intoString:NULL])
					{
						int year1;
						if ([scanner scanInt:&year1]) {
							year = year1;
							
							if([scanner scanString:@"-" intoString:NULL])
							{
								int hour1;
								if ([scanner scanInt:&hour1]) {
									hour = hour1;
									
									if([scanner scanString:@":" intoString:NULL])
									{
										int min1;
										if ([scanner scanInt:&min1]) {
											minutes = min1;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		
		//NSLog(@"day = %d", day);  
		//NSLog(@"month = %d", month);  
		//NSLog(@"year = %d", year);  
		//NSLog(@"hour = %d", hour);  
		//NSLog(@"minutes = %d", minutes);  
		
		[components setDay:day];
		[components setMonth:month];
		[components setYear:year];
		[components setMinute:minutes];
		[components setHour:hour];
		
		NSDate *myNewDate = [calendar dateFromComponents:components];
		//NSLog(@"myNewDate = %@", myNewDate);
		
		[components release];
		
		
		[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
		
	}
	else if (indexPath.row == 6){
		
		/*NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
		
		NSString *dt = [[NSString alloc] init];
		dt = @"16 May 2011 1:40 pm";
		NSLog(@"dt = %@", dt);
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		[datef setDateFormat:@"dd MMM yyyy HH:mm a"];
		self.currdate = [datef dateFromString:dt];
		NSLog(@"currdate = %@",currdate);	
		
		NSDate *earlierdate = [currdate dateByAddingTimeInterval:(60*60)];	
		NSLog(@"earlierdate = %@", earlierdate);	
		
		NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
													   fromDate:currdate];
		NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
													   fromDate:currdate];	
		
		NSDateComponents *dateComps = [[NSDateComponents alloc] init];
		[dateComps setDay:[dateComponents day]];
		[dateComps setMonth:[dateComponents month]];
		[dateComps setYear:[dateComponents year]];
		[dateComps setHour:[timeComponents hour]];
			// Notification will fire in one minute
		[dateComps setMinute:[timeComponents minute]];
		[dateComps setSecond:[timeComponents second]];
		NSDate *itemDate = [calendar dateFromComponents:dateComps];
		[dateComps release];	*/	
		
			//NSString *dt = [[NSString alloc] init];
			//dt = @"18 May 2011 2:20 pm";
			//NSLog(@"dt = %@", dt);		
		
		datef = [[NSDateFormatter alloc] init];
		[datef setFormatterBehavior:NSDateFormatterBehavior10_4];
		[datef setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[datef setTimeZone:[NSTimeZone localTimeZone]];
		[datef setDateFormat:@"dd MMM yyyy hh:mm a"];
		self.currdate = [datef dateFromString:datestr];
		//NSLog(@"currdate = %@",currdate);
		
		NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
		[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateff setTimeZone:[NSTimeZone localTimeZone]];
		[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
		NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:currdate]];
		//NSLog(@"data = %@",data);
		
		NSScanner *scanner = [NSScanner scannerWithString:data];

		int day1;
		if ([scanner scanInt:&day1]) {
			day = day1;
				
			if([scanner scanString:@"-" intoString:NULL])
			{			
				int month1;
				if ([scanner scanInt:&month1]) {
					month = month1;
					
					if([scanner scanString:@"-" intoString:NULL])
					{
						int year1;
						if ([scanner scanInt:&year1]) {
							year = year1;
							
							if([scanner scanString:@"-" intoString:NULL])
							{
								int hour1;
								if ([scanner scanInt:&hour1]) {
									hour = hour1;
									
									if([scanner scanString:@":" intoString:NULL])
									{
										int min1;
										if ([scanner scanInt:&min1]) {
											minutes = min1;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components = [[NSDateComponents alloc] init];
		 
		//NSLog(@"day = %d", day);  
		//NSLog(@"month = %d", month);  
		//NSLog(@"year = %d", year);  
		//NSLog(@"hour = %d", hour);  
		//NSLog(@"minutes = %d", minutes);  
		
		[components setDay:day];
		[components setMonth:month];
		[components setYear:year];
		[components setMinute:minutes];
		[components setHour:hour];
		
		NSDate *myNewDate = [calendar dateFromComponents:components];
		//NSLog(@"myNewDate = %@", myNewDate);
		
		[components release];
		
		
		[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
		
	}	
	
	
	if (indexPath.row == 0) {
		UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@""
														 message:@"No alarm"
														delegate:self cancelButtonTitle:@"OK" 
											   otherButtonTitles:nil];
		
		[ale show];
		[ale release];
	}
	else {
		UIAlertView  *aler = [[UIAlertView alloc] initWithTitle:@""
														 message:@"Alarm has been set"
														delegate:self cancelButtonTitle:@"OK" 
											   otherButtonTitles:nil];
		
		[aler show];
		[aler release];		
	}	
}


/*-(void)checkAlarm:(NSTimer *)t{
    if ([[NSDate date] earlierDate:currdate] == currdate){
			// Alarm reached
        [t invalidate]; 
    }
}*/




-(void) scheduleNotificationForDate:(NSDate*)date {
	
	//[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	UIApplication *app = [UIApplication sharedApplication];
	
	NSArray *notifications = [app scheduledLocalNotifications];
	
	NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);	
	
	NSMutableArray *ar = [[NSMutableArray alloc] init];
	[ar addObjectsFromArray:notifications];
	int n = [ar count]; 
	//NSLog(@"nr. of notifications = %d", n);
	for (int i=0;i<n;i++) {
		if([[[ar objectAtIndex:i] alertBody] isEqualToString:etitle])
		{
			if ([[ar objectAtIndex:i] userInfo] != nil) {

				int info = [[[[ar objectAtIndex:i] userInfo] objectForKey:@"time"] intValue];
				//NSLog(@"fire date = %@", info);
				/*NSDateFormatter *date = [[[NSDateFormatter alloc] init] autorelease];
				[date setDateFormat:@"dd MMM yyyy hh:mm a"];
				NSString *eventtime = [NSString stringWithFormat:@"%@", [date stringFromDate:apev.completdate]];
			
				NSLog(@"eventtime = %@", eventtime);
				NSLog(@"info = %@", info);*/
			
				if(info == apev.idcod){
					[app cancelLocalNotification:[ar objectAtIndex:i]];
					NSLog(@"nr. of notf = %d", [[app scheduledLocalNotifications] count]);
				}
			}
		}
	}
	
	[ar release];
	
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
		
	localNotification.fireDate = date;
	NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
	
	localNotification.timeZone = [NSTimeZone localTimeZone];
	
	localNotification.alertBody = [NSString stringWithFormat:@"%@", etitle];
	localNotification.alertAction = [NSString stringWithFormat:@"i Love GC12"]; 
	localNotification.hasAction = YES;
	
	localNotification.soundName = UILocalNotificationDefaultSoundName;
	localNotification.applicationIconBadgeNumber = -1;
	
	NSDateFormatter *timef = [[[NSDateFormatter alloc] init] autorelease];
	[timef setDateFormat:@"dd MMM yyyy hh:mm a"];

	//NSString *string = [timef stringFromDate:apev.completdate];
	
	NSNumber *numb = [NSNumber numberWithInt:apev.idcod];
	NSLog(@"idcode: %d", apev.idcod);
	
	NSDictionary *infoDict = [NSDictionary dictionaryWithObject:numb forKey:@"time"];
	localNotification.userInfo = infoDict;
	
	[app scheduleLocalNotification:localNotification];
	[localNotification release];
	
	apev.alarmbut = @"aa";
	[[NSNotificationCenter defaultCenter] postNotificationName:@"NoAlarm" object:apev];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"CategAlarm" object:apev];
	
	NSLog(@"nr of not = %d", [[app scheduledLocalNotifications] count]);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[apev release];
	[localNotif release];
	[alert release];
	[etitle release];
	[currdate release];
	[datestr release];
	[al release];
	[done release];
	[item release];
	[cancel release];
	[navbar release];
	[tableview release];
    [super dealloc];
}


@end
