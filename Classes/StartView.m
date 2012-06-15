//
//  StartView.m
//  MyProject
//
//  Created by ANDREI A on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StartView.h"


@implementation StartView

@synthesize i, alert; //view; 

-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	alert = [[UIAlertView alloc] initWithTitle:@"" 
													message:@"i Love GC would like to use your current location" 
												   delegate:nil 
										  cancelButtonTitle:@"Don't allow"
										  otherButtonTitles:@"Allow", nil];
	
	[alert show];
	[alert release];
}


-(void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{			
		i = [NSString stringWithFormat:@"a"];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"PushView" object:i];
	}
	else{
		i = [NSString stringWithFormat:@"a"];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"PushView" object:i];		
	}
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
		//[view release];
	[alert release];
    [super dealloc];
}


@end
