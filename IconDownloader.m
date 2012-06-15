

#import "IconDownloader.h"
#import "AppEvents.h"

#define kAppIconHeight 48
#define kIconHeight 200
#define kIconWidth 285


@implementation IconDownloader

@synthesize appRecord;
@synthesize indexPathInTableView;
@synthesize delegate;
@synthesize activeDownload;
@synthesize imageConnection;

#pragma mark

- (void)dealloc
{
    [appRecord release];
    [indexPathInTableView release];
    
    [activeDownload release];
    
    [imageConnection cancel];
    [imageConnection release];
    
    [super dealloc];
}

- (void)startDownload
{
    self.activeDownload = [NSMutableData data];
		// alloc+init and start an NSURLConnection; release on completion/failure
	
    NSLog(@"IMAGES : %@",appRecord.imageURLString);
    
	if(![appRecord.imageURLString isEqualToString:@""]){
		NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:
								 [NSURLRequest requestWithURL:
								  [NSURL URLWithString:appRecord.imageURLString]] delegate:self];
		
		self.imageConnection = conn;
		[conn release];
	}
}

- (void)cancelDownload
{
    [self.imageConnection cancel];
    self.imageConnection = nil;
    self.activeDownload = nil;
}


#pragma mark -
#pragma mark Download support (NSURLConnectionDelegate)

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.activeDownload appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
		// Clear the activeDownload property to allow later attempts
	NSLog(@"%@", error);
    self.activeDownload = nil;
    
		// Release the connection now that it's finished
    self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
		// Set appIcon and clear temporary data/image
    UIImage *image = [[UIImage alloc] initWithData:self.activeDownload];
	UIImage *image2 = [[UIImage alloc] initWithData:self.activeDownload];
    
	/*if (image.size.width != kAppIconHeight && image.size.height != kAppIconHeight)
	{
        CGSize itemSize = CGSizeMake(kAppIconHeight, kAppIconHeight);
		UIGraphicsBeginImageContext(itemSize);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[image drawInRect:imageRect];
		self.appRecord.eventImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
    }
    else
    {
        self.appRecord.eventImage = image;
	}*/
	self.appRecord.eventImage = image;
	/*if (image.size.width != kIconWidth && image.size.height != kIconHeight)
	{
        CGSize itemSize = CGSizeMake(kIconWidth, kIconHeight);
		UIGraphicsBeginImageContext(itemSize);
		CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
		[image drawInRect:imageRect];
		self.appRecord.eventImage2 = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
    }
    else
    {
        self.appRecord.eventImage2 = image;
	}*/
	
	self.appRecord.eventImage2 = image;
	
		//self.appRecord.eventImage2 = image2;
    
    self.activeDownload = nil;
    [image release];
	[image2 release];
    
		// Release the connection now that it's finished
    self.imageConnection = nil;
	
		// call our delegate and tell it that our icon is ready for display
    [delegate appImageDidLoad:self.indexPathInTableView];
}

@end

