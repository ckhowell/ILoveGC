//
//  CustomCell.m
//  MyProject
//
//  Created by ANDREI A on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize titleLabel, locationLabel, dateLabel, accessory;


- (void)viewDidLoad {
			
		
		titleLabel = [[UILabel alloc]init];
		titleLabel.textAlignment = UITextAlignmentLeft;
		titleLabel.font = [UIFont systemFontOfSize:14];
		titleLabel.backgroundColor = [UIColor whiteColor];
		titleLabel.textColor = [UIColor whiteColor];
		
		dateLabel = [[UILabel alloc]init];
		dateLabel.textAlignment = UITextAlignmentLeft;
		dateLabel.font = [UIFont systemFontOfSize:8];
		dateLabel.backgroundColor = [UIColor clearColor];
		dateLabel.textColor = [UIColor whiteColor];
		
		accessory = [[UIImageView alloc]init];
		
		[self.contentView addSubview:dateLabel];
		[self.contentView addSubview:accessory];
}


- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;
	
	CGFloat boundsX = contentRect.origin.x;
	
	CGRect frame;
	
	
	frame= CGRectMake(boundsX+10 ,0, 50, 50);
	
	accessory.frame = frame;
	
	
	
	frame= CGRectMake(boundsX+70 ,5, 200, 25);
	
	titleLabel.frame = frame;
	
	
	
	frame= CGRectMake(boundsX+70 ,30, 100, 15);
	
	dateLabel.frame = frame;
	
	
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	
	[super setSelected:selected animated:animated];	
		// Configure the view for the selected state
	
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
    [super dealloc];
}


@end
