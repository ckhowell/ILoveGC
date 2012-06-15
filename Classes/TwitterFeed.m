//
//  TwitterFeed.m
//  ISQua
//
//  Created by Newro Mac on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterFeed.h"


@implementation TwitterFeed

@synthesize titleT, dateT;
@synthesize link;

- (void) dealloc
{
	[titleT release];
	[dateT release];
    [link release];
	
	[super dealloc];
}

@end
