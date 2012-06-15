//
//  More.h
//  MyProject
//
//  Created by ANDREI A on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface More : UIViewController {
	
	UITableView *tableView3;
	NSMutableArray *listOfItems;
	int count;
	NSIndexPath *index;
	NSIndexPath *previewsIndex;
	UIImageView *aview;
    
    
}

@property (nonatomic, retain) IBOutlet UITableView *tableView3;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, assign) int count;
@property (nonatomic, retain) NSIndexPath *index;
@property (nonatomic, retain) NSIndexPath *previewsIndex;
@property (nonatomic, retain) UIImageView *aview;



@end
