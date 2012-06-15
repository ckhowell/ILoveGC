//
//  Twitter.m
//  MyProject
//
//  Created by ANDREI A on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Twitter.h"
#import "XMLParser.h"
#import "TwitterFeed.h"
#import "URLShortener.h"
#import "URLShortenerCredentials.h"

NSString *substring;
NSString *shortURL;

@implementation Twitter

@synthesize feedtext, scroll;
@synthesize eventlist, queue, appListFeedConnection, appListData;
@synthesize activityView, img; 
// -------------------------------------------------------------------
-(void)viewDidLoad{
	
	[super viewDidLoad];
    
	scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    scroll.backgroundColor = [UIColor clearColor];
	[self.view addSubview:scroll];	
	
	img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	img.backgroundColor = [UIColor blackColor];
	[scroll addSubview:img];
     
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIView *view2 = [[UIView alloc] initWithFrame: CGRectMake((width - 100) / 2.0, (height - 182) / 2.0 , 100, 100)];
	view2.backgroundColor = [UIColor whiteColor];
	view2.alpha = 0.2;
	view2.layer.cornerRadius = 10;
	view2.layer.masksToBounds = YES;
	[img addSubview:view2];
	[view2 release];
	
	activityView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    activityView.center = CGPointMake(width / 2.0, (height - 82) / 2.0);
    
	[scroll addSubview: activityView];
    [activityView setHidden: NO];
    [activityView startAnimating];	
   	
    self.scroll.backgroundColor = [UIColor clearColor];
    
    urlString = [NSString stringWithFormat:@"%@", @"https://api.twitter.com/1/statuses/user_timeline.rss?screen_name=iheartgc&count=25"];
    
    // urlString = [NSString stringWithFormat:@"https://api.twitter.com/1/statuses/user_timeline.rss?screen_name=ionutgyn&count=25&page=1"];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:urlString]];
	conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

// -------------------------------------------------------------------
- (void)getFeedsFromUser 
{
    NSURL *url = [NSURL URLWithString:urlString];
	NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    
	XMLParser *parser = [[XMLParser alloc] init];
	[xmlParser setDelegate:parser];
	
	BOOL success = [xmlParser parse];
	
	twitFeeds = parser.twitFeeds;
	
	if (success)
        [self displayFeeds];
	
	else 
	{
        [activityView stopAnimating];
        [activityView setHidden: YES];
        [img removeFromSuperview];
        
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error!" message:@"Please check your connection!" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
	}
	
	[xmlParser release];
}
// -------------------------------------------------------------------
- (void) displayFeeds
{
    scroll.backgroundColor = [UIColor whiteColor];
    
    for (int i=0; i< [twitFeeds count];i++) 
    {   
    
        UITextView *bigText = [[UITextView alloc]init ];
        bigText.userInteractionEnabled = YES;
        bigText.editable = NO;
        bigText.frame = CGRectMake(0, 150 * i, 300, 520);
      
  
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, 300, 220)];
        imgView.backgroundColor= [UIColor whiteColor];
        [bigText addSubview: imgView];
        [bigText sendSubviewToBack: imgView];
        [imgView release];
        
 
        UITextView *textTitle=[[UITextView alloc]init ];
        textTitle.userInteractionEnabled =YES;
        textTitle.editable=NO;
        textTitle.textColor = [UIColor blackColor];
        textTitle.font = [UIFont fontWithName:@"Helvetica" size:13];
        textTitle.backgroundColor = [UIColor clearColor];
        textTitle.dataDetectorTypes=UIDataDetectorTypeLink ; 
                 
         
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"40x40.png"]];
        image.frame = CGRectMake(20, 10, 40, 40);
        
        UILabel *label =[[UILabel alloc]init];
        label.text=@"  iheartgc ";
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.font =[UIFont fontWithName:@"Helv-Bold" size:325];
        TwitterFeed * point = [twitFeeds objectAtIndex: i];
        label.frame= CGRectMake(65, 5, 260, 20);
       
        
        UIImageView *myLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_02.png"]];
        myLine.frame = CGRectMake(20, 140 , 450, 1);
        
 
        NSString *linkToTransform ;
        NSString *testString = point.titleT;
        NSDataDetector *detect = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [detect matchesInString:testString options:0 range:NSMakeRange(0, [testString length])];
        NSLog(@"MATCHES %@ %d", matches, [matches count]);
        if([matches count] !=0) 
        {   
            NSInteger myRange =0;
            NSInteger myRange2;
            NSURL *url;
            for (NSTextCheckingResult *match in matches) { 
            if ([match resultType] == NSTextCheckingTypeLink) {
                url = [match URL];
                myRange = [match range].location ;
                myRange2 = [match range].length;
               // NSLog(@"URL %@  %d", url, [match range]);
            }
            }
        
        
            linkToTransform = [point.titleT substringFromIndex: myRange];
            linkToTransform = [linkToTransform substringToIndex: myRange2];
            NSLog(@"LINK TO TRANSFORM %@", linkToTransform);
          //  [self demo: linkToTransform];
        }
     
       NSRange range = [point.titleT rangeOfString:@"iheartgc:"];
      substring = [[point.titleT substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       

        textTitle.text = substring;
       //textTitle.text = point.titleT;
        textTitle.frame = CGRectMake(60, 20, 250, 420);
        textTitle.scrollEnabled = YES;
        textTitle.dataDetectorTypes = UIDataDetectorTypeLink;        
         
        NSRange range2 = [point.dateT rangeOfString: @", "];
        NSString *substring2 = [[point.dateT substringFromIndex:NSMaxRange(range2)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString*substring3 = [substring2 substringToIndex:21];
       // NSLog(@"String3 %@", substring3);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"d MMM yyyy HH:mm:ss"];
        
        NSDate *myDate2 = [dateFormatter dateFromString: substring3];
        double end = [myDate2 timeIntervalSince1970];
        
        
        NSString *nowS;
        nowS = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *now = [dateFormatter dateFromString: nowS];
        double start = [now timeIntervalSince1970];
        
        double difference = start - end;
        
        int hours = difference / 3600.0;
        NSString *myLabelText, *myLabelText2;
        int myPos = 0;
        if(hours < 24)
        {
            if(hours < 10) myPos = 1;
            myLabelText = [NSString stringWithFormat: @"%d ", hours];
            if(hours == 1)
                myLabelText2 = [NSString stringWithFormat:@"%@", @"hour" ];
            else
                myLabelText2 =[NSString stringWithFormat:@"%@", @"hours"];
            
        }
        else 
        {
            int days = hours / 24;
            if(days < 10) myPos = 1;
            myLabelText = [NSString stringWithFormat:@"%d ", days];
            if(days == 1)
                myLabelText2 = [NSString stringWithFormat:@"%@", @"day"];
            else
                myLabelText2 = [NSString stringWithFormat: @"%@",@"days"];
            
            if(days > 24)
                myPos = 2;
        }
        
        if(myPos != 2)
        {
        
        UILabel *daysBet = [[UILabel alloc] init];
        daysBet.text = myLabelText;
        daysBet.textColor = [UIColor grayColor];
        daysBet.backgroundColor = [UIColor clearColor];
      //  daysBet.font = [UIFont fontWithName:@"Helv-Bold" size: 10];
        daysBet.font = [UIFont boldSystemFontOfSize: 17];
        if(myPos == 1) daysBet.frame = CGRectMake(221, 0, 100, 30); 
            else daysBet.frame = CGRectMake(212, 0, 100, 30);
        
        UILabel *textBet = [[UILabel alloc] init];
        textBet.text = myLabelText2;
        textBet.textColor = [UIColor grayColor];
        textBet.backgroundColor = [UIColor clearColor];
        textBet.font = [UIFont fontWithName:@"Helv" size: 3];
        textBet.frame = CGRectMake(235, 0, 100, 30);
            
            [bigText addSubview: daysBet];
            [bigText addSubview: textBet];
            [daysBet release];
            [textBet release];
            
        }
        
        else
        {
            UILabel *few = [[UILabel alloc] init];
            few.text = @"weeks ago";
            few.textColor = [UIColor grayColor];
            few.textAlignment = UITextAlignmentRight;
            few.backgroundColor = [UIColor clearColor];
            few.font = [UIFont boldSystemFontOfSize: 14];
            few.frame =CGRectMake(185, 0, 100, 30);
            [bigText addSubview: few];
            [few release];
        }
        
       

        [bigText addSubview:image];
        [bigText addSubview:label];
       
        [bigText addSubview:textTitle];
        [bigText addSubview: myLine];
     //   [bigText bringSubviewToFront: myLine];
        [scroll addSubview:bigText];
        
   //  [scroll addSubview: myLine];
        
        [image release];
        [label release];
        
       [textTitle release];
        [bigText release];
        [myLine release];
        
        
        scroll.contentSize = CGSizeMake(0, 145 * i + 251 );
    }
}
// -------------------------------------------------------------------
- (void) demo: (NSString *) myString: (NSInteger *)index
{
    URLShortener* shortener = [[URLShortener new] autorelease];
    if (shortener != nil) {
        shortener.delegate = self;
        shortener.url = [NSURL URLWithString: myString];
        [shortener execute];
    }
}
// -------------------------------------------------------------------
- (void) shortener: (URLShortener*) shortener didFailWithStatusCode: (int) statusCode
{
    NSLog(@"shortener: %@ didFailWithStatusCode: %d", self, statusCode);
}
// -------------------------------------------------------------------
- (void) shortener: (URLShortener*) shortener didFailWithError: (NSError*) error
{
    NSLog(@"shortener: %@ didFailWithError: %d", self, [error localizedDescription]);
}
// -------------------------------------------------------------------

- (void) shortener: (URLShortener*) shortener didSucceedWithShortenedURL: (NSURL*) shortenedURL
{
    shortURL = [shortenedURL absoluteString];
    NSLog(@"ShortUlr %@", shortURL);
}
// -------------------------------------------------------------------
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    
    [activityView stopAnimating];
    [activityView setHidden: YES];
    [img removeFromSuperview];
    [self getFeedsFromUser];		
}
// -------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [activityView stopAnimating];
    [activityView setHidden: YES];
    [img removeFromSuperview];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message: @"Could not establish the connection!" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];	
}
// -------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
// -------------------------------------------------------------------
- (void)viewDidUnload {
    [super viewDidUnload];
}
// -------------------------------------------------------------------
- (void)dealloc {
	
	[scroll release];
	[eventlist release];	
	[appListFeedConnection release];
	[appListData release];	
	[feedtext release];
	[img release];
    [super dealloc];
}
@end
