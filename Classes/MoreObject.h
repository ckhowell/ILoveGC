//
//  MoreObject.h
//  MyProject
//
//  Created by user on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoreObject : NSObject {
	
	NSString *titleStr;
	int idcode;
	int inChange;
}

@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, assign) int idcode;
@property (nonatomic, assign) int inChange;

@end
