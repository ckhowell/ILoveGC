//
//  GCApplication.m
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCApplication.h"
#import "ILoveGCAppDelegate.h"


@implementation GCApplication


-(void) viewDidLoad{
	
	[super viewDidLoad];
	
	//self.view.backgroundColor = [UIColor  colorWithPatternImage:[UIImage imageNamed:@"Disclaimer.png"]];
	
	UILabel *lb = [[[UILabel alloc] initWithFrame:CGRectMake(25, 142, 250, 20)] autorelease];
	lb.backgroundColor = [UIColor clearColor];
	lb.textColor = [UIColor blackColor];
	lb.font = [UIFont boldSystemFontOfSize:14];
	lb.text = @"Disclaimer";
	[lb sizeToFit];
	
	UILabel *text = [[[UITextView alloc] initWithFrame:CGRectMake(18, 170, 250, 300)] autorelease];
	text.backgroundColor = [UIColor clearColor];
	text.textColor = [UIColor blackColor];
	text.font = [UIFont systemFontOfSize:14];
	text.text = @"The information contained herein is published as a guide only and, whilst the publishers believe that the information is correct, they do not accept any responsibility for any error or omissions or for any loss or damage incurred by any person directly or indirectly due to reliance on such information, and the user of such information does so at his own risk.";
	[text sizeToFit];
	text.userInteractionEnabled = NO;
	
	[self.view addSubview:lb];
	[self.view addSubview:text];

    
    
	
} 


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];

}


@end
