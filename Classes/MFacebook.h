//
//  MFacebook.h
//  MyProject
//
//  Created by ANDREI A on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MFacebook : UIViewController <UIWebViewDelegate> {

	UIWebView *web;
	UIActivityIndicatorView *activityView;
	UIImageView *img;
}

@property (nonatomic, retain) IBOutlet UIWebView *web;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIImageView *img;

@end
