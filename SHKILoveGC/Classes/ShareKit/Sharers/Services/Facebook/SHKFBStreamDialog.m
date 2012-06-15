//
//  SHKFBStreamDialog.m
//  RIL
//
//  Created by Nathan Weiner on 7/26/10.
//  Copyright 2010 Idea Shower, LLC. All rights reserved.
//

#import "SHKFBStreamDialog.h"
#import "SHK2.h"

@implementation SHKFBStreamDialog

@synthesize theStatus;

- (void)dealloc
{
	[theStatus release];
	[super dealloc];	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView 
{
	[super webViewDidFinishLoad:webView];
	
	if (theStatus)
	{
		// Set the pre-filled status message
		[_webView stringByEvaluatingJavaScriptFromString:
		 [NSString stringWithFormat:@"document.getElementsByName('feedform_user_message')[0].value = decodeURIComponent('%@')",
		  [SHKEncode(theStatus) stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]
		 ]
		];
		NSLog(@"%@", [NSString stringWithFormat:@"document.getElementsByName('feedform_user_message')[0].value = decodeURIComponent('%@')",
					  [SHKEncode(theStatus) stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"]]);
		
		// Make the text field bigger
		[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('feedform_user_message')[0].style.height='100px'"];
	}
}

@end
