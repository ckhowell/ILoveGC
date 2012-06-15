//
//  CustomToolbar.m
//  MyProject
//
//  Created by user on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomToolbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomToolbar

@synthesize img;

-(CustomToolbar *) initWithImage:(UIImage *)image
{
	img.image = [[UIImage alloc] initWithCGImage:[image CGImage]];
	[self setNeedsDisplay];
	return self;
}
-(void) drawRect:(CGRect)rect
{
	[img.image drawInRect:CGRectMake(0, 0, 100, 100)];
}


- (void)dealloc {
    [super dealloc];
	
	[img release];
}

@end
