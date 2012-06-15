//
//  RequestTwitter.h
//  MyProject
//
//  Created by Newro Mac on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RequestTwitter : NSObject {

	NSString *username;
	NSString *password;
	NSMutableData *receivedData;
	NSURLRequest *request;
	NSURLConnection *theconnection;
	id delegate;
	SEL callback;
	SEL errorCallback;
	
	BOOL				isPost;
	NSString			*requestBody;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) id delegate;
@property (nonatomic) SEL callback;
@property (nonatomic) SEL errorCallback;


-(void)friends_timeline:(id)requestDelegate requestSelector:(SEL)requestSelector;
-(void)Request:(NSURL *)url;

-(void)statuses_update:(NSString *)status delegate:(id)requestDelegate requestSelector:(SEL)requestSelector;

@end