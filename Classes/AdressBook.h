//
//  AdressBook.h
//  MyProject
//
//  Created by ANDREI A on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@class AppEvents;

@interface AdressBook : UIViewController <ABNewPersonViewControllerDelegate, ABUnknownPersonViewControllerDelegate,
ABPersonViewControllerDelegate>{
	
	IBOutlet UITableView *tableView;
	NSMutableArray *list;
	NSMutableArray *altlist;
	AppEvents *ap;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, retain) NSMutableArray *altlist;
@property (nonatomic, retain) AppEvents *ap;

@end
