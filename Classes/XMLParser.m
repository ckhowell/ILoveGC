//
//  XMLParser.m
//  MRiPfView
//
//  Copyright 2011 NewRoSoft. All rights reserved.
//

#import "XMLParser.h"
#import "TwitterFeed.h"
#import "URLShortener.h"
#import "URLShortenerCredentials.h"




//-----------------------------------------------------------------------------------------------

@implementation XMLParser

@synthesize twitFeeds;

//------------------------------------------------------------------------------------------------
- (XMLParser *) initXMLParser
{
	[super init];

	return self;
}
//-------------------------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if ([elementName isEqualToString:@"channel"])
	{
		twitFeeds = [[NSMutableArray alloc] init];
	}
	
	else if ([elementName isEqualToString:@"item"])
	{
		if (currentFeed) 
		{
			[currentFeed release];
			currentFeed = nil;
		}
		currentFeed = [[TwitterFeed alloc] init];
	}
}
//-------------------------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
	if (!currentElementValue) 
	{
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	}
	
	else 
	{
		[currentElementValue appendString:string];
	}
	
}
//-------------------------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
	if ([elementName isEqualToString:@"rss"]) 
	{
		return;
	}

	if ([elementName isEqualToString:@"title"]) 
	{
        
		currentFeed.titleT = currentElementValue;
      /*  NSString *titleT = currentElementValue;
        // ----- check for links
        
        NSString *linkToTransform ;
        NSString *testString = titleT;
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
                    NSLog(@"URL %@  %d", url, [match range]);
                }
            }
            
            linkToTransform = [titleT substringFromIndex: myRange];
            linkToTransform = [linkToTransform substringToIndex: myRange2];
            NSLog(@"LINK TO TRANSFORM %@", linkToTransform);
            [self demo: linkToTransform];
        }
        */
        
        //----- end of checking
        
        
        
        
	}
	
	else if ([elementName isEqualToString:@"pubDate"])
	{
		currentFeed.dateT = currentElementValue;
	}
    else if ([elementName isEqualToString:@"link"])
    {
        currentFeed.link = currentElementValue;
    }
	
	else if ([elementName isEqualToString:@"item"])
	{
		[twitFeeds addObject:currentFeed];
	}
    
    
	
	[currentElementValue release];
	currentElementValue = nil;
}
/*
- (void) demo: (NSString *) myString
{
    URLShortener* shortener = [[URLShortener new] autorelease];
    if (shortener != nil) {
        shortener.delegate = self;
        // shortener.login = @"o_4f2dbhtc8h";
        // shortener.key = @"R_9003d4fcca785f4b1737d5060e71a906";
        //shortener.url = [NSURL URLWithString: @"http://stefan.arentz.ca"];
        shortener.url = [NSURL URLWithString: myString];
        [shortener execute];
    }
}


- (void) shortener: (URLShortener*) shortener didFailWithStatusCode: (int) statusCode
{
    
    NSLog(@"shortener: %@ didFailWithStatusCode: %d", self, statusCode);
    currentFeed.titleT = currentElementValue;
    
    
}
// -------------------------------------------------------------------

- (void) shortener: (URLShortener*) shortener didFailWithError: (NSError*) error
{
    NSLog(@"shortener: %@ didFailWithError: %d", self, [error localizedDescription]);
    currentFeed.titleT = currentElementValue;
    
}
// -------------------------------------------------------------------

- (void) shortener: (URLShortener*) shortener didSucceedWithShortenedURL: (NSURL*) shortenedURL
{
    
    NSString *shortURL = [shortenedURL absoluteString];
    NSLog(@"ShortUlr %@", shortURL);
    currentFeed.titleT = shortURL;
}
*/
//-------------------------------------------------------------------------------------------------
- (void) dealloc
{
	[twitFeeds release];
	[currentFeed release];
	[currentElementValue release];
	[super dealloc];
}
@end
