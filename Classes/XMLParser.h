//
//  XMLParser.h
//  MRiPfView
//
//  Copyright 2011 NewRoSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TwitterFeed,Twit;


//-------------------------------------------------------------------------------------------------

@interface XMLParser : NSObject <NSXMLParserDelegate>
{
	NSMutableString *currentElementValue;
	
	TwitterFeed *currentFeed;

	NSMutableArray *twitFeeds;
}


//-------------------------------------------------------------------------------------------------

@property (nonatomic, retain) NSMutableArray *twitFeeds;


- (XMLParser *) initXMLParser;

@end
