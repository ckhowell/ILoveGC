//
//  ParseOperation.h
//  MyProject
//
//  Created by ANDREI A on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

extern NSString *kAddEventsNotif;
extern NSString *kEarthquakeResultsKey;

extern NSString *kEventsErrorNotif;
extern NSString *kEarthquakesMsgErrorKey;

@class Events;

#import <UIKit/UIKit.h>


@interface ParseOperation : NSOperation {
	
	NSData *eventData;
	
@private
    NSDateFormatter *dateFormatter;
    
		// these variables are used during parsing
    Events *currentEventObject;
    NSMutableArray *currentParseBatch;
    NSMutableString *currentParsedCharacterData;
    
    BOOL accumulatingParsedCharacterData;
    BOOL didAbortParsing;
    NSUInteger parsedEventCounter;
	
}

@property (copy, readonly) NSData *eventData;

@end
