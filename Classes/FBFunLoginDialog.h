//
//  FBFunLoginDialog.h
//  MyProject
//
//  Created by ANDREI A on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FBFunLoginDialogDelegate
- (void)accessTokenFound:(NSString *)accessToken;
- (void)displayRequired;
- (void)closeTapped;
@end

@interface FBFunLoginDialog : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_apiKey;
    NSString *_requestedPermissions;
    id <FBFunLoginDialogDelegate> _delegate;
	
	UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *apiKey;
@property (copy) NSString *requestedPermissions;
@property (assign) id <FBFunLoginDialogDelegate> delegate;

- (id)initWithAppId:(NSString *)apiKey 
requestedPermissions:(NSString *)requestedPermissions 
		   delegate:(id<FBFunLoginDialogDelegate>)delegate;

- (void)login;
- (void)logout;

-(void)checkForAccessToken:(NSString *)urlString;
-(void)checkLoginRequired:(NSString *)urlString;

@end
