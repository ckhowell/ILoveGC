//
//  CustomCell.h
//  MyProject
//
//  Created by ANDREI A on 5/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
	
	UIImageView *accessory;
	UILabel *titleLabel;
	UILabel *locationLabel;
	UILabel *dateLabel;
}

@property(nonatomic,retain) UILabel *titleLabel;
@property(nonatomic,retain) UILabel *locationLabel;
@property(nonatomic,retain) UILabel *dateLabel; 
@property(nonatomic,retain) UIImageView *accessory;

@end
