//
//  AboutGC.h
//  MyProject
//
//  Created by ANDREI A on 5/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutGC : UIViewController {
	
	UIButton *b;
    IBOutlet UIScrollView *scrollview;
	IBOutlet UIView *view1;
    UIAlertView *alertview;
    NSString *url;
}
@property(nonatomic,retain)UIScrollView *scrollview;
@property(nonatomic,retain)UIAlertView *alertview;
@property(nonatomic,retain)UIView *view1;
@property(nonatomic,retain)NSString *url;

@property(nonatomic, retain) UIButton *b;

@end
