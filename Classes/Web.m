//
//  Web.m
//  MyProject
//
//  Created by user on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Web.h"
#import "ILoveGCAppDelegate.h"


@implementation Web

@synthesize webView, toolBar, navBar, url, activityView, img, i, navItem;
@synthesize fButton, bButton, safari, alertview, tim;

BOOL ended =NO;
-(void)viewDidLoad {
	[super viewDidLoad];
	
	ended = NO;
	
	img = [[UIImageView alloc] initWithFrame:CGRectMake(110, 130, 100, 100)];
	img.backgroundColor = [UIColor blackColor];
	img.alpha = 0.4;
	img.layer.cornerRadius = 10;
	img.layer.masksToBounds = YES;
	[webView addSubview:img];
    
    webView.scalesPageToFit = YES;
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin);
    
    
    activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	activityView.center = CGPointMake(160,180);
	[webView addSubview: activityView];
	[activityView startAnimating];
    
	
	webView.backgroundColor = [UIColor clearColor];
	
	URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL: URL];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest: request delegate: self];
  
	//tim = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(webDidNotLoad) userInfo:nil repeats:NO];
	
	NSMutableArray* buttons = [[NSMutableArray alloc] init];	
	bButton = [[[UIBarButtonItem alloc]
								   initWithImage:[UIImage imageNamed:@"Back.png"]
								   style:UIBarButtonItemStylePlain
								   target: self
								   action: @selector(GoBackword)] autorelease];
	fButton = [[[UIBarButtonItem alloc]
								   initWithImage:[UIImage imageNamed:@"Forward.png"]
								   style:UIBarButtonItemStylePlain
								   target: self
								   action: @selector(GoForword)] autorelease];	
	safari = [[[UIBarButtonItem alloc]
								 initWithImage:[UIImage imageNamed:@"Open_Safari.png"]
								 style:UIBarButtonItemStylePlain
								 target: self
								 action: @selector(OpenSafari)] autorelease];	
	
	UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	[buttons insertObject:bButton atIndex:0];
	[buttons insertObject:fButton atIndex:1];
	[buttons insertObject:flex atIndex:2];
	[buttons insertObject:safari atIndex:3];
	
	[self.toolBar setItems:buttons animated:NO];
	
	fButton.enabled = NO;
	bButton.enabled = NO;
	safari.enabled = NO;
	
	[buttons release];
	[flex release];
}



-(void)webViewDidStartLoad:(UIWebView *)webView {
	
	[self.webView addSubview:img];
	[activityView startAnimating];	
}

	
- (void)webViewDidFinishLoad:(UIWebView *)webView {   
	
	safari.enabled = YES;
	
	if(self.webView.canGoBack == YES){
		bButton.enabled = YES;
	}
	else {
		bButton.enabled = NO;
	}
	
	if(self.webView.canGoForward == YES){
		fButton.enabled = YES;
	}
	else {
		fButton.enabled = NO;
	}
	
	[tim invalidate];
	tim = nil;
	
	//isURLValid = YES;
	
	NSString *theTitle=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	self.navItem.title = theTitle;
	
	[activityView stopAnimating];	
	[img removeFromSuperview];
} 

/*
- (void)webDidNotLoad {   
	
	ended = YES;
	
	//if (isURLValid != YES) {
		[activityView stopAnimating];	
		[img removeFromSuperview];
	
		UIAlertView *nourl = [[UIAlertView alloc] initWithTitle:nil
														message:@"Could not connect to this URL"
													   delegate:nil 
											  cancelButtonTitle:@"Ok"
											  otherButtonTitles:nil];	
		[nourl show];
		[nourl release];
	//}
} 
*/

- (void) viewDidDisappear:(BOOL)animated
{
	if(ended == NO)
	{      NSLog(@"Invalidat");
		[tim invalidate];
		tim = nil;
	}
}

-(IBAction)GoBack{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)GoForword{
	
	[webView goForward];
}

-(void)GoBackword{
	
	[webView goBack];
}

-(void)RefreshPage{
	
	[activityView startAnimating];	
	[webView addSubview:img];
	
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
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
       
		NSURL *URL = [NSURL URLWithString:url];
		[[UIApplication sharedApplication] openURL:URL];
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

//------
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"Error :%@",&error);
    [activityView stopAnimating];
    [img removeFromSuperview];
    
    NSLog(@"Could not connect to the server");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK." otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    responseStatusCode = [httpResponse statusCode];
    NSLog(@"Response status code %d", responseStatusCode);    
  
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [activityView stopAnimating];	
    [img removeFromSuperview];
    
    if(responseStatusCode == 200)
    {
        [webView loadRequest:[NSURLRequest requestWithURL:URL]];
    }
    else
    {
        ended = YES;
        
        //if (isURLValid != YES) {
		
        
		UIAlertView *nourl = [[UIAlertView alloc] initWithTitle: @"Error"
														message:@"Error connectiong to this URL"
													   delegate:nil 
											  cancelButtonTitle:@"Ok"
											  otherButtonTitles:nil];	
		[nourl show];
		[nourl release];
    }
    
 
}
- (void)dealloc {
	
	[navItem release];
	[webView release];
	[toolBar release];
	[navBar release];
	
	[url release];
	
	[super dealloc];
}


@end
