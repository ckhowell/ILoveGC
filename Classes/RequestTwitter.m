//
//  RequestTwitter.m
//  MyProject
//
//  Created by Newro Mac on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RequestTwitter.h"


@implementation RequestTwitter


@synthesize username, password, receivedData, delegate, callback, errorCallback;


-(void)friends_timeline:(id)requestDelegate requestSelector:(SEL)requestSelector
{
	isPost = NO;
	
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	
	NSURL *url = [NSURL URLWithString:@"http://twitter.com/statuses/home_timeline/ionutgyn.xml"];
	[self Request:url];
}


-(void)statuses_update:(NSString *)status delegate:(id)requestDelegate requestSelector:(SEL)requestSelector; {
	isPost = YES;
	// Set the delegate and selector
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	// The URL of the Twitter Request we intend to send
	NSURL *url = [NSURL URLWithString:@"http://twitter.com/statuses/update.xml"];
	requestBody = [NSString stringWithFormat:@"status=%@",status];
	[self Request:url];
}


-(void)Request:(NSURL *)url{

	request = [[NSMutableURLRequest alloc] initWithURL:url];
	
	/*if(isPost) {
		NSLog(@"ispost");
		[request setHTTPMethod:@"GET"];
		[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[request setHTTPBody:[requestBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
		[request setValue:[NSString stringWithFormat:@"%d",[requestBody length] ] forHTTPHeaderField:@"Content-Length"];
	}	*/
	
	theconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if(theconnection){
		receivedData = [[NSMutableData data] retain];
	}
	else{
		//download could not be made
	}
}


-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if([challenge previousFailureCount] == 0){
		NSURLCredential *credential = [NSURLCredential credentialWithUser:@"ionutgyn"
																 password:@"0720148529"
															  persistence:NSURLCredentialPersistenceNone];
		[[challenge sender] useCredential:credential
			   forAuthenticationChallenge:challenge];
		[credential release];	
	}
	else {
		[[challenge sender] cancelAuthenticationChallenge:challenge];
		NSLog(@"invalid username and password");
	}
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

	[receivedData setLength:0];
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	
	[receivedData appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	
	[theconnection release];
	[receivedData release];
	[request release];
	
	NSLog(@"Connection faild! Error - %@ %@",
		  [error localizedDescription],
		  [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	if(errorCallback){
		[delegate performSelector:errorCallback withObject:error];
	}
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	
	if(delegate && callback){
		if ([delegate respondsToSelector:self.callback]) {
			[delegate performSelector:self.callback withObject:receivedData];
		}
		else {
			NSLog(@"No response from delegate");
		}
	}
	
	[theconnection release];
	[receivedData release];
	[request release];
}


- (void)dealloc {
    [super dealloc];
}


@end
