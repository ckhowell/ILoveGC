    //
//  MoreObject.m
//  MyProject
//
//  Created by user on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreObject.h"


@implementation MoreObject

@synthesize titleStr;
@synthesize idcode;
@synthesize inChange;


- (void)dealloc {
    [super dealloc];
	
	[titleStr release];
}


@end
