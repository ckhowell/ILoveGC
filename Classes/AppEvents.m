

#import "AppEvents.h"

@implementation AppEvents

@synthesize eventTitle;
@synthesize eventImage;
@synthesize eventImage2;
@synthesize imageURLString;
@synthesize imageURLString2;
@synthesize email;
@synthesize cost;
@synthesize phone;
@synthesize web;
@synthesize date;
@synthesize date2;
@synthesize time;
@synthesize time2;
@synthesize latitude;
@synthesize longitude;
@synthesize category;
@synthesize location;
@synthesize description;
@synthesize data;
@synthesize data2;
@synthesize completdate;
@synthesize intr;
@synthesize index;
@synthesize img;

@synthesize intr2;
@synthesize index2;
@synthesize img2;

@synthesize intr3;
@synthesize index3;
@synthesize img3;

@synthesize invalid;
@synthesize favs;

@synthesize street;
@synthesize postcode;
@synthesize country;
@synthesize region;

@synthesize alarme;

@synthesize alarmbut;

@synthesize cmsoon;
@synthesize wtshot;
@synthesize comdate;
@synthesize idcod;


- (void)dealloc
{
	[comdate release];
	[region release];
	[alarmbut release];
	
	[street release];
	[postcode release];
	[country release];
	[alarme release];
	[cmsoon release];
	[wtshot release];
	[alarmbut release];
	[data2 release];
	[data release];
	[cost release];
	[description release];
	[location release];
	[phone release];
	[web release];
	[category release];
	[date release];
	[date2 release];
	[time release];
	[time2 release];
	[completdate release];
	[eventTitle release];
	[eventImage release];
	[eventImage2 release];
    [imageURLString release];
	[imageURLString2 release];
    [email release];
   
	
    
    [super dealloc];
}


/*
+ (NSSet *)keyPathsForValuesAffectingCoordinate
{
    return [NSSet setWithObjects:@"latitude", @"longitude", nil];
}*/

	// derive the coordinate property.
- (CLLocationCoordinate2D)coordinate
{
		CLLocationCoordinate2D theCoordinate;
		theCoordinate.latitude = latitude;  
		theCoordinate.longitude = longitude;   
		return theCoordinate; 
}

- (NSString *)title{
	
    return eventTitle;
}


- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self != nil) {
        eventTitle = [[decoder decodeObjectForKey:@"eventTitle"] retain];
        location = [[decoder decodeObjectForKey:@"location"] retain];
		category = [[decoder decodeObjectForKey:@"category"] retain];
		latitude = [decoder decodeDoubleForKey:@"latitude"];
		date = [[decoder decodeObjectForKey:@"date"] retain];
		longitude = [decoder decodeDoubleForKey:@"longitude"];
		date2 = [[decoder decodeObjectForKey:@"date2"] retain]; 
		cost = [[decoder decodeObjectForKey:@"cost"] retain];
		email = [[decoder decodeObjectForKey:@"email"] retain];
		phone = [[decoder decodeObjectForKey:@"phone"] retain];
		time = [[decoder decodeObjectForKey:@"time"] retain];
		web = [[decoder decodeObjectForKey:@"web"] retain];
		time2 = [[decoder decodeObjectForKey:@"time2"] retain];
		description = [[decoder decodeObjectForKey:@"description"] retain];
		imageURLString = [[decoder decodeObjectForKey:@"URL"] retain];
		imageURLString2 = [[decoder decodeObjectForKey:@"URL2"] retain];
		data = [[decoder decodeObjectForKey:@"data"] retain];
		eventImage = [[UIImage alloc] initWithData:data]; 
		data2 = [[decoder decodeObjectForKey:@"data2"] retain];
		eventImage2 = [[UIImage alloc] initWithData:data2];
		data = [[decoder decodeObjectForKey:@"d"] retain];
		data2 = [[decoder decodeObjectForKey:@"d2"] retain];
		alarmbut = [[decoder decodeObjectForKey:@"but"] retain];
		street = [[decoder decodeObjectForKey:@"street"] retain];
		postcode = [[decoder decodeObjectForKey:@"postcode"] retain];
		country = [[decoder decodeObjectForKey:@"country"] retain];
		
		alarme = [[decoder decodeObjectForKey:@"alarm"] retain];
		
		completdate = [[decoder decodeObjectForKey:@"cmldate"] retain];		
		region = [[decoder decodeObjectForKey:@"region"] retain];
		
		invalid = [decoder decodeIntForKey:@"invalid"];
		idcod = [decoder decodeIntForKey:@"idcod"];
		favs = [decoder decodeIntForKey:@"favs"];
		alarmbut = [[decoder decodeObjectForKey:@"alarmbut"] retain];
		comdate = [[decoder decodeObjectForKey:@"comdate"] retain];
	}
    return self;
}   

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:eventTitle forKey:@"eventTitle"];
    [encoder encodeObject:location forKey:@"location"];
	[encoder encodeObject:category forKey:@"category"];
	[encoder encodeDouble:latitude forKey:@"latitude"];
	[encoder encodeObject:date forKey:@"date"];
	[encoder encodeDouble:longitude forKey:@"longitude"];
	[encoder encodeObject:date2 forKey:@"date2"];
	[encoder encodeObject:cost forKey:@"cost"];
	[encoder encodeObject:email forKey:@"email"];
	[encoder encodeObject:phone forKey:@"phone"];
	[encoder encodeObject:time forKey:@"time"];	
	[encoder encodeObject:web forKey:@"web"];
	[encoder encodeObject:time2 forKey:@"time2"];
	[encoder encodeObject:description forKey:@"description"];
	[encoder encodeObject:imageURLString forKey:@"URL"];
	[encoder encodeObject:imageURLString2 forKey:@"URL2"];
	data = UIImagePNGRepresentation(eventImage);
	[encoder encodeObject:data forKey:@"data"];	
	data2 = UIImagePNGRepresentation(eventImage2);
	[encoder encodeObject:data2 forKey:@"data2"];	
	[encoder encodeObject:data forKey:@"d"];
	[encoder encodeObject:data2 forKey:@"d2"];
	[encoder encodeObject:alarmbut forKey:@"but"];
	[encoder encodeObject:street forKey:@"street"];
	[encoder encodeObject:postcode forKey:@"postcode"];
	[encoder encodeObject:country forKey:@"country"];
	
	[encoder encodeObject:alarme forKey:@"alarm"];
	
	[encoder encodeObject:completdate forKey:@"cmldate"];	
	[encoder encodeObject:region forKey:@"region"];
	
	[encoder encodeInt:invalid forKey:@"invalid"];
	[encoder encodeInt:idcod forKey:@"idcod"];
	[encoder encodeInt:favs forKey:@"favs"];
	[encoder encodeObject:alarmbut forKey:@"alarmbut"];
	[encoder encodeObject:comdate forKey:@"comdate"];
}


@end

