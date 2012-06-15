//
//  StartView.h
//  MyProject
//
//  Created by ANDREI A on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartView : UIViewController {
	
	UIAlertView *alert;
	NSString *i;

}

@property (nonatomic, assign) NSString *i;
@property (nonatomic, retain) IBOutlet UIAlertView *alert;

@end
