//
//  TwitterRequest.h
//  MyProject
//
//  Created by ANDREI A on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TwitterRequest : NSObject {

	NSString		*username;
	NSString		*password;
	NSMutableData   *receivedData;
	NSURLRequest	*theRequest;
	NSURLConnection *theConnection;
	id				 delegate;
	SEL				 callback;
	SEL				 errorCallback;
	
}

@property(nonatomic, retain) NSString	   *username;
@property(nonatomic, retain) NSString	   *password;
@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;

-(void)friends_timeline:(id)requestDelegate requestSelector:(SEL)requestSelector;
-(void)request:(NSURL *) url;


@end
