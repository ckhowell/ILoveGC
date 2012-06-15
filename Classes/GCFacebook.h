//
//  GCFacebook.h
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
	//#import "FBFunLoginDialog.h"
	//#import "FBConnect.h"
	//#import "SHK.h"

typedef enum {
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;


 //<FBFunLoginDialogDelegate, FBRequestDelegate,
										 //FBDialogDelegate,
										 //FBSessionDelegate>
@interface GCFacebook : UIViewController
{
    UIButton *_loginButton;
	UIButton *_shareButton;
    LoginState _loginState;
		//FBFunLoginDialog *loginDialog;
    UIView *_loginDialogView;	
	
	
	UIWebView *web;
	UIActivityIndicatorView *activityView;
	
	NSString *n;
}

@property (nonatomic, retain) IBOutlet UIWebView *web;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

@property (nonatomic, retain) NSString *n;

@property (retain) IBOutlet UIButton *loginButton;
@property (retain) IBOutlet UIButton *shareButton;
	//@property (retain) FBFunLoginDialog *loginDialog;
@property (retain) IBOutlet UIView *loginDialogView;

- (IBAction)loginButtonTapped:(id)sender;
- (IBAction)shareButtonTapped:(id)sender;

@end
