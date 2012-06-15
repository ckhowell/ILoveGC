

#import "MFacebook.h"


@implementation MFacebook

@synthesize web, activityView;


-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
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
	[web release];
    [super dealloc];
}


@end
