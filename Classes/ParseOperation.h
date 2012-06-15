

@class AppEvents;
//@class MapPin;
@class Maps;

@protocol ParseOperationDelegate;

@interface ParseOperation : NSOperation <NSXMLParserDelegate> {
	
@private
    id <ParseOperationDelegate> delegate;
	
	NSData			*eventdata;
    NSMutableArray  *ar;
	AppEvents       *primEvent;	
	//MapPin          *pin;
	
	
	NSData          *dataToParse;
    NSMutableArray  *workingArray;
    AppEvents       *currentEvent;
    NSMutableString *workingPropertyString;
    NSArray         *elementsToParse;
    BOOL            storingCharacterData;
	
	BOOL didAbortParsing;
	NSUInteger parsedEventsCounter;	
	
	NSString *st;
	
	double lat;
	double lon;
	
	NSString *twt;
	
	int once;
    
    
    int shortenURL;
    NSString *shortURL;
}

@property (copy, readonly) NSData *eventdata;
@property (nonatomic, retain) NSString *st;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@property (nonatomic, retain) NSString *twt;

- (id)initWithData:(NSData *)data delegate:(id <ParseOperationDelegate>)theDelegate;

@end

@protocol ParseOperationDelegate
- (void)didFinishParsing:(NSArray *)appList;
//- (void)finishParsing;
- (void)parseErrorOccurred:(NSError *)error;
- (void) demo: (NSString *) myString;
@end
