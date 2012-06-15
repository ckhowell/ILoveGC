

#import "ParseOperation.h"
#import "AppEvents.h"
#import "ILoveGCAppDelegate.h"


#define kAppIconHeight 48
#define kDiscIcon 25

static NSString *kTimeStr     = @"Time";
static NSString *kEventNameStr   = @"Event";
static NSString *kImageStr  = @"Picture_t";
static NSString *kImage2Str  = @"Picture";
static NSString *kCategoryStr = @"Category";
static NSString *kCoordinatesStr  = @"Coordinates";
static NSString *kCostStr   = @"Cost";
static NSString *kDateStr   = @"Date";
static NSString *kLocationStr  = @"City";
static NSString *kEmailStr  = @"Email";
static NSString *kPhoneStr  = @"Phone";
static NSString *kWebStr  = @"Web";
static NSString *kCmSoonStr  = @"Coming_soon";
static NSString *kWtHotStr  = @"Whats_hot";
static NSString *kDescriptionStr  = @"Description";
static NSString *kCountryStr  = @"Country";
static NSString *kStreetStr  = @"Street";
static NSString *kPostcodeStr  = @"Postal_code";
static NSString *kRegionStr  = @"Region";

static NSString *kStartStr = @"text";

@interface ParseOperation ()
@property (nonatomic, assign) id <ParseOperationDelegate> delegate;
@property (nonatomic, retain) NSData *dataToParse;
@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) AppEvents *currentEvent;
@property (nonatomic, retain) NSMutableString *workingPropertyString;
@property (nonatomic, retain) NSArray *elementsToParse;
@property (nonatomic, assign) BOOL storingCharacterData;


@property (nonatomic, retain) NSMutableArray *ar;
@property (nonatomic, retain) AppEvents *primEvent;
//@property (nonatomic, retain) MapPin *pin;


@end

@implementation ParseOperation

@synthesize delegate;
@synthesize workingArray;
@synthesize dataToParse;
@synthesize currentEvent;
@synthesize workingPropertyString;
@synthesize elementsToParse;
@synthesize storingCharacterData;
@synthesize twt;


@synthesize primEvent, lat, lon;
@synthesize ar, st, eventdata;



- (id)initWithData:(NSData *)data delegate:(id <ParseOperationDelegate>)theDelegate
{
	if(self = [super init])	
		if (self != nil)
		{
			dataToParse = [data copy];
			self.delegate = theDelegate;
			self.elementsToParse = [NSArray arrayWithObjects: kRegionStr, kStreetStr, kPostcodeStr, kCountryStr, kCmSoonStr,
									kWtHotStr ,kDescriptionStr, kImage2Str, kCoordinatesStr, kWebStr, kPhoneStr, kEmailStr,
									kEventNameStr, kCategoryStr, kDateStr, kCostStr, kLocationStr, kImageStr, kTimeStr,
									kStartStr, nil];
		}
    return self;
}



	// -------------------------------------------------------------------------------
	//	dealloc:
	// -------------------------------------------------------------------------------
- (void)dealloc
{

	[eventdata release];
	[st release];
	[ar release];
	[primEvent release];	
	
	//[pin release];
	[dataToParse release];
    [currentEvent release];
    [workingPropertyString release];
    [workingArray release];
    
    [super dealloc];
}


//static const const NSUInteger maxEventsToParse = 30;
//static NSUInteger const sizeOfEventsBatch = 10;
	
	// -------------------------------------------------------------------------------
	//	main:
	//  Given data to parse, use NSXMLParser and process all the top paid apps.
	// -------------------------------------------------------------------------------
- (void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	self.workingArray = [NSMutableArray array];
    self.workingPropertyString = [NSMutableString string];
    
	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataToParse];
	[parser setDelegate:self];
    [parser parse];
	
	if (![self isCancelled])
    {	
			// notify our AppDelegate that the parsing is complete
		if (once != 1) {
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:TRUE];
			[self.workingArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
			[sortDescriptor release];
			
			for (int i=0;i<[self.workingArray count];i++) {
				AppEvents *ap = [self.workingArray objectAtIndex:i];
				ap.idcod = i;
				//NSLog(@"WORKING ARRAY %@", ap.eventTitle);
				[self.workingArray replaceObjectAtIndex:i withObject:ap];
			}
		}
			
		[self.delegate didFinishParsing:self.workingArray];
		//NSLog(@"%@", self.workingArray);
		//[self.delegate finishParsing];
    }

    self.workingArray = nil;
    self.workingPropertyString = nil;
	self.dataToParse = nil;

    
    [parser release];
	
	[pool release];
}




#pragma mark -
#pragma mark RSS processing

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
													namespaceURI:(NSString *)namespaceURI
													qualifiedName:(NSString *)qName
													attributes:(NSDictionary *)attributeDict
{
	//NSLog(@"%@", [parser parserError]);
    
    if(parsedEventsCounter >= 100){
	//if (parsedEventsCounter >= 30) {
		
        didAbortParsing = YES;
        [parser abortParsing];
    }
    if ([elementName isEqualToString:kCategoryStr])
    {
        
		self.st = [attributeDict valueForKey:@"Name"]; 	
     
    }	
    if ([elementName isEqualToString:kEventNameStr])
    {
		once = 0;
		
        self.currentEvent = [[[AppEvents alloc] init] autorelease];
		NSString *atribut = [attributeDict valueForKey:@"Title"];
       
		self.currentEvent.eventTitle = atribut;
       // NSLog(@"TITLE %@", currentEvent.eventTitle);
		self.currentEvent.category = self.st;
		//self.currentEvent.alarmbut = @"cc";
    }
	else if ([elementName isEqualToString:kLocationStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.location = atribut; 	
    }
	else if ([elementName isEqualToString:kStreetStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.street = atribut; 	
    }	
	else if ([elementName isEqualToString:kRegionStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.region = atribut; 	
    }	
	else if ([elementName isEqualToString:kCountryStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.country = atribut; 	
    }	
	else if ([elementName isEqualToString:kPostcodeStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.postcode = atribut; 	
    }
	else if ([elementName isEqualToString:kCmSoonStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.cmsoon = atribut; 	
    }
	else if ([elementName isEqualToString:kWtHotStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.wtshot = atribut; 
    }
	else if ([elementName isEqualToString:kDescriptionStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.description = atribut; 	
    }	
	else if ([elementName isEqualToString:kDateStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		
		if(![atribut isEqualToString:@""]){
			if(![atribut isEqualToString:@"-"]){
				NSArray *array = [atribut componentsSeparatedByString:@"-"];
				NSString *str = [array objectAtIndex:0];
				NSString *str2 = [array objectAtIndex:1];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
				[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
				[dateFormatter setDateFormat:@"dd'|'MM'|'yyyy"];
                
                self.currentEvent.date = [dateFormatter dateFromString: str];
                if(str2) self.currentEvent.date2 = [dateFormatter dateFromString: str2];
                else self.currentEvent = nil;
                
                NSComparisonResult result = [self.currentEvent.date compare: self.currentEvent.date2];
                if(result == NSOrderedSame)
                    self.currentEvent.date2 = nil;
                
                
               /*
                if(str2)
                {
				self.currentEvent.date = [dateFormatter dateFromString:str];
				self.currentEvent.date2 = [dateFormatter dateFromString:str2];	

                NSComparisonResult result = [self.currentEvent.date2 compare:self.currentEvent.date];
				if(result==NSOrderedSame){
					self.currentEvent.date2 = nil;
				}
                    //else if(result == NSOrderedDescending)
                       // self.currentEvent.date2 = nil;
                    else {
                         //self.currentEvent.date = currentEvent.data2;
                        
                    }
                }
                
                
                
                else {
                    self.currentEvent.date2 = self.currentEvent.date;
                }
                if([str2 isEqualToString:@""])
                    self.currentEvent.date2 = self.currentEvent.date;
               
                */
                
			}
                
 		}
	}
	else if ([elementName isEqualToString:kTimeStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		if(![atribut isEqualToString:@""]){
			if(![atribut isEqualToString:@"-"]){
				NSArray *array = [atribut componentsSeparatedByString:@"-"];
				NSString *str = [array objectAtIndex:0];
				NSString *str2 = [array objectAtIndex:1];
				NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
				[timeFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
				[timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
				[timeFormatter setDateFormat:@"hh:mma"];
				self.currentEvent.time = [timeFormatter dateFromString:str];
				self.currentEvent.time2 = [timeFormatter dateFromString:str2];
			}
		}
    }
	else if ([elementName isEqualToString:kImageStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.imageURLString2 = atribut;
	}	
	else if ([elementName isEqualToString:kImage2Str])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.imageURLString = atribut;
	}	
	else if ([elementName isEqualToString:kCostStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.cost = atribut;
	}	
	else if ([elementName isEqualToString:kCoordinatesStr])
	{		
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		
		if(![atribut isEqualToString:@""]){
			if(![atribut isEqualToString:@"|"])
			{
				NSArray *array = [atribut componentsSeparatedByString:@"|"];
			
				NSString *str = [array objectAtIndex:0];
				if(![str isEqualToString:@""]){
					NSScanner *scanner = [NSScanner scannerWithString:str];
					double latitude;
					if ([scanner scanDouble:&latitude]) {
						lat = latitude;
						if(lat >= -90 && lat <= 90){
							lat = latitude;	
						}
						else{
							lat = 200;
							self.currentEvent.latitude = 200;
						}
					}
				}
				else{
					lat = 200;
					self.currentEvent.latitude = 200;
				}
			
				NSString *str2 = [array objectAtIndex:1];
				if(![str2 isEqualToString:@""]){
					NSScanner *scanner2 = [NSScanner scannerWithString:str2];
					double longitude;
					if ([scanner2 scanDouble:&longitude]) {
						lon = longitude;
						if(lon >= -180 && lon <= 180){
							int r = (int)lat;
							if(r != 200){
								self.currentEvent.longitude = longitude;
							}	
							else{
								lon = 200;
								self.currentEvent.longitude = 200;
							}
						}
						else{
							lon = 200;
							lat = 200;
							self.currentEvent.longitude = 200;
						}
					}	
				}
				else{
					lon = 200;
					self.currentEvent.longitude = 200;
				}
			
				int j = (int)lon; int l = (int)lat;
				if(j != 200){
					if(l != 200){	
						self.currentEvent.latitude = lat;
					}
					else{
						self.currentEvent.latitude = 200;
					}
				}
			}
			else{
				self.currentEvent.latitude = 200;
				self.currentEvent.longitude = 200;
			}
		}
		else{
			self.currentEvent.latitude = 200;
			self.currentEvent.longitude = 200;
		}
	}	
	else if ([elementName isEqualToString:kPhoneStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.phone = atribut;
	}
	else if ([elementName isEqualToString:kWebStr])
	{
        
		NSString *atribut = [attributeDict valueForKey:@"Value"];
    
        // ----- check if the url is supported.
        
        NSRange textRange;
        textRange = [atribut rangeOfString: @"http://"];
        
        if(textRange.location != NSNotFound)
        {
            //Does contain the substring
            self.currentEvent.web = atribut;
        }
            else
            {
                //Does not contain the substring
                NSString *myString = [[NSString alloc] init];
                if(atribut)
                    myString = [NSString stringWithFormat: @"%@%@", @"http://", atribut];
                if([myString compare:@"http://"] == NSOrderedSame)
                    self.currentEvent.web = @"";
                else 
                    self.currentEvent.web = myString;
            }
    }
    
	else if ([elementName isEqualToString:kEmailStr])
	{
		NSString *atribut = [attributeDict valueForKey:@"Value"];
		self.currentEvent.email = atribut;
	}
	else if ([elementName isEqualToString:kStartStr])
	{        
		once = 1;
		
		self.currentEvent = [[[AppEvents alloc] init] autorelease];
		storingCharacterData = YES;
		[workingPropertyString setString:@""];
	}	
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
								namespaceURI:(NSString *)namespaceURI
								qualifiedName:(NSString *)qName
{
	if([parser parserError]!=nil){
		NSLog(@"%@", [parser parserError]);
	}
	
    if (self.currentEvent)
	{
		if (storingCharacterData)
        {
				NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
										   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
				[workingPropertyString setString:@""];  // clear the string for next time
			
			
				if ([elementName isEqualToString:kStartStr])
				{        
					self.currentEvent.eventTitle = trimmedString;
					[self.workingArray addObject:self.currentEvent.eventTitle];
					self.currentEvent = nil;	
				}
				/*else if ([elementName isEqualToString:kImageStr])
				{
					self.currentEvent.imageURLString = trimmedString;
				}*/
				/*if ([elementName isEqualToString:kCategoryStr])
				{
					self.currentEvent.artist = trimmedString;
				}*/
				/*else if ([elementName isEqualToString:kDateStr])
				{
						self.currentEvent.edate = [dateFormatter dateFromString:trimmedString];
				}
				else if ([elementName isEqualToString:kCostStr])
				{
					//self.currentEvent.cost = trimmedString;
				
			
					NSScanner *scanner = [NSScanner scannerWithString:trimmedString];
					if([scanner scanString:@"$" intoString:NULL])
					{
						CGFloat cost;
						if ([scanner scanFloat:&cost]) {
						self.currentEvent.cost = cost;
						}
					}
				}*/
				/*else if ([elementName isEqualToString:kCategStr])
				{

					self.currentEvent.category = trimmedString;;
					double lat = 44.41695;
					double lon = 26.16896;
					self.currentEvent.latitude1 = 44.41695;
					self.currentEvent.latitude = [NSNumber numberWithDouble:lat];
					self.currentEvent.longitude = [NSNumber numberWithDouble:lon];
				}*/
			
        }
        else if ([elementName isEqualToString:kEventNameStr])
        {
		
            NSDate *now = [NSDate date];
			
			NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
			[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
			[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
			[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
			[dateFormatter setDateFormat:@"dd MMM yyyy"];
			
			NSDateFormatter *timeFormatter = [[[NSDateFormatter alloc] init] autorelease];
			[timeFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
			[timeFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
			[timeFormatter setTimeZone:[NSTimeZone localTimeZone]];
			[timeFormatter setDateFormat:@"hh:mm a"];
			
			int offset = [[NSTimeZone localTimeZone] secondsFromGMT] / 3600 ;
			
			NSCalendar *calendar = [NSCalendar currentCalendar];			
			NSDateComponents *components = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | 
																 kCFCalendarUnitDay) fromDate:now];
			int year = [components year];
			int month = [components month];
			int day = [components day];

			[components setYear:year];
			[components setMonth:month];	
			[components setDay:day];
			[components setMinute:0];
			[components setHour:offset];	
			[components setSecond:0];
			
			now = [calendar dateFromComponents:components];
			
			//NSLog(@"now = %@", now);
			now = [now dateByAddingTimeInterval:-(60*60*24)];
			
			
			NSString *eventdate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.currentEvent.date]];
			NSString *eventtime = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:self.currentEvent.time]];
			NSString *completdate = [NSString stringWithFormat:@"%@ %@", eventdate, eventtime];
			
			NSString *eventdate2 = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.currentEvent.date2]];
			NSString *eventtime2;
            if(self.currentEvent.time2)
                eventtime2 = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:self.currentEvent.time2]];
            else eventtime2 = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:self.currentEvent.time]];
			NSString *completdate2 = [NSString stringWithFormat:@"%@ %@", eventdate2, eventtime2];
            
            
   
            
            NSDateFormatter *dateF = [[[NSDateFormatter alloc] init] autorelease];
			[dateF setFormatterBehavior:NSDateFormatterBehavior10_4];
			[dateF setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
			[dateF setTimeZone:[NSTimeZone localTimeZone]];
			[dateF setDateFormat:@"dd MM yyyy hh:mm a"];
			
			NSDate *complet = [dateF dateFromString:completdate];
			NSDate *complet2 = [dateF dateFromString:completdate2];
			

			
			//NSLog(@"date = %@ - %@", complet, complet2);
			
            
            
			NSComparisonResult result = [now compare:complet];
			NSComparisonResult result2 = [now compare:complet2];
         			
            if(result == NSOrderedAscending || result2 == NSOrderedAscending)
            {
		
	
				NSDateComponents *components = [calendar components:(kCFCalendarUnitYear | kCFCalendarUnitMonth | 
																	 kCFCalendarUnitDay | kCFCalendarUnitHour |
																	 kCFCalendarUnitMinute | kCFCalendarUnitSecond)
																	 fromDate:now];
				year = [components year];
				month = [components month]+3;
				day = [components day];
				
				[components setYear:year];
				[components setMonth:month];	
				[components setDay:day];
				
				NSDate *futureDate = [calendar dateFromComponents:components];	
					
				NSComparisonResult result3 = [complet compare:futureDate];
				if(result3==NSOrderedAscending){
                    
                    
                   
					[self.workingArray addObject:self.currentEvent];
				
					if(primEvent == nil){
						primEvent = [[AppEvents alloc] init];
						primEvent = self.currentEvent;
					}
				}
			 }
		
            
          
            
			self.currentEvent = nil;
        }
    }
	
	storingCharacterData = NO;    
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (storingCharacterData)
	{
		[workingPropertyString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [delegate parseErrorOccurred:parseError];
}

@end