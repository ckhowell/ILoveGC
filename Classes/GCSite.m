//
//  GCSite.m
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCSite.h"
#import "ILoveGCAppDelegate.h"
#import "RequestTwitter.h"


@implementation GCSite

@synthesize web, activityView, img;


-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	img.backgroundColor = [UIColor blackColor];
	//img.alpha = 0.5;
	//img.layer.cornerRadius = 10;
	//img.layer.masksToBounds = YES;
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
	
	[web loadRequest:
	 [NSURLRequest requestWithURL:
	  [NSURL URLWithString:@"http://www.iheartgc.com.au"]]];
	
	 /*NSURL *URL = [NSURL URLWithString:@"http://www.iheartgc.com.au"];
	 [[UIApplication sharedApplication] openURL:URL];*/
}



- (void)webViewDidFinishLoad:(UIWebView *)webView {   
	
	[activityView setHidden:YES];
	[activityView stopAnimating];
	[img removeFromSuperview];	
} 



/*-(IBAction)Connect{
	RequestTwitter *tr = [[RequestTwitter alloc] init];
	tr.username = @"ionutgyn";
	tr.password = @"0720148529";
	[tr friends_timeline:self requestSelector:@selector(friends_timeline_callback:)];
}*/

/*-(void)friends_timeline_callback:(NSData *)data{

	NSString *timeline = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSLog(@"Timeline %@", timeline);
}*/


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
