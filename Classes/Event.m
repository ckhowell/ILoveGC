//
//  Event.m
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"
#import "Categories.h"
#import "ILoveGCAppDelegate.h"
#import "Favourites.h"
#import "Maps.h"
#import "AppEvents.h"
#import "Email.h"
#import "Alarms.h"
#import "SHKFacebook.h"
#import "SHKTwitter2.h"
#import "Web.h"
#import "URLShortener.h"
#import "URLShortenerCredentials.h"



#define kIconHeight 112
#define kIconWidth 285
#define appIdFacebook @"248487288499886"

@implementation Event

@synthesize scrollView, notifications, phoneb, feedbackMsg, time, email2, phone2, web2,addToFav,showMap,addAlarm,sharelbl;
@synthesize eventimage, elatitude, elongitude, textview, emailb, cat, location;
@synthesize email, phone, web, alarms, alert, action, alert2, events, isShowAll;

@synthesize eventtitle, eventlocation, eventtime, eventdate, date, address, address2;
@synthesize event, dateFormatter, timeFormatter, share, favs, alarm, map;
@synthesize fromCategories, fromMaps, fromFavourites, fromSearch;


- (NSDateFormatter *)dateFormatter {
    if (dateFormatter == nil) {
		
        dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
		[dateFormatter setDateFormat:@"dd MMM yyyy"];
    }
    return dateFormatter;
}
-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    return string;
}
- (NSDateFormatter *)timeFormatter {
    if (timeFormatter == nil) {
		
		timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
		[timeFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
		[timeFormatter setDateFormat:@"hh:mm a"];
    }
	return timeFormatter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	CGRect labelPosition;
	double f;

		//Set the title of the navigation bar
	//self.navigationItem.title = event.category;
	
 
    //UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	//self.navigationItem.backBarButtonItem = backButton;
	//[backButton release];
	
	
	if (event.eventImage2.size.width < 280 && event.eventImage2.size.height < 230) {
		f = event.eventImage2.size.height;
		eventimage = [[UIImageView alloc] initWithFrame:CGRectMake(160 - event.eventImage2.size.width/2, 20, event.eventImage2.size.width, f)]; 
		eventimage.backgroundColor = [UIColor clearColor];
		eventimage.image = event.eventImage2;
		eventimage.contentMode = UIViewContentModeScaleAspectFit;
	}
	else 
	{
		NSLog(@"w = %d", event.eventImage2.size.width);
		NSLog(@"h = %d", event.eventImage2.size.height);
		if (event.eventImage2.size.width/event.eventImage2.size.height > 280/230) {
			f = 280*event.eventImage2.size.height/event.eventImage2.size.width;
			
			eventimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, f)]; 
			eventimage.backgroundColor = [UIColor clearColor];
			eventimage.image = event.eventImage2;
			eventimage.contentMode = UIViewContentModeScaleAspectFit;		
		}
		else {
			f = 230;
			
			eventimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 230)]; 
			eventimage.backgroundColor = [UIColor clearColor];
			eventimage.image = event.eventImage2;
			eventimage.contentMode = UIViewContentModeScaleAspectFit;	
		}
	}
	
   
	
	if (event.eventImage2 == nil) {
		f = 20;
	}
	else {
		labelPosition = eventimage.frame;
		f = labelPosition.origin.y +  eventimage.frame.size.height + 20;
	}
	
	eventtitle = [[UILabel alloc] initWithFrame:CGRectMake(27, f, 246, 21)]; 
	eventtitle.backgroundColor = [UIColor clearColor];
	//eventtitle.textColor = [UIColor whiteColor];
    eventtitle.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
	eventtitle.font = [UIFont boldSystemFontOfSize:20];
	eventtitle.numberOfLines = 0;
	eventtitle.text = [self htmlEntityDecode:event.eventTitle];
	[eventtitle sizeToFit];
	eventtitle.lineBreakMode = UILineBreakModeWordWrap;
//	eventtitle.font = [UIFont boldSystemFontOfSize:16];	
	
	labelPosition = eventtitle.frame;
	f = labelPosition.origin.y + eventtitle.frame.size.height + 20;
	
	if(event.date != nil){
		eventdate = [[UILabel alloc] initWithFrame:CGRectMake(91, f, 209, 21)]; 
		eventdate.backgroundColor = [UIColor clearColor];
		eventdate.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];//[UIColor whiteColor];
        
        
		eventdate.font = [UIFont systemFontOfSize:13];
	
		date = [[UILabel alloc] initWithFrame:CGRectMake(27, f, 64, 21)]; 
		date.backgroundColor = [UIColor clearColor];
        date.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];
		date.font = [UIFont systemFontOfSize:13];
		date.text = @"Date";	
	
		labelPosition = eventdate.frame;
		f = labelPosition.origin.y + eventdate.frame.size.height;
	}

	if (event.time != nil) {
		eventtime = [[UILabel alloc] initWithFrame:CGRectMake(91, f, 209, 21)]; 
		eventtime.backgroundColor = [UIColor clearColor];
		eventtime.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];
		eventtime.font = [UIFont systemFontOfSize:13];
	
		time = [[UILabel alloc] initWithFrame:CGRectMake(27, f, 64, 21)]; 
		time.backgroundColor = [UIColor clearColor];
        time.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];
		time.font = [UIFont systemFontOfSize:13];
		time.text = @"Time";
		
		labelPosition = eventtime.frame;
		f = labelPosition.origin.y + eventtime.frame.size.height;
	}
	else {
		f += 25;
	}

	
	if (![event.region isEqualToString:@""]) {
		eventlocation = [[UILabel alloc] initWithFrame:CGRectMake(91, f, 209, 21)]; 
		eventlocation.backgroundColor = [UIColor clearColor];
		eventlocation.textColor = [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];
		eventlocation.font = [UIFont systemFontOfSize:13];
		eventlocation.text = [event.region capitalizedString];
        eventlocation.text = [self htmlEntityDecode:eventlocation.text];
	
		location = [[UILabel alloc] initWithFrame:CGRectMake(27, f, 64, 21)]; 
		location.backgroundColor = [UIColor clearColor];
        location.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];
		location.font = [UIFont systemFontOfSize:13];
		location.text = @"Location";
		
		labelPosition = eventlocation.frame;
		f = labelPosition.origin.y + eventlocation.frame.size.height;
	}
	else {
		f += 25;
	}

	
	if (![event.street isEqualToString:@""]) {
		address = [[UILabel alloc] initWithFrame:CGRectMake(91, f+3, 209, 21)]; 
		address.backgroundColor = [UIColor clearColor];
		address.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
		address.font = [UIFont systemFontOfSize:13];
		address.numberOfLines = 0;
		address.text = [event.street stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        address.text = [self htmlEntityDecode:address.text];
		[address sizeToFit];
		address.lineBreakMode = UILineBreakModeWordWrap;		
		
		address2 = [[UILabel alloc] initWithFrame:CGRectMake(27, f, 64, 21)]; 
		address2.backgroundColor = [UIColor clearColor];
        address2.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];
		address2.font = [UIFont systemFontOfSize:13];
		address2.text = @"Address";

		labelPosition = address.frame;
		f = labelPosition.origin.y + address.frame.size.height + 28;
	}
	
	favs = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	favs.frame = CGRectMake(29, f, 52, 52);
	favs.backgroundColor = [UIColor clearColor];
    [favs setImage:[UIImage imageNamed:@"btn_addtofavs_off.png"] forState:UIControlStateNormal];
	[favs addTarget:self action:@selector(addToFavs:) forControlEvents:UIControlEventTouchUpInside];	
	
    addToFav = [[UILabel alloc] initWithFrame:CGRectMake(29, f + 43, 75, 21)];
    addToFav.backgroundColor = [UIColor clearColor];
    addToFav.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];
    addToFav.text = @"Add to Favs";
    addToFav.font = [UIFont boldSystemFontOfSize:10];
    
    
	map = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	map.frame = CGRectMake(99, f, 52, 52);
	map.backgroundColor = [UIColor clearColor];
	[map setImage:[UIImage imageNamed:@"btn_showmap_off.png"] forState:UIControlStateNormal];
	[map addTarget:self action:@selector(ShowMap:) forControlEvents:UIControlEventTouchUpInside];	
	
    showMap = [[UILabel alloc] initWithFrame:CGRectMake(102, f + 43, 75, 21)];
    showMap.backgroundColor = [UIColor clearColor];
    showMap.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];
    showMap.text = @"Show Map";
    showMap.font = [UIFont boldSystemFontOfSize:10];
    
	alarm = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	alarm.frame = CGRectMake(171, f, 52, 52);
	alarm.backgroundColor = [UIColor clearColor];
	[alarm setImage:[UIImage imageNamed:@"btn_addalarm_off.png"] forState:UIControlStateNormal];
	[alarm addTarget:self action:@selector(Alarm:) forControlEvents:UIControlEventTouchUpInside];	
	
    addAlarm = [[UILabel alloc] initWithFrame:CGRectMake(174, f + 43, 75, 21)];
    addAlarm.backgroundColor = [UIColor clearColor];
    addAlarm.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];
    addAlarm.text = @"Add Alarm";
    addAlarm.font = [UIFont boldSystemFontOfSize:10];
    
	share = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	share.frame = CGRectMake(243, f, 52, 52);
	share.backgroundColor = [UIColor clearColor];
	[share setImage:[UIImage imageNamed:@"btn_share_off.png"] forState:UIControlStateNormal];
	[share addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];	
	
    sharelbl = [[UILabel alloc] initWithFrame:CGRectMake(255, f + 43, 75, 21)];
    sharelbl.backgroundColor = [UIColor clearColor];
    sharelbl.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];
    sharelbl.text = @"Share";
    sharelbl.font = [UIFont boldSystemFontOfSize:10];
    
	labelPosition = share.frame;
	f = labelPosition.origin.y + share.frame.size.height + 20;	
	
	if (![event.description isEqualToString:@""]) {
		textview = [[UITextView alloc] initWithFrame:CGRectMake(20, f, 280, 130)]; 
		textview.backgroundColor = [UIColor clearColor];
		textview.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
		textview.font = [UIFont systemFontOfSize:13];
		textview.text = [event.description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        textview.text = [self htmlEntityDecode:event.description];
        textview.textAlignment = UITextAlignmentLeft;
		textview.userInteractionEnabled = NO;
		[textview sizeToFit];
	}
	
	if(event.date2 == nil && event.date != nil){
		self.eventdate.text = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:event.date]];
	}
	else{
		if(event.date == nil){
			self.eventdate.text = @"";
		}
		else{
			self.eventdate.text = [NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:event.date], [self.dateFormatter stringFromDate:event.date2]];
		}
	}	
	
	
	//NSLog(@"time = %@", event.time);
	if(event.time2 == nil && event.time != nil){		
		eventtime.text = [NSString stringWithFormat:@"%@", [self.timeFormatter stringFromDate:event.time]];
		//NSLog(@"%@", eventtime.text);
	}
	else{
		if(event.time == nil){
			eventtime.text = nil; 
		}
		else{
			eventtime.text = [NSString stringWithFormat:@"%@ - %@", [self.timeFormatter stringFromDate:event.time], [self.timeFormatter stringFromDate:event.time2]];
			//NSLog(@"%@", eventtime.text);
		}
	}
	
	
	UIScrollView *tempScrollView = (UIScrollView *) self.scrollView;
	tempScrollView.backgroundColor = [UIColor clearColor];
	[tempScrollView addSubview:eventtime];
	[tempScrollView addSubview:textview];
	[tempScrollView addSubview:time];
	[tempScrollView addSubview:eventdate];
	[tempScrollView addSubview:date];
	[tempScrollView addSubview:eventlocation];
	[tempScrollView addSubview:location];
	[tempScrollView addSubview:address];
	[tempScrollView addSubview:address2];
	[tempScrollView addSubview:favs];
	[tempScrollView addSubview:map];
	[tempScrollView addSubview:share];
	[tempScrollView addSubview:alarm];
	[tempScrollView addSubview:eventtitle];
	[tempScrollView addSubview:eventimage];
    [tempScrollView addSubview:addToFav];
    [tempScrollView addSubview:showMap];
    [tempScrollView addSubview:addAlarm];
    [tempScrollView addSubview:sharelbl];
	
	if (![event.description isEqualToString:@""]) {
		CGRect frame = textview.frame;
		frame.size.height = textview.contentSize.height;
		textview.frame = frame;	
	
		labelPosition = frame;
		f = labelPosition.origin.y + frame.size.height + 20;
	}
	
	if(![event.web isEqualToString:@""]){
		web = [[UILabel alloc] initWithFrame:CGRectMake(70, f, 220, 21)]; 
		web.backgroundColor = [UIColor clearColor];
		web.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
		web.font = [UIFont systemFontOfSize:13];
		web.numberOfLines = 0;
		web.text = event.web;
		[web sizeToFit];
		web.lineBreakMode = UILineBreakModeWordWrap;
		[tempScrollView addSubview:web];		
	
		//web2 = [[UILabel alloc] initWithFrame:CGRectMake(30, f, 61, 21)]; 
        web2 = [[UILabel alloc] initWithFrame:CGRectMake(30, f - 3, 61, 21)];
		web2.backgroundColor = [UIColor clearColor];
        web2.textColor =  [UIColor colorWithRed:0x84/255.0 green:0x84/255.0 blue:0x84/255.0 alpha:1];
		web2.text = @"Web ";
		web2.font = [UIFont systemFontOfSize:13];
		[tempScrollView addSubview:web2];
		
		labelPosition = web.frame;
		f = labelPosition.origin.y + web.frame.size.height;
	}
	
	if(![event.email isEqualToString:@""]){
		email = [[UILabel alloc] initWithFrame:CGRectMake(70, f, 220, 21)];
		email.backgroundColor = [UIColor clearColor];
		email.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
		email.font = [UIFont systemFontOfSize:13];
		email.numberOfLines = 0;
		email.text = event.email;
		[email sizeToFit];
		email.lineBreakMode = UILineBreakModeWordWrap;
		[tempScrollView addSubview:email];	
	
		//email2 = [[UILabel alloc] initWithFrame:CGRectMake(30, f, 61, 21)];
        email2 = [[UILabel alloc] initWithFrame: CGRectMake(30, f - 2, 209, 21)];
		email2.backgroundColor = [UIColor clearColor];
        email2.textColor =  [UIColor colorWithRed:0x84/255.0 green:0x84/255.0 blue:0x84/255.0 alpha:1];
		email2.text = @"Email";
		email2.font = [UIFont systemFontOfSize:13];
		[tempScrollView addSubview:email2];
	
		labelPosition = email.frame;
		f = labelPosition.origin.y + email.frame.size.height;
	}
	
	if (![event.phone isEqualToString:@""]){
		phone = [[UILabel alloc] initWithFrame:CGRectMake(70, f, 220, 21)]; 
		phone.backgroundColor = [UIColor clearColor];
		phone.textColor =  [UIColor colorWithRed:0x34/255.0 green:0x34/255.0 blue:0x34/255.0 alpha:1];//[UIColor whiteColor];
		phone.font = [UIFont systemFontOfSize:13];
		phone.text = event.phone;
		[tempScrollView addSubview:phone];
	
		phone2 = [[UILabel alloc] initWithFrame:CGRectMake(30, f , 61, 21)]; 
		phone2.backgroundColor = [UIColor clearColor];
        phone2.textColor  =  [UIColor colorWithRed:0x84/255.0 green:0x84/255.0 blue:0x84/255.0 alpha:1];
		phone2.text = @"Phone";
		phone2.font = [UIFont systemFontOfSize:13];
		[tempScrollView addSubview:phone2];
		
		labelPosition = phone.frame;
		f = labelPosition.origin.y + phone.frame.size.height;
	}
	
	f = f + 30;
	emailb = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain]; 
	emailb.frame = CGRectMake(27, f, 116, 40); 
	emailb.backgroundColor = [UIColor clearColor];
	[emailb setBackgroundImage:[UIImage imageNamed:@"btn_email_off.png"] forState:UIControlStateNormal];
	//[emailb setTitle:@"Email" forState:UIControlStateNormal];
	//[emailb setTitle:@"Email" forState:UIControlStateHighlighted];
	//[emailb setTitle:@"Email" forState:UIControlStateSelected];
	//emailb.titleLabel.font = [UIFont boldSystemFontOfSize:14];
	//emailb.imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Email_Off.png"]];
	//[emailb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[emailb setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	//[emailb setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
	[emailb addTarget:self action:@selector(Emailb:) forControlEvents:UIControlEventTouchUpInside];	
	[tempScrollView addSubview:emailb];	
	
	phoneb = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	phoneb.frame = CGRectMake(170, f, 116, 40);
	phoneb.backgroundColor = [UIColor clearColor];
	[phoneb setBackgroundImage:[UIImage imageNamed:@"btn_web_off.png"] forState:UIControlStateNormal];
	//[phoneb setTitle:@"Phone" forState:UIControlStateNormal];
	//[phoneb setTitle:@"Phone" forState:UIControlStateHighlighted];
	//[phoneb setTitle:@"Phone" forState:UIControlStateSelected];
	//phoneb.titleLabel.font = [UIFont boldSystemFontOfSize:14]; 
	//[phoneb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//[phoneb setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	//[phoneb setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
	[phoneb addTarget:self action:@selector(Phoneb:) forControlEvents:UIControlEventTouchUpInside];	
	[tempScrollView addSubview:phoneb];	
	
	labelPosition = emailb.frame;
	f = labelPosition.origin.y + emailb.frame.size.height;
	
	f = f + 25; 
	tempScrollView.contentSize = CGSizeMake(0, f);	
	NSLog(@"%@",event.category);
	if ([event.category isEqualToString:@"Arts"]) {
      /*  UIImageView *navigationBarView = [[UIImageView alloc] 
                                          initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width/2 - 25, self.navigationController.navigationBar.frame.size.height/2 - 10, 
                                                                   71,
                                                                   21)];
        [navigationBarView setImage:[UIImage imageNamed:@"topbar_arts.png"]];
        
        navigationBarView.tag = 2;
        
        
        UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
        
        if ( testImgView != nil )
        {
            NSLog(@"%s yes there is a bg image so remove it then add it so it doesn't double it", __FUNCTION__);
            [testImgView removeFromSuperview];
            
        } else {
            NSLog(@"%s no there isn't a bg image so add it ", __FUNCTION__);
        }
        
        
        
        [self.navigationController.navigationBar addSubview:navigationBarView];
        [navigationBarView release];*/
        //[self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_arts.png"]]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_arts.png"] forBarMetrics:UIBarMetricsDefault];
		self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 
		
		
		/*date.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor]; [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 
		time.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];[UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 
		location.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];[UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 
		address2.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];[UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0];  
		phone2.textColor =[UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor]; [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 
		email2.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];[UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 
		web2.textColor = [UIColor colorWithRed:0x85/255.0 green:0x85/255.0 blue:0x85/255.0 alpha:1]; // [UIColor grayColor];[UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; */

		[share setImage:[UIImage imageNamed:@"btn_share_off.png"] forState:UIControlStateNormal];
		[share setImage:[UIImage imageNamed:@"btn_share_on.png"] forState:UIControlStateSelected];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_off.png"] forState:UIControlStateNormal];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_on.png"] forState:UIControlStateSelected];
		[map setImage:[UIImage imageNamed:@"btn_showmap_off.png"] forState:UIControlStateNormal];
		[map setImage:[UIImage imageNamed:@"btn_showmap_on.png"] forState:UIControlStateSelected];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_off.png"] forState:UIControlStateNormal];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_on.png"] forState:UIControlStateSelected];
		[emailb setImage:[UIImage imageNamed:@"btn_email_off.png"] forState:UIControlStateNormal];
		[emailb setImage:[UIImage imageNamed:@"btn_email_on.png"] forState:UIControlStateSelected];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_off.png"] forState:UIControlStateNormal];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_on.png"] forState:UIControlStateSelected];
	}
	else if([event.category isEqualToString:@"Community"]){
       /* UIImageView *navigationBarView = [[UIImageView alloc] 
                                          initWithFrame:CGRectMake(0, 0, 
                                                                   self.navigationController.navigationBar.frame.size.width,
                                                                   self.navigationController.navigationBar.frame.size.height)];

        [navigationBarView setImage:[UIImage imageNamed:@"topbar_comm.png"]];
        
        navigationBarView.tag = 2;
        
        
        UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
        
        if ( testImgView != nil )
        {
            NSLog(@"%s yes there is a bg image so remove it then add it so it doesn't double it", __FUNCTION__);
            [testImgView removeFromSuperview];
            
        } else {
            NSLog(@"%s no there isn't a bg image so add it ", __FUNCTION__);
        }
        
        
        
        [self.navigationController.navigationBar addSubview:navigationBarView];
        [navigationBarView release];*/
        //[self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_comm.png"]]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_comm.png"] forBarMetrics:UIBarMetricsDefault];
		self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0]; 
			
        
		/*date.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];
		time.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0]; 
		location.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];
		address2.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];
		phone2.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];
		email2.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0]; 
		web2.textColor = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0]; */
		
        
		[phoneb setImage:[UIImage imageNamed:@"btn_web_off.png"] forState:UIControlStateNormal];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_on.png"] forState:UIControlStateSelected];
		[emailb setImage:[UIImage imageNamed:@"btn_email_off.png"] forState:UIControlStateNormal];
		[emailb setImage:[UIImage imageNamed:@"btn_email_on.png"] forState:UIControlStateSelected];
		
        [share setImage:[UIImage imageNamed:@"btn_share_off.png"] forState:UIControlStateNormal];
		[share setImage:[UIImage imageNamed:@"btn_share_on.png"] forState:UIControlStateSelected];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_off.png"] forState:UIControlStateNormal];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_on.png"] forState:UIControlStateSelected];
		[map setImage:[UIImage imageNamed:@"btn_showmap_off.png"] forState:UIControlStateNormal];
		[map setImage:[UIImage imageNamed:@"btn_showmap_on.png"] forState:UIControlStateSelected];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_off.png"] forState:UIControlStateNormal];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_on.png"] forState:UIControlStateSelected];
	}
	else if ([event.category isEqualToString:@"Food"]) {
        /*UIImageView *navigationBarView = [[UIImageView alloc] 
                                          initWithFrame:CGRectMake(0, 0, 
                                                                   self.navigationController.navigationBar.frame.size.width,
                                                                   self.navigationController.navigationBar.frame.size.height)];
        [navigationBarView setImage:[UIImage imageNamed:@"topbar_food.png"]];
        
        navigationBarView.tag = 2;
        
        
        UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
        
        if ( testImgView != nil )
        {
            NSLog(@"%s yes there is a bg image so remove it then add it so it doesn't double it", __FUNCTION__);
            [testImgView removeFromSuperview];
            
        } else {
            NSLog(@"%s no there isn't a bg image so add it ", __FUNCTION__);
        }
        
        
        
        [self.navigationController.navigationBar addSubview:navigationBarView];
        [navigationBarView release];*/
        //[self.navigationController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"topbar_food.png"]]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_food.png"] forBarMetrics:UIBarMetricsDefault];
		self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];  	
			
		/*date.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];  
		time.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];  
		location.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];  
		address2.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];
		phone2.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];   
		email2.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];   
		web2.textColor = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0];  */
		
		[share setImage:[UIImage imageNamed:@"btn_share_off.png"] forState:UIControlStateNormal];
		[share setImage:[UIImage imageNamed:@"btn_share_on.png"] forState:UIControlStateSelected];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_off.png"] forState:UIControlStateNormal];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_on.png"] forState:UIControlStateSelected];
		[map setImage:[UIImage imageNamed:@"btn_showmap_off.png"] forState:UIControlStateNormal];
		[map setImage:[UIImage imageNamed:@"btn_showmap_on.png"] forState:UIControlStateSelected];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_off.png"] forState:UIControlStateNormal];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_on.png"] forState:UIControlStateSelected];
        
		[emailb setImage:[UIImage imageNamed:@"btn_email_off.png"] forState:UIControlStateNormal];
		[emailb setImage:[UIImage imageNamed:@"btn_email_on.png"] forState:UIControlStateSelected];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_off.png"] forState:UIControlStateNormal];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_on.png"] forState:UIControlStateSelected];
	}
	else if([event.category isEqualToString:@"Sport"]){
     
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_sport.png"] forBarMetrics:UIBarMetricsDefault];
		self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0];

		/*date.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0];
		time.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
		location.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
		address2.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
		phone2.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
		email2.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0];
		web2.textColor = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0];*/
		
		[share setImage:[UIImage imageNamed:@"btn_share_off.png"] forState:UIControlStateNormal];
		[share setImage:[UIImage imageNamed:@"btn_share_on.png"] forState:UIControlStateSelected];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_off.png"] forState:UIControlStateNormal];
		[alarm setImage:[UIImage imageNamed:@"btn_addalarm_on.png"] forState:UIControlStateSelected];
		[map setImage:[UIImage imageNamed:@"btn_showmap_off.png"] forState:UIControlStateNormal];
		[map setImage:[UIImage imageNamed:@"btn_showmap_on.png"] forState:UIControlStateSelected];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_off.png"] forState:UIControlStateNormal];
		[favs setImage:[UIImage imageNamed:@"btn_addtofavs_on.png"] forState:UIControlStateSelected];
        

		[emailb setImage:[UIImage imageNamed:@"btn_email_off.png"] forState:UIControlStateNormal];
		[emailb setImage:[UIImage imageNamed:@"btn_email_on.png"] forState:UIControlStateSelected];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_off.png"] forState:UIControlStateNormal];
		[phoneb setImage:[UIImage imageNamed:@"btn_web_on.png"] forState:UIControlStateSelected];
	}
	else {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar_default.png"] forBarMetrics:UIBarMetricsDefault];
		//self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0];
   
    }
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(notifications:)
											     name:@"Notifications" 
											   object:nil];
	
	
	v = 0;
	h = 0;
	d = 0;
	
}


-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:YES];
	
	//NSLog(@"%@", self.navigationController.title);
	//if (![navTitle isEqual:self.navigationController.title]) {
	//	[self.navigationController popToRootViewControllerAnimated:YES];
	//
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
     self.title = @"Back";

}



- (void)viewWillAppear:(BOOL)animated{
    
    self.title = event.eventTitle;
	[super viewWillAppear:YES];
	
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it", __FUNCTION__);
        [testImgView removeFromSuperview];  
    }
    
    
	ILoveGCAppDelegate *apd = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	navTitle = apd.aTabBarController.selectedViewController.title;
	
	int selectedTab;
	
	if (fromCategories == YES) {
		selectedTab = 0;
	}
	else if(fromFavourites == YES){
		selectedTab = 1;
	}
	else if (fromMaps == YES) {
		selectedTab = 2;
	}
	else if(fromSearch == YES){
		selectedTab = 3;
	}
	else {
		selectedTab = 4;
	}
		
		
	if (self.tabBarController.selectedIndex!=selectedTab) {
		if ([event.category isEqualToString:@"Arts"]) {
			self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:186/255.f green:39/255.f blue:91/255.f alpha:1.0]; 	
		}
		else if([event.category isEqualToString:@"Community"]){
			self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:242/255.f green:96/255.f blue:0/255.f alpha:1.0];
		}
		else if([event.category isEqualToString:@"Sport"]){
			self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:247/255.f green:174/255.f blue:11/255.f alpha:1.0]; 
		}
		else if ([event.category isEqualToString:@"Food"]) {
			self.navigationController.navigationBar.tintColor  = [UIColor colorWithRed:102/255.f green:179/255.f blue:88/255.f alpha:1.0]; 	
		}
	}
	
	isDealloc = YES;
}


-(void)notifications:(NSNotification *)notif
{
	for(int g=0;g<[events count];g++){
		if([[[events objectAtIndex:g] eventTitle] isEqual:[[notif object] eventTitle]]){
			if ([[events objectAtIndex:g] idcod] == [[notif object] idcod]) {
				[events removeObjectAtIndex:g];
			}
		}
	}
}


/*- (void)timerTick{

    UIAlertView *alert3=[[UIAlertView alloc]initWithTitle:@"alert" message:@"Yours Time Out" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
	[alert3 show];
	//[alert3 release];
	
	NSString *altadata = @"10 Jun 2011 12:39 pm";
	NSDateFormatter *dateFormatter3 = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter3 setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter3 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	[dateFormatter3 setTimeZone:[NSTimeZone localTimeZone]];
	[dateFormatter3 setDateFormat:@"dd MMM yyyy hh:mm a"];
	NSDate *odata = [dateFormatter3 dateFromString:altadata];	
	
	UIApplication *app = [UIApplication sharedApplication];
	
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
	
	localNotification.fireDate = odata;
	NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
	
	localNotification.timeZone = [NSTimeZone localTimeZone];
	
	localNotification.alertBody = [NSString stringWithFormat:@"%@", event.eventTitle];
	
	localNotification.alertAction = [NSString stringWithFormat:@"i Love GC"]; 
	localNotification.hasAction = YES;
	
	localNotification.soundName = UILocalNotificationDefaultSoundName;
	localNotification.applicationIconBadgeNumber = -1;
	
	NSString *string = event.eventTitle;
	NSDictionary *infoDict = [NSDictionary dictionaryWithObject:string forKey:@"i Love GC"];
	localNotification.userInfo = infoDict;
	
	[app scheduleLocalNotification:localNotification];
	[localNotification release];
}*/



- (void)addToFavs:(UIButton *)sender {
	
	
	/*NSString *altadata = @"10 Jun 2011 12:30 pm";
	NSDateFormatter *dateFormatter3 = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter3 setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter3 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	[dateFormatter3 setTimeZone:[NSTimeZone localTimeZone]];
	[dateFormatter3 setDateFormat:@"dd MMM yyyy hh:mm a"];
	NSDate *odata = [dateFormatter3 dateFromString:altadata];	
	
	NSTimer *timer = [[NSTimer alloc] initWithFireDate:odata interval:0 
							target:self selector:@selector(timerTick) userInfo:nil repeats:NO];
	//NSRunLoop *runner = [NSRunLoop mainRunLoop];
	//[runner addTimer:timer forMode: NSDefaultRunLoopMode];
	//[timer release];	
	[timer invalidate];*/
	
	
	/*[favs setSelected:YES];
	[map setSelected:NO];
	[alarm setSelected:NO];
	[share setSelected:NO];*/
	

	if(event.favs == 1){
		if ([event.alarmbut isEqualToString:@"aa"]) {
			//NSLog(@"%@", event.alarmbut);
			UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																message:@"This event has already been added to Favs with an alarm!"
															   delegate:nil 
													  cancelButtonTitle:@"Ok"
													  otherButtonTitles:nil];	
			[alertview show];
			[alertview release];			
		}
		else {
			UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																message:@"This event has already been added to Favs!"
															   delegate:nil 
													  cancelButtonTitle:@"Ok"
													  otherButtonTitles:nil];	
			[alertview show];
			[alertview release];			
		}

	}
	else {	
		AppEvents *ap;
		int c = 0;
		for(int o = 0;o<[events count];o++){
			if([[[events objectAtIndex:o] eventTitle] isEqualToString:event.eventTitle]){
				if ([[events objectAtIndex:o] idcod] == event.idcod) {
					c = 1;
					ap = [events objectAtIndex:o];
				}
			}
		}
		
		if(c == 0){
			[events addObject:event];
			alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ has been added to your favourites", event.eventTitle] 
											   message:@"Would you like to add an alarm ?\n\nYou will be notified 1 day before this event starts" 
											  delegate:self 
									 cancelButtonTitle:@"No"
									 otherButtonTitles:@"Yes", nil];	
			[alert show];
			event.favs = 1;
		}	
		else {
			if ([ap.alarmbut isEqualToString:@"aa"]) {
				//NSLog(@"%@", ap.alarmbut);
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																	message:@"This event has already been added to Favs with an alarm!"
																   delegate:nil 
														  cancelButtonTitle:@"Ok"
														  otherButtonTitles:nil];	
				[alertview show];
				[alertview release];
			}
			else {
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																	message:@"This event has already been added to Favs!"
																	delegate:nil 
															cancelButtonTitle:@"Ok"
															otherButtonTitles:nil];	
				[alertview show];
				[alertview release];
			}

		}
	}

	al2 = 0;
	
	/*Favourites *fav = [[Favourites alloc] initWithNibName:@"Favourites" bundle:nil];
	fav.listOfItems = [[NSMutableArray alloc] init]; 
	[fav.listOfItems addObject:event];
	[fav.tableView reloadData];
	[self.navigationController pushViewController:fav animated:YES];
		//[fav release];*/
}


-(void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSDate *now = [NSDate date];
	//NSLog(@"now = %@", now);
	
	//now = [now dateByAddingTimeInterval:(60*60*24)+(60*5)];
	//NSLog(@"futuredate = %@", now);
	
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
	NSString *dat = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:event.date]];
	NSString *tim =	[NSString stringWithFormat:@"%@", [self.timeFormatter stringFromDate:event.time]];	
	//NSString *complet = @"12 Jul 2011 2:22 pm";
	
	NSString *complet = [NSString stringWithFormat:@"%@ %@", dat, tim];
	
	/*NSDateFormatter *daterr = [[NSDateFormatter alloc] init];
	 [daterr setFormatterBehavior:NSDateFormatterBehavior10_4];
	 [daterr setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	 [daterr setTimeZone:[NSTimeZone timeZoneWithName:@"	UTC"]];
	 [daterr setDateFormat:@"dd MMM yyyy hh:mm a"];	
	 NSString *complet = [NSString stringWithFormat:@"%@", [daterr stringFromDate:now]];*/
	//NSLog(@"complet = %@", complet);
	
	event.comdate = complet;
	
	NSDateFormatter *dater = [[NSDateFormatter alloc] init];
	[dater setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dater setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	[dater setTimeZone:[NSTimeZone localTimeZone]];
	[dater setDateFormat:@"dd MMM yyyy hh:mm a"];
	event.completdate = [dater dateFromString:complet];		
	
	
	if (buttonIndex == 0)
	{	
		if (al2 == 1) {
			for (int i=0;i<[events count];i++) {
				if ([[[events objectAtIndex:i] eventTitle] isEqual:event.eventTitle]) {
					if ([[events objectAtIndex:i] idcod] == event.idcod) {
						[events removeObjectAtIndex:i];
					}
				}
			}
		}
		if(al2 != 1){		
			event.alarmbut = @"bb";
			event.alarme = @"None";
			[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:event];
		}
	}
	if (buttonIndex == 1)
	{	
		/*NSDate *now = [NSDate date];
		//NSLog(@"now = %@", now);
		
		//now = [now dateByAddingTimeInterval:(60*60*24)+(60*5)];
		//NSLog(@"futuredate = %@", now);
		
		NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
		
		NSString *dat = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:event.date]];
		NSString *tim =	[NSString stringWithFormat:@"%@", [self.timeFormatter stringFromDate:event.time]];	
		//NSString *complet = @"25 Jun 2011 11:25 am";
		
		NSString *complet = [NSString stringWithFormat:@"%@ %@", dat, tim];
		
		/*NSDateFormatter *daterr = [[NSDateFormatter alloc] init];
		[daterr setFormatterBehavior:NSDateFormatterBehavior10_4];
		[daterr setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[daterr setTimeZone:[NSTimeZone timeZoneWithName:@"	UTC"]];
		[daterr setDateFormat:@"dd MMM yyyy hh:mm a"];	
		NSString *complet = [NSString stringWithFormat:@"%@", [daterr stringFromDate:now]];*/
		//NSLog(@"complet = %@", complet);
		
		/*event.comdate = complet;
		
		NSDateFormatter *dater = [[NSDateFormatter alloc] init];
		[dater setFormatterBehavior:NSDateFormatterBehavior10_4];
		[dater setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
		[dater setTimeZone:[NSTimeZone localTimeZone]];
		[dater setDateFormat:@"dd MMM yyyy hh:mm a"];
		event.completdate = [dater dateFromString:complet];	
		//NSLog(@"completdate = %@", event.completdate);*/
		
		
		NSComparisonResult result = [now compare:event.completdate];
		
		if(result==NSOrderedDescending){
			
			UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Invalid date"
																message:@"Alarm can not be set" 
															   delegate:nil 
													  cancelButtonTitle:@"Ok"
													  otherButtonTitles:nil];	
			[alertview show];
			[alertview release];
			
			if (al2 == 1) {
				for (int i=0;i<[events count];i++) {
					if ([[[events objectAtIndex:i] eventTitle] isEqual:event.eventTitle]) {
						if ([[events objectAtIndex:i] idcod] == event.idcod) {
							[events removeObjectAtIndex:i];
						}
					}
				}
			}
			
			
			event.alarmbut = @"bb";
			event.alarme = @"None";
			if(al2 != 0){
					al2 = 2;
			}
			event.invalid = 1;
			
		}
		else if(result==NSOrderedAscending){
			
			event.alarmbut = [NSString stringWithFormat:@"%@", @"aa"];
			event.alarme = @"1 day before";
			
			NSDate *earlierdate = [event.completdate dateByAddingTimeInterval:-(60*60*24)];
			//NSLog(@"earlierdate = %@", earlierdate);
		
			NSDateFormatter *dateff = [[NSDateFormatter alloc] init];
			[dateff setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
			[dateff setTimeZone:[NSTimeZone localTimeZone]];
			[dateff setDateFormat:@"dd-MM-yyyy-HH:mm a"];
			NSString *data = [NSString stringWithFormat:@"%@", [dateff stringFromDate:earlierdate]];
			//NSLog(@"alarmdata = %@",data);
		
			int day;
			int month;
			int year;
			int hour;
			int minutes;
		
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
		
				//NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
			NSDateComponents *components = [[NSDateComponents alloc] init];
	
			NSLog(@"day = %d", day);  
			NSLog(@"month = %d", month);  
			NSLog(@"year = %d", year);  
			NSLog(@"hour = %d", hour);  
			NSLog(@"minutes = %d", minutes);  
		
			[components setDay:day];
			[components setMonth:month];
			[components setYear:year];
			[components setMinute:minutes];
			[components setHour:hour];
		
			NSDate *myNewDate = [calendar dateFromComponents:components];
			//NSLog(@"myNewDate = %@", myNewDate);
		
			[components release];
		
			[self performSelector:@selector(scheduleNotificationForDate:) withObject:myNewDate];
			event.invalid = 0;
			event.favs = 1;
		
		}
		else{
			
			UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Invalid date"
																message:@"Alarm can not be set" 
															   delegate:nil 
													  cancelButtonTitle:@"Ok"
													  otherButtonTitles:nil];	
			[alertview show];
			[alertview release];
			
			if (al2 == 1) {
				for (int i=0;i<[events count];i++) {
					if ([[[events objectAtIndex:i] eventTitle] isEqual:event.eventTitle]) {
						if ([[events objectAtIndex:i] idcod] == event.idcod) {
							[events removeObjectAtIndex:i];
						}
					}
				}
			}			
			
			event.alarmbut = @"bb";
			event.alarme = @"None";
			if(al2 != 0){
				al2 = 2;
			}
			event.invalid = 1;
		}
		
		if(event.invalid == 1){
			event.invalid = 1;
			
		}		
		
		/*if(al2 != 2){
			[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:event];
			event.favs = 1;
		}*/
	}
}


-(void) scheduleNotificationForDate:(NSDate*)data {
	
	//[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	NSDate *az = [NSDate date];
	
	
	NSDateFormatter *dtf = [[[NSDateFormatter alloc] init] autorelease];
	[dtf setDateFormat:@"dd MMM yyyy hh:mm a"];
	NSString *str = [dtf stringFromDate:az];
	NSString *str2 = [dtf stringFromDate:data];
	NSLog(@"az = %@", str);
	NSLog(@"data = %@", str2);
	
	
	NSComparisonResult result = [az compare:data];
	
	if(result==NSOrderedDescending){	
		UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Invalid date"
															message:@"Alarm can not be set with 1 day before this event" 
														   delegate:nil 
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];	
		[alertview show];
		[alertview release];	
		
		event.alarme = @"None";
		event.alarmbut = [NSString stringWithFormat:@"%@", @"bb"];
	}
	else {

		event.alarmbut = [NSString stringWithFormat:@"%@", @"aa"];
		
		UIApplication *app = [UIApplication sharedApplication];

		UILocalNotification *localNotification = [[UILocalNotification alloc] init];
	
		localNotification.fireDate = data;
		NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
	
		localNotification.timeZone = [NSTimeZone localTimeZone];
	
		localNotification.alertBody = [NSString stringWithFormat:@"%@", event.eventTitle];
		//NSLog(@"%d", [localNotification.alertBody length]);
	
		localNotification.alertAction = [NSString stringWithFormat:@"i Love GC12"]; 
		localNotification.hasAction = YES;
	
		localNotification.soundName = UILocalNotificationDefaultSoundName;
		localNotification.applicationIconBadgeNumber = -1;
	
		NSDateFormatter *timef = [[[NSDateFormatter alloc] init] autorelease];
		[timef setDateFormat:@"dd MMM yyyy hh:mm a"];
		NSNumber *numb = [NSNumber numberWithInt:event.idcod];
		NSLog(@"idcode: %d", event.idcod);
		
		NSDictionary *infoDict = [NSDictionary dictionaryWithObject:numb forKey:@"time"];
		localNotification.userInfo = infoDict;
	
		[app scheduleLocalNotification:localNotification];
		[localNotification release];
	}
	
	if(al2 != 2){
		[[NSNotificationCenter defaultCenter] postNotificationName:@"CategAlarm" object:event];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTable" object:event];
		event.favs = 1;
	}	
}


- (void)Alarm:(UIButton *)sender {
	
	/*[favs setSelected:NO];
	[map setSelected:NO];
	[alarm setSelected:YES];
	[share setSelected:NO];*/
	
	al2 = 1;
	
	
	
	for (int i=0;i<[events count];i++) {
		if ([[[events objectAtIndex:i] eventTitle] isEqual:event.eventTitle]) {
			if ([[events objectAtIndex:i] idcod] == event.idcod) {
				event.favs = 1;
				if ([[events objectAtIndex:i] invalid] == 1) {
					event.invalid = 1;
				}
				if ([[[events objectAtIndex:i] alarmbut] isEqual:@"aa"]) {
					event.alarmbut = @"aa";
				}
			}
		}
	}
	
	
	if (event.favs == 1){
		if ([event.alarmbut isEqualToString:@"aa"]) {
			if (event.invalid != 1) {
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																message:@"This event already has an alarm!"
															   delegate:nil 
													  cancelButtonTitle:@"Ok"
													  otherButtonTitles:nil];	
				[alertview show];
				[alertview release];
			}
			else {
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																	message:@"Invalid date"
																   delegate:nil 
														  cancelButtonTitle:@"Ok"
														  otherButtonTitles:nil];	
				[alertview show];
				[alertview release];				
			}

		}
		else {
			if (event.invalid == 1) {
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																	message:@"Invalid date"
																   delegate:nil 
														  cancelButtonTitle:@"Ok"
														  otherButtonTitles:nil];	
				[alertview show];
				[alertview release];
			}
			else {
				[events addObject:event];
				alert2 = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Add alarm for %@ ?", event.eventTitle] 
													message:@"You will be notified 1 day before this event starts" 
												   delegate:self 
										  cancelButtonTitle:@"No"
										  otherButtonTitles:@"Yes", nil];
				
				[alert2 show];
			}
		}
	}
	else {
		int c = 0;
		for(int o = 0;o<[events count];o++){
			if([[[events objectAtIndex:o] eventTitle] isEqualToString:event.eventTitle]){
				if ([[events objectAtIndex:o] idcod] == event.idcod) {
					c = 1;
				}
			}
		}
		
		if(c == 0){
			if(event.invalid != 1){
				[events addObject:event];
				alert2 = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Add alarm for %@ ?", event.eventTitle] 
												message:@"You will be notified 1 day before this event starts" 
											   delegate:self 
									  cancelButtonTitle:@"No"
									  otherButtonTitles:@"Yes", nil];
			
				[alert2 show];
			}
			else {
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																	message:@"Invalid date"
																   delegate:nil 
														  cancelButtonTitle:@"Ok"
														  otherButtonTitles:nil];	
				[alertview show];
				[alertview release];
			}

		}
		else {
			if([event.alarmbut isEqualToString:@"aa"]) {
				UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																	message:@"This event already has an alarm!"
																   delegate:nil 
														  cancelButtonTitle:@"Ok"
														  otherButtonTitles:nil];	
				[alertview show];
				[alertview release];
			}	
			else {
				if (event.invalid == 1) {
					UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
																		message:@"Invalid date"
																	   delegate:nil 
															  cancelButtonTitle:@"Ok"
															  otherButtonTitles:nil];	
					[alertview show];
					[alertview release];
				}
				else {
					alert2 = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Add alarm for %@ ?", event.eventTitle] 
														message:@"You will be notified 1 day before this event starts" 
													   delegate:self 
											  cancelButtonTitle:@"No"
											  otherButtonTitles:@"Yes", nil];
					
					[alert2 show];
				}
			}
		}
	}
}



- (void)Share:(UIButton *)sender {
	
	isDealloc = NO;
	
	/*[favs setSelected:NO];
	[map setSelected:NO];
	[alarm setSelected:NO];
	[share setSelected:YES];*/
	
		//self.tabBarController.tabBar.hidden = YES;
	
	action = [[UIActionSheet alloc] initWithTitle:nil
								delegate:self
					   cancelButtonTitle:@"Cancel"
				  destructiveButtonTitle:nil
					   otherButtonTitles:@"Facebook", @"Twitter", @"Email", nil];
	
		//[action showInView:self.view];
	[action showInView:self.parentViewController.tabBarController.view];
	
	
		// Create the item to share (in this example, a url)
	/*NSString *url = @"ShareKit is Awesome!";
	SHKItem *item = [SHKItem text:url];
	
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	// Display the action sheet
	[actionSheet showFromToolbar:self.navigationController.toolbar];*/
}
// --------
- (void) demo: (NSString *) myString
{
    URLShortener* shortener = [[URLShortener new] autorelease];
    if (shortener != nil) {
        shortener.delegate = self;
       // shortener.login = @"o_4f2dbhtc8h";
       // shortener.key = @"R_9003d4fcca785f4b1737d5060e71a906";
        //shortener.url = [NSURL URLWithString: @"http://stefan.arentz.ca"];
        shortener.url = [NSURL URLWithString: myString];
        [shortener execute];
    }
}

/**
 * URLShortener delegate method that will be called when the URL was succesfully shortened.
 */

- (void) shortener: (URLShortener*) shortener didSucceedWithShortenedURL: (NSURL*) shortenedURL
{
    shortURL = [shortenedURL absoluteString];
    
    NSDateFormatter *dt = [[NSDateFormatter alloc] init];
    NSDateFormatter *tm = [[NSDateFormatter alloc] init];
    [dt setDateFormat:@"EEEE, dd MMM yyyy"];
    [tm setDateFormat:@"hh:mm a"];	
   
    NSString *twit;
 
     if(event.time == nil){
     
     twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n%@ %@.\nSent from I love GC on iPhone.",
     event.eventTitle, [dt stringFromDate:event.date], shortURL];
     
     
     }
     else{
     twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n%@ %@\n%@.\nSent from I love GC.",
     event.eventTitle, [dt stringFromDate:event.date],
     [tm stringFromDate:event.time], shortURL];
     
     }
     
     SHKItem *item = [SHKItem text:twit];
     
     [SHKTwitter2 shareItem:item];

    
}

/**
 * URLShortener delegate method that will be called when the bit.ly service returned a non-200
 * status code to our request.
 */

- (void) shortener: (URLShortener*) shortener didFailWithStatusCode: (int) statusCode
{

   NSLog(@"shortener: %@ didFailWithStatusCode: %d", self, statusCode);
    
    NSDateFormatter *dt = [[NSDateFormatter alloc] init];
    NSDateFormatter *tm = [[NSDateFormatter alloc] init];
    [dt setDateFormat:@"EEEE, dd MMM yyyy"];
    [tm setDateFormat:@"hh:mm a"];	
    
    NSString *twit;
    
    if(event.time == nil){
        
        twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n%@ .\nSent from I love GC on iPhone.",
                event.eventTitle, [dt stringFromDate:event.date]];
        
        
    }
    else{
        twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n %@ %@.\nSent from I love GC.",
                event.eventTitle, [dt stringFromDate:event.date],
                [tm stringFromDate:event.time]];
        
    }
    
    SHKItem *item = [SHKItem text:twit];
    
    [SHKTwitter2 shareItem:item];
    
    
    
}

/**
 * URLShortener delegate method that will be called when a lower level error has occurred. Like
 * network timeouts or host lookup failures.
 */

- (void) shortener: (URLShortener*) shortener didFailWithError: (NSError*) error
{
    NSLog(@"shortener: %@ didFailWithError: %d", self, [error localizedDescription]);
    
    NSDateFormatter *dt = [[NSDateFormatter alloc] init];
    NSDateFormatter *tm = [[NSDateFormatter alloc] init];
    [dt setDateFormat:@"EEEE, dd MMM yyyy"];
    [tm setDateFormat:@"hh:mm a"];	
    
    NSString *twit;
    
    if(event.time == nil){
        
        twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n%@ .\nSent from I love GC on iPhone.",
                event.eventTitle, [dt stringFromDate:event.date]];
        
        
    }
    else{
        twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n %@ %@.\nSent from I love GC.",
                event.eventTitle, [dt stringFromDate:event.date],
                [tm stringFromDate:event.time]];
        
    }
    
    SHKItem *item = [SHKItem text:twit];
    
    [SHKTwitter2 shareItem:item];
    

}

// -------
-(void)actionSheet:(UIActionSheet *)action clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{		
		NSDateFormatter *dt = [[NSDateFormatter alloc] init];
		NSDateFormatter *tm = [[NSDateFormatter alloc] init];
		[dt setDateFormat:@"EEEE, dd MMM yyyy"];
		[tm setDateFormat:@"hh:mm a"];	
		
		NSString *fb;
		if(event.time == nil){
			fb = [NSString stringWithFormat:@"\nHey check out what's happening!\n%@ on %@.",
					event.eventTitle, [dt stringFromDate:event.date]];
			
		}
		else{
			fb = [NSString stringWithFormat:@"\nHey check out what's happening!\n%@ on %@ %@.",
					event.eventTitle, [dt stringFromDate:event.date],
					[tm stringFromDate:event.time]];
		}
		
		SHKItem *item = [SHKItem text:fb];
	
		[SHKFacebook shareItem:item];
		
		
	}
	else if (buttonIndex == 1)
	{		
		
		NSDateFormatter *dt = [[NSDateFormatter alloc] init];
		NSDateFormatter *tm = [[NSDateFormatter alloc] init];
		[dt setDateFormat:@"EEEE, dd MMM yyyy"];
		[tm setDateFormat:@"hh:mm a"];	
		
		NSString *twit;
        
        [self demo: event.web];
        
	
	}
	else if (buttonIndex == 2)
	{
		isFriendsMail = YES;
		Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));		
		
		if (mailClass != nil) {
			if ([mailClass canSendMail]) {
				[self performSelector:@selector(displayMailComposerSheet)];
			}
			else {
				UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"This device is not configured to send emails" 
													message:nil 
												   delegate:self 
										  cancelButtonTitle:@"Ok"
										  otherButtonTitles:nil];
				
				[alert3 show];
				[alert3 release];
			}
		}
		else	{
			UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"This device is not configured to send emails" 
												message:nil 
											   delegate:self 
									  cancelButtonTitle:@"Ok"
								      otherButtonTitles:nil];
			
			[alert4 show];
			[alert4 release];
		}	
	}	
	else {
		isDealloc = YES;
	}

}



-(void)displayMailComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	if (isFriendsMail == YES) {
		NSDateFormatter *dt2 = [[NSDateFormatter alloc] init];
		[dt2 setDateFormat:@"EEEE, dd MMM yyyy"];
		NSDateFormatter *tm2 = [[NSDateFormatter alloc] init];
		[tm2 setDateFormat:@"hh:mm a"];	

		if(event.time == nil){
			[picker setSubject:[NSString stringWithFormat:@"%@ %@", event.eventTitle, [dt2 stringFromDate:event.date]]];
		}
		else{
			[picker setSubject:[NSString stringWithFormat:@"%@ %@ %@", event.eventTitle, [dt2 stringFromDate:event.date], [tm2 stringFromDate:event.time]]];
		}
	
	
	
		// Set up recipients
		//NSArray *toRecipients = [NSArray arrayWithObject:event.email]; 
		//NSArray *ccRecipients = [NSArray arrayWithObjects:nil]; 
		//NSArray *bccRecipients = [NSArray arrayWithObject:nil]; 
	
		//[picker setToRecipients:toRecipients];
		//[picker setCcRecipients:ccRecipients];	
		//[picker setBccRecipients:bccRecipients];
	
		// Attach an image to the email
		//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
	
		//[NSData dataWithContentsOfFile:path];
        NSLog(@"%@",event.eventImage2);
		NSData *myData = UIImagePNGRepresentation(event.eventImage2);
		[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"iLoveCG.png"];
	
		// Fill out the email body text
		NSDateFormatter *dt = [[NSDateFormatter alloc] init];
		[dt setDateFormat:@"EEEE, dd MMM yyyy"];
		NSDateFormatter *tm = [[NSDateFormatter alloc] init];
		[tm setDateFormat:@"hh:mm a"];
		NSString *emailBody;
		if(event.time == nil){
			emailBody = [NSString stringWithFormat:@"<html><body><p>Hey check this out! %@<p> <p> <b>Event Name:</b>  %@ <br><b>Date:</b>  %@<br><b>Location:</b>  %@<br></p><p><b>Description:</b>  %@</p> <p><b>Web:</b>  %@<br><b>Email:</b>  %@<br><b>Phone:</b>  %@</p><p>%@ %@</p></body></html>", 
							   event.eventTitle, event.eventTitle, [dt stringFromDate:event.date],
							   event.location, event.description, event.web, event.email, event.phone,
                         @"Sent from I love GC on iPhone. <br><a href='http://itunes.apple.com/us/app/i-love-gold-coast/id528460631?ls=1&mt=8'>Download the i Love GC app from", 
                         @"the App Store now!</a>"];	
		}
		else{
			emailBody = [NSString stringWithFormat:@"<html><body><p>Hey check this out! %@<p> <p> <b>Event Name:</b>  %@<br><b>Date:</b>  %@<br><b>Time:  </b>%@<br><b>Location:</b>  %@<br></p><p><b>Description:</b>  %@<br></p> <p><b>Web:</b>  %@<br><b>Email:</b>  %@<br><b>Phone:</b>  %@<br></p><p>%@ %@</p></body></html>",
            				   event.eventTitle, event.eventTitle, [dt stringFromDate:event.date], [tm stringFromDate:event.time],
							   event.location, event.description, event.web, event.email, event.phone,
							   @"Sent from I love GC on iPhone. <br><a href='http://itunes.apple.com/us/app/i-love-gold-coast/id528460631?ls=1&mt=8'>Download the i Love GC app from", 
							   @"the App Store now!</a>"];		
		}
        //emailBody = [NSString stringWithFormat:@"Hey check this out! %@\n\nEvent Name:  %@\nDate:  %@\nTime:  %@\nLocation:  %@\n\nDescription:  %@\n\nWeb:  %@\nEmail:  %@\nPhone:  %@\n\n%@\n%@", 
        
		[picker setMessageBody:emailBody isHTML:YES];
		
		[self presentModalViewController:picker animated:YES];
	}
	else 
	{
		if(![event.email isEqualToString:@""]){
			NSArray *toRecipients = [NSArray arrayWithObject:event.email]; 
			[picker setToRecipients:toRecipients];
			[picker setSubject:[NSString stringWithFormat:@"%@ %@", event.eventTitle, @"enquiry"]];
			
			[self presentModalViewController:picker animated:YES];
		}
		else {
			UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:nil 
															 message:@"No email address for this event"
															delegate:nil 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert4 show];
			[alert4 release];
		}
	}

	[picker release];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller 
		  didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			feedbackMsg = [NSString stringWithFormat:@"Mail sending canceled"];
			UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:nil 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert4 show];
			[alert4 release];
			break;
		case MFMailComposeResultSaved:
			feedbackMsg = [NSString stringWithFormat:@"Mail saved"];
			UIAlertView *alert5 = [[UIAlertView alloc] initWithTitle:feedbackMsg
															 message:nil 
															delegate:nil 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert5 show];
			[alert5 release];
			break;
		case MFMailComposeResultSent:
			feedbackMsg = [NSString stringWithFormat:@"Mail sent"];
			UIAlertView *alert6 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:nil 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert6 show];
			[alert6 release];
			break;
		case MFMailComposeResultFailed:
			feedbackMsg = [NSString stringWithFormat:@"Mail sending failed"];
			UIAlertView *alert7 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:nil 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert7 show];
			[alert7 release];
			break;
		default:
			feedbackMsg = [NSString stringWithFormat:@"Mail not sent"];
			UIAlertView *alert8 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:nil 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert8 show];
			[alert8 release];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


- (void)ShowMap:(UIButton *)sender{
	
	isDealloc = NO;
    ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
    app.showMapClicked = YES;
	
	/*ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	UITabBarController *tabBarController = app.aTabBarController;
	tabBarController.selectedIndex = 2;*/

	/*[favs setSelected:NO];
	[map setSelected:YES];
	[alarm setSelected:NO];
	[share setSelected:NO];	*/
	
	if (event.latitude == 200) {
	
		UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
														message:@"Event location unknown"
													   delegate:nil 
											  cancelButtonTitle:@"Ok"
											  otherButtonTitles:nil];	
		[alertview show];
		[alertview release];	
	
	}
	else {
		
		Maps *m = [[[Maps alloc] initWithNibName:@"Maps" bundle:nil]autorelease];
		m.eve = event;
		m.title = event.eventTitle;
		
		if (fromMaps == YES) {
			m.fromMaps = YES;
		}		
		
		[self.navigationController pushViewController:m animated:YES];
		//[m release];
	}

	
		//NSString *str = [NSString stringWithFormat:@"%f,%f", event.latitude, event.location];
	/*if (event.latitude != 200) {
		[[UIApplication sharedApplication] openURL:
		 [NSURL URLWithString:
		  [NSString stringWithFormat:@"http://maps.google.com/maps?q=%f,%f", event.latitude, event.longitude]]];
	}
	else {
		UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:nil 
														 message:@"Unknown Location" 
														delegate:nil 
											   cancelButtonTitle:@"Ok"
											   otherButtonTitles:nil];
		
		[alert3 show];
		[alert3 release];
	}*/
}

- (void)Emailb:(UIButton *)sender
{
	isFriendsMail = NO;
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));		
	
	
	if (mailClass != nil) {

		if ([mailClass canSendMail]) {
			[self performSelector:@selector(displayMailComposerSheet)];
		}
		else {
			UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"This device is not configured to send emails" 
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert3 show];
			[alert3 release];
		}
	}
	else	{
		UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"This device is not configured to send emails" 
														 message:nil 
														delegate:self 
											   cancelButtonTitle:@"Ok"
											   otherButtonTitles:nil];
		
		[alert4 show];
		[alert4 release];
	}		

	
	/*if (![MFMailComposeViewController canSendMail]) {
		UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"This device can not send emails. Please set up a valid email account." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
		return;
	}

	MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
	[mailController setMessageBody:@"write message here" isHTML:false];
	NSMutableArray *ary = [[NSMutableArray alloc] init];
	[ary addObject:event.email];
	[mailController setToRecipients:ary];
	mailController.mailComposeDelegate = self;
	[mailController.navigationBar setHidden:NO];
	mailController.title = @"Email";
	mailController.navigationBar.barStyle = UIBarStyleBlack;
	[self presentModalViewController:mailController animated:YES];
	[ary release];
	[mailController release];
	
	/*Email *em = [[Email alloc] initWithNibName:@"Email" bundle:nil];
	
		//em.eve = event;
	
	[self.navigationController pushViewController:em animated:YES];
	
	em.title = @"Email";*/
	
}


- (void)Phoneb:(UIButton *)sender
{
	if ([event.web isEqualToString:@""]) {
		UIAlertView *inweb = [[UIAlertView alloc] initWithTitle:nil
											message:@"There is no web page for this event!" 
										   delegate:nil
								  cancelButtonTitle:@"Ok"
								  otherButtonTitles:nil];
		
		[inweb show];
		[inweb release];
	}
	else {

		Web *webView = [[Web alloc] init];
	
		/*int c = -1;
	
		ILoveGCAppDelegate *app = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
		for (int i=0;i<[app.allPages count];i++) {
			if ([[app.allPages objectAtIndex:i] isEqualToString:event.web]) {
				c = i;
			}
		}
	
		if (c!=-1) {
			webView.url = [app.allPages objectAtIndex:c];
			webView.i = c;
		}
		else {
			[app.allPages addObject:event.web];
			webView.url = event.web;
			webView.i = [app.allPages count]-1;
		}*/
	
		webView.url = event.web;
		[self.navigationController presentModalViewController:webView animated:YES];
	
		[webView release];
	}
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[super viewDidUnload];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ObjectAdded" object:nil];
}



- (void)dealloc {
	
	[location release];
	//[cost2 release];
	[date release];
	[email2 release];
	[phone2 release];
	[web2 release];
	[events release];
	[time release];
	//[feedbackMsg release];
	
	[phoneb release];
	[cat release];
	[notifications release];
	[action release];
	[emailb release];
	[alert release];
	[alert2 release];
	[textview release];
	[alarms release];
	[dateFormatter release];
	[timeFormatter release];
	[event release];
	
	[eventtitle release];
	[eventlocation release];
	[eventtime release];
	[eventdate release];
	//[cost release];
	[email release];
	[phone release];
	[web release];
	
	[map release];
	[favs release];
	[share release];
	[alarm release];
	
	[eventimage release];
	[scrollView release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"Notifications" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ObjectAdded" object:nil];
	
    [super dealloc];
}


@end
