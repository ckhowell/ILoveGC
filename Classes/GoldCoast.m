//
//  GoldCoast.m
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoldCoast.h"
#import "ILoveGCAppDelegate.h"


@implementation GoldCoast

@synthesize web, activityView, img;


-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    img.backgroundColor = [UIColor blackColor];
	[web addSubview:img];
	
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIView *view2 = [[UIView alloc] initWithFrame: CGRectMake( (width - 100) / 2.0 , (height - 82 - 100) / 2.0, 100, 100)];
	view2.backgroundColor = [UIColor whiteColor];
	view2.alpha = 0.2;
	view2.layer.cornerRadius = 10;
	view2.layer.masksToBounds = YES;
	[img addSubview:view2];
	[view2 release];
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    activityView.center = CGPointMake(width / 2.0, (height - 82) / 2.0);	
	[web addSubview: activityView];
	[activityView startAnimating];	
	
	/*NSURL *URL = [NSURL URLWithString:@"http://www.visitgoldcoast.com/"];
	[[UIApplication sharedApplication] openURL:URL];*/
	
	NSURL *url = [NSURL URLWithString:@"http://www.visitgoldcoast.com"];	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[web loadRequest:request];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {   
	[activityView setHidden:YES];
	[activityView stopAnimating];
	[img removeFromSuperview];
}



- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	[img release];
	[web release];
    [super dealloc];
}


@end
