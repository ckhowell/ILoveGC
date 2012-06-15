//
//  Twitter.h
//  MyProject
//
//  Created by ANDREI A on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ParseOperation.h"


@interface Twitter : UIViewController <UIWebViewDelegate, ParseOperationDelegate, UIScrollViewDelegate> {

	
	UIActivityIndicatorView *activityView;
	UIImageView *img;
	
    // ----- pentru twit
    NSMutableArray *twitFeeds;
    
    
	UIScrollView *scroll;
	UITextView *feedtext;
	
	NSMutableArray   *eventlist;    
	
    NSOperationQueue		*queue;
  
    NSURLConnection         *appListFeedConnection;
    NSMutableData          *appListData;	
    NSString *urlString;
    NSURLConnection *conn;
}


@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIImageView *img;

@property (nonatomic, retain) IBOutlet UITextView *feedtext;
@property (nonatomic, retain) IBOutlet UIScrollView *scroll;

@property (nonatomic, retain) NSMutableArray *eventlist;

@property (nonatomic, retain) NSOperationQueue *queue;

@property (nonatomic, retain) NSURLConnection *appListFeedConnection;
@property (nonatomic, retain) NSMutableData *appListData;


- (void) getFeedsFromUser;
- (void) displayFeeds;

@end
