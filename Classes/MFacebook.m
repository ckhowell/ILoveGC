//
//  MFacebook.m
//  MyProject
//
//  Created by ANDREI A on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MFacebook.h"
#import "ILoveGCAppDelegate.h"


@implementation MFacebook

@synthesize web, activityView, img;


-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	img.backgroundColor = [UIColor blackColor];
	[web addSubview:img];
    
    web.scalesPageToFit = YES;
    web.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

   
	//UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(110, 127, 100, 100)];
    UIView *view2 = [[UIView alloc] initWithFrame: CGRectMake( (width - 100) / 2.0 , (height - 82 - 100) / 2.0, 100, 100)];
	view2.backgroundColor = [UIColor whiteColor];
	view2.alpha = 0.2;
	view2.layer.cornerRadius = 10;
	view2.layer.masksToBounds = YES;
	[img addSubview:view2];
	[view2 release];	
	 
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    
    
	//activityView.center = CGPointMake(160,180);
    activityView.center = CGPointMake(width / 2.0, (height - 82) / 2.0);
	[web addSubview: activityView];
	[activityView startAnimating];	
	
	NSURL *fanPageURL = [NSURL URLWithString:@"http://www.facebook.com/ILoveGoldCoast"];
	
	[web loadRequest:[NSURLRequest requestWithURL:fanPageURL]];
	
	//@"http://www.facebook.com/ILoveGoldCoast"
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {   
	
	[activityView setHidden:YES];
	[activityView stopAnimating];	
	[img removeFromSuperview];
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
	[img release];
	[web release];
    [super dealloc];
}


@end
