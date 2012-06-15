//
//  Facebook.h
//  MyProject
//
//  Created by ANDREI A on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MFacebook : UIViewController {
	
	IBOutlet UIWebView *web;
	UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) UIWebView *web;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

@end
