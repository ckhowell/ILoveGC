//
//  GCTwitter.h
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHK.h"
#import "AppEvents.h"
#import "SHKTwitter.h"

@interface GCTwitter : UIViewController {
	
	AppEvents *app;
	
	UILabel *titleLb;
	UIButton *share;
	
	int n;
}

@property (nonatomic, retain) AppEvents *app;

@property (nonatomic, retain) UIButton *share;
@property (nonatomic, retain) IBOutlet UILabel *titleLb;

-(void)shareWithTwitter:(UIButton *)sender;
-(void)logout:(UIButton *)sender;
-(void)Share:(UIButton *)sender;

@end
