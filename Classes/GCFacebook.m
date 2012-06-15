//
//  GCFacebook.m
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCFacebook.h"

@implementation GCFacebook

@synthesize web, activityView, n;

@synthesize loginButton = _loginButton;
@synthesize shareButton = _shareButton;
	//@synthesize loginDialog = loginDialog;
@synthesize loginDialogView = _loginDialogView;
	//@synthesize facebook = _facebook;

-(void) viewDidLoad{
	
	[super viewDidLoad];
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	activityView.center = CGPointMake(160,180);
	
	[web addSubview: activityView];
	[activityView startAnimating];
	
	[web loadRequest:
	 [NSURLRequest requestWithURL:
	  [NSURL   URLWithString:@"http://www.facebook.com"]]];	
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {   
	
	[activityView setHidden:YES];
	[activityView stopAnimating];	
}


/*- (IBAction)loginButtonTapped:(id)sender {
	
		// Create the item to share (in this example, a url)
	NSString *str = [NSString stringWithFormat:@"%@", @""];
	SHKItem *item = [SHKItem text:str];
	
			// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
			// Display the action sheet
	[actionSheet showFromToolbar:self.navigationController.toolbar];
}*/


- (void)accessTokenFound:(NSString *)accessToken {
    NSLog(@"Access token found: %@", accessToken);
    _loginState = LoginStateLoggedIn;
}

- (void)displayRequired {
		//[self.navigationController pushViewController:loginDialog animated:YES];
}


- (IBAction)shareButtonTapped:(id)sender {

}



/*-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	activityView.center = CGPointMake(160,180);
	
	[web addSubview: activityView];
	[activityView startAnimating];
	
	[web loadRequest:
	 [NSURLRequest requestWithURL:
	  [NSURL   URLWithString:@"http://www.facebook.com"]]];
	
	if([n isEqual:@"n"]){
		UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareWithFacebook:)];
		self.navigationItem.rightBarButtonItem = shareButton;
		[shareButton release];
	}
}*/






/*-(void)shareWithFacebook:(UIBarButtonItem *)sender
{
	
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:@"http://mytwitterloginname:mytwitterpassword@twitter.com/statuses/update.xml"] 
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
	
		// The text to post
    NSString *msg = @"testing";
	
		// Set the HTTP request method
    [request setHTTPMethod:@"POST"];
	
    [request setHTTPBody:[[NSString stringWithFormat:@"status = %@", msg] 
                          dataUsingEncoding:NSASCIIStringEncoding]];
	
    NSURLResponse *response;
    NSError *error;
	
    if ([NSURLConnection sendSynchronousRequest:request 
                              returningResponse:&response error:&error] != nil)
        NSLog(@"Posted to Twitter successfully.");
	else 
		NSLog(@"Error posting to Twitter."); 
}*/



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
	
	[n release];
	[web release];
	[super dealloc];
}


@end
