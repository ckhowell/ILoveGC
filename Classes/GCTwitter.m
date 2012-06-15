//
//  GCTwitter.m
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCTwitter.h"
#import "SHKTwitter.h"
#import "AppEvents.h"

@implementation GCTwitter

@synthesize app, share, titleLb;


-(void)viewDidLoad{
	
	titleLb.text = @"Please log in";
	
	[[NSNotificationCenter defaultCenter] addObserver:self
										     selector:@selector(Log:)
											     name:@"LOG" 
											   object:nil];
	
	/*share = [[UIButton buttonWithType:UIButtonTypeCustom] retain]; 
	share.frame = CGRectMake(110, 60, 100, 35);
	share.backgroundColor = [UIColor clearColor];
	[share setBackgroundImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
	[share setBackgroundImage:[UIImage imageNamed:@"gray.png"] forState:UIControlStateHighlighted];
	[share setBackgroundImage:[UIImage imageNamed:@"gray.png"] forState:UIControlStateSelected];
	[share setTitle:@"Share" forState:UIControlStateNormal];
	[share setTitle:@"Share" forState:UIControlStateHighlighted];
	[share setTitle:@"Share" forState:UIControlStateSelected];	
	[share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[share setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[share setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
	[share addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];	
	[self.view addSubview:share];		*/
	
	[super viewDidLoad];

}


- (void)Log:(NSNotification *)notif
{	
	titleLb.text = [notif object];
}


-(void)shareWithTwitter:(UIButton *)sender
{
	n = 1;
	SHKItem *item = nil; 
	[SHKTwitter shareItem:item];
} 


-(void)logout:(UIButton *)sender{
	[SHKTwitter logout];
	titleLb.text = @"Please log in";
	n = 0;
}

-(void)Share:(UIButton *)sender{
	
	if(n == 1){
		NSDateFormatter *dt = [[NSDateFormatter alloc] init];
		NSDateFormatter *tm = [[NSDateFormatter alloc] init];
		[dt setDateFormat:@"EEEE, dd MMM yyyy"];
		[tm setDateFormat:@"hh:mm a"];	
	
		NSString *twit;
		if(app.time == nil){
			twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n%@ %@.\nSent from I love GC on iPhone.",
					app.eventTitle, [dt stringFromDate:app.date], app.web];
		}
		else{
			twit = [NSString stringWithFormat:@"Hey check this out!\n%@\n%@ %@\n%@.\nSent from I love GC on iPhone.",
					app.eventTitle, [dt stringFromDate:app.date],
					[tm stringFromDate:app.time] ,app.web];
		}

		SHKItem *item = [SHKItem text:twit];
	
		[SHKTwitter shareItem:item];
	}
	else{
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You're not logged in"
														message:@"Please log in first" 
													   delegate:nil
											  cancelButtonTitle:@"Ok"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[SHKTwitter logout];	
	[titleLb release];
	[share release];
	[app release];
    [super dealloc];
}


@end
