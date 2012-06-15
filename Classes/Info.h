//
//  Info.h
//  MyProject
//
//  Created by ANDREI A on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>



@class AppEvents;


@interface Info : UIViewController  <MFMailComposeViewControllerDelegate, 
UITabBarControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate,
ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate, ABNewPersonViewControllerDelegate,
ABUnknownPersonViewControllerDelegate, UITableViewDelegate, MFMessageComposeViewControllerDelegate> {
	
	UILabel *titleLabel;
	UIImageView *image;
	AppEvents *app;

	UIButton *contact;
	UIButton *share;
	
	UIActionSheet *sheet;
	UIActionSheet *contacts;
	NSString *feedbackMsg;
	
	UITableView *tableView;
	UIView *view2;
	
	int i;
	int f;
	int t;
	
	CGRect labelPosition;
	
	UILabel *adress;
	UILabel *suburb;
	UILabel *pos;
	UILabel *country;
	UILabel *str;
	
	NSString *navTitle;
	
}

@property (nonatomic, retain) IBOutlet UIActionSheet *sheet;
@property (nonatomic, retain) IBOutlet UIActionSheet *contacts;
@property (nonatomic, retain) NSString *feedbackMsg;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIView *view2;

//@property (nonatomic) CGRect *labelPosition;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *image;

@property (nonatomic, retain) IBOutlet UIButton *contact;
@property (nonatomic, retain) IBOutlet UIButton *share;
@property (nonatomic, retain) AppEvents *app;

@property (nonatomic, retain) IBOutlet UILabel *str;
@property (nonatomic, retain) IBOutlet UILabel *suburb;
@property (nonatomic, retain) IBOutlet UILabel *pos;
@property (nonatomic, retain) IBOutlet UILabel *country;
@property (nonatomic, retain) IBOutlet UILabel *adress;


@end
