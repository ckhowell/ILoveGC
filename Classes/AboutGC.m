//
//  AboutGC.m
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutGC.h"
#import "ILoveGCAppDelegate.h"


@implementation AboutGC

@synthesize b;
@synthesize view1;
@synthesize scrollview;

-(void) viewDidLoad{
	
	[super viewDidLoad];
	[scrollview setContentSize:CGSizeMake(320,884)];
	[self.scrollview addSubview:view1];
	/*self.view.backgroundColor = [UIColor  colorWithPatternImage:[UIImage imageNamed:@"Disclaimer.png"]];
	
	UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 385, 300, 20)];
	l.backgroundColor = [UIColor clearColor];
	l.textAlignment = UITextAlignmentCenter;
	l.font = [UIFont systemFontOfSize:14];
	l.textColor = [UIColor whiteColor];
	l.text = @"Copyright \u00A9 2011 Halfnine Media Pty Limited";
	
	UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 300, 20)];
	l1.backgroundColor = [UIColor clearColor];
	l1.textAlignment = UITextAlignmentCenter;
	l1.font = [UIFont boldSystemFontOfSize:16];
	l1.textColor = [UIColor whiteColor];
	l1.text = @"Version 1.0";
	
	b = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	b.frame = CGRectMake(95,350,130,30);
	b.backgroundColor = [UIColor clearColor];
	[b addTarget:self action:@selector(openHalfnine:) forControlEvents:UIControlEventTouchUpInside];
	
	UILabel *bl = [[UILabel alloc] initWithFrame:CGRectMake(30, 4, 90, 22)];
	bl.backgroundColor = [UIColor clearColor];
	bl.textAlignment = UITextAlignmentLeft;
	bl.font = [UIFont boldSystemFontOfSize:20];
	bl.textColor = [UIColor whiteColor];
	bl.text = @"halfnine";
	[b addSubview:bl];
	
	UILabel *tm = [[UILabel alloc] initWithFrame:CGRectMake(105, 4, 20, 22)];
	tm.backgroundColor = [UIColor clearColor];
	tm.textAlignment = UITextAlignmentLeft;
	tm.font = [UIFont systemFontOfSize:18];
	tm.textColor = [UIColor whiteColor];
	tm.text = @"\u2122";
	[b addSubview:tm];
	
	UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 22, 22)];
	im.image = [UIImage imageNamed:@"logo_button.png"];
	[b addSubview:im];
	
	
	[self.view addSubview:l];
	[self.view addSubview:l1];
	[self.view addSubview:b];*/
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UIImageView *navigationBarView = [[UIImageView alloc] 
									  initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width/2 - 25, self.navigationController.navigationBar.frame.size.height/2 - 10, 
															   71,
															   21)];
    [navigationBarView setImage:[UIImage imageNamed:@"topbar_logo.png"]];
	
    navigationBarView.tag = 1;
    
    
    UIImageView *testImgView = (UIImageView *)[self.navigationController.navigationBar viewWithTag:1];
    
    if ( testImgView != nil )
    {
        NSLog(@"%s yes there is a bg image so remove it then add it so it doesn't double it", __FUNCTION__);
        [testImgView removeFromSuperview];
        
    } else {
        NSLog(@"%s no there isn't a bg image so add it ", __FUNCTION__);
    }
    
    
    
	[self.navigationController.navigationBar addSubview:navigationBarView];
	[navigationBarView release];
}
- (void)openHalfnine:(UIButton *)sender {

	NSURL *URL = [NSURL URLWithString:@"http://www.halfnine.com.au"];
	[[UIApplication sharedApplication] openURL:URL];
}

-(IBAction)OpenSafari{
	
	alertview = [[UIAlertView alloc] initWithTitle:nil
                                           message:@"Do you want to open this page in Safari?"
                                          delegate:self 
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Yes", nil];	
	[alertview show];
	[alertview release];		
}

-(void) alertView:(UIAlertView *)alertview clickedButtonAtIndex:(NSInteger)buttonIndex{
    
	if (buttonIndex == 1) {
        url = @"http://www.halfnine.com.au";
		NSURL *URL = [NSURL URLWithString:url];
		[[UIApplication sharedApplication] openURL:URL];
	}
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
    [super dealloc];
	
	[b release];
}


@end
