//
//  Directions.m
//  MyProject
//
//  Created by ANDREI A on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Directions.h"


@implementation Directions

@synthesize map;


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
	[map release];
    [super dealloc];
}


@end
