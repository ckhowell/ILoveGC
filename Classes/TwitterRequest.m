

#import "TwitterRequest.h"


@implementation TwitterRequest

@synthesize username;
@synthesize password;
@synthesize receivedData;
@synthesize delegate;
@synthesize callback;
@synthesize errorCallback;



-(void)friends_timeline:(id)requestDelegate requestSelector:(SEL)requestSelector{
		// Set the delegate and selector
	self.delegate = requestDelegate;
	self.callback = requestSelector;
		// The URL of the Twitter Request we intend to send
	NSURL *url = [NSURL URLWithString:@"http://twitter.com/statuses/friends_timeline.xml"];
	[self request:url];
}

-(void)request:(NSURL *) url {
	theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {

		receivedData=[[NSMutableData data] retain];
	} else {
			
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
		//NSLog(@"challenged %@",[challenge proposedCredential] );
	
	if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:[self username]
                                                 password:[self password]
                                              persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
		
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];

		NSLog(@"Invalid Username or Password");
    }
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
		// release the connection, and the data object
    [connection release];
		// receivedData is declared as a method instance elsewhere
    [receivedData release];
	
	[theRequest release];
	
		// inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	if(errorCallback) {
		[delegate performSelector:errorCallback withObject:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
		// do something with the data
	
	if(delegate && callback) {
		if([delegate respondsToSelector:self.callback]) {
			[delegate performSelector:self.callback withObject:receivedData];
		} else {
			NSLog(@"No response from delegate");
		}
	} 
	
		// release the connection, and the data object
	[theConnection release];
    [receivedData release];
	[theRequest release];
}



- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    
  
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
    [super dealloc];
}


@end
