//
//  Web.h
//  MyProject
//
//  Created by user on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Web : UIViewController <UIWebViewDelegate, UINavigationBarDelegate, UIAlertViewDelegate> {
	
    int responseStatusCode;
    
	UIWebView *webView;
	UIToolbar *toolBar;
	UINavigationBar *navBar;
	UINavigationItem *navItem;
	UIAlertView *alertview;
	
	UIBarButtonItem *fButton;
	UIBarButtonItem *bButton;
	UIBarButtonItem *safari;
	
	UIActivityIndicatorView *activityView;
	UIImageView *img;

	NSString *url;
	
	NSTimer *tim;
    
    NSURL *URL;
	
	int i;
	BOOL permission;
	
	//BOOL isURLValid;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet UIAlertView *alertview;

@property (nonatomic, retain) NSTimer *tim;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *fButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *bButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *safari;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIImageView *img;

@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) int i;

-(IBAction)GoBack;
-(IBAction)GoForword;
-(IBAction)GoBackword;
-(IBAction)RefreshPage;
-(IBAction)OpenSafari;

@end
