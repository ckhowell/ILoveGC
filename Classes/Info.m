//
//  Info.m
//  MyProject
//
//  Created by ANDREI A on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Info.h"
#import "AppEvents.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AdressBook.h"
#import "AppEvents.h"
#import "ILoveGCAppDelegate.h"
//#import "MapWithRouts.h"



@implementation Info

@synthesize titleLabel, image, app, sheet, feedbackMsg;
@synthesize contact, share, contacts;
@synthesize tableView, view2, adress, country, suburb, pos, str;



-(void)viewDidLoad{
	
	[super viewDidLoad];
	
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 37, 200, 20)];
	titleLabel.text = app.eventTitle;
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.textColor = [UIColor blackColor];
	titleLabel.font = [UIFont boldSystemFontOfSize:18];
	
	image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 18, 60, 60)];	
	image.image = app.eventImage;
	
	[self.view2 addSubview:image];
	[self.view2 addSubview:titleLabel];
	//[self.tableView addSubview:share];
	//[self.tableView addSubview:contact];

}


-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:YES];
	
	//NSLog(@"%@", self.navigationController.title);
	//if (![navTitle isEqual:self.navigationController.title]) {
	//	[self.navigationController popToRootViewControllerAnimated:YES];
	//}
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	
	ILoveGCAppDelegate *apd = (ILoveGCAppDelegate *)[[UIApplication sharedApplication] delegate];
	navTitle = apd.aTabBarController.selectedViewController.title;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 1;
	else return 2;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	if(indexPath.section == 0) {
		
		f = 9;
		
		adress = [[UILabel alloc] initWithFrame:CGRectMake(10, f-3, 50, 18)];
		adress.backgroundColor = [UIColor clearColor];
		adress.font = [UIFont boldSystemFontOfSize:12];
		adress.textColor = [UIColor colorWithRed:(50/255.f) green:(79/255.f) blue:(133/255.f) alpha:1.0];
		adress.text = @"address";
		
		if (![app.street isEqualToString:@""]) {
			str = [[UILabel alloc] initWithFrame:CGRectMake(75, f, 215, 14)];
			
			str.backgroundColor = [UIColor clearColor];
			str.font = [UIFont systemFontOfSize:12];
			str.numberOfLines = 0;
			str.text = [NSString stringWithFormat:@"%@", [app.street stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
			[str sizeToFit];
			//str.lineBreakMode = UILineBreakModeWordWrap;
			
			labelPosition = str.frame;
			f = (int)labelPosition.origin.y + str.frame.size.height+2;			
		}
		if (![app.region isEqualToString:@""]) {
			suburb = [[UILabel alloc] initWithFrame:CGRectMake(75, f, 215, 14)];
			
			suburb.backgroundColor = [UIColor clearColor];
			suburb.font = [UIFont systemFontOfSize:12];
			suburb.numberOfLines = 0;
			suburb.text = [NSString stringWithFormat:@"%@", [app.region stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
			[suburb sizeToFit];
			suburb.lineBreakMode = UILineBreakModeWordWrap;
			
			labelPosition = suburb.frame;
			f = (int)labelPosition.origin.y + suburb.frame.size.height+2;
		}
		if (![app.postcode isEqualToString:@""]) {
			pos = [[UILabel alloc] initWithFrame:CGRectMake(75, f, 215, 14)];
			
			pos.backgroundColor = [UIColor clearColor];
			pos.font = [UIFont systemFontOfSize:12];
			pos.numberOfLines = 0;
			pos.text = [NSString stringWithFormat:@"postcode  %@", [app.postcode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
			[pos sizeToFit];
			pos.lineBreakMode = UILineBreakModeWordWrap;
			
			labelPosition = pos.frame;
			f = (int)labelPosition.origin.y + pos.frame.size.height+2;
		}
		if (![app.postcode isEqualToString:@""]) {
			country = [[UILabel alloc] initWithFrame:CGRectMake(75, f, 215, 14)];
			
			country.backgroundColor = [UIColor clearColor];
			country.font = [UIFont systemFontOfSize:12];
			country.numberOfLines = 0;
			country.text = [NSString stringWithFormat:@"%@", [app.country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
			[country sizeToFit];
			country.lineBreakMode = UILineBreakModeWordWrap;
			
			labelPosition = country.frame;
			f = (int)labelPosition.origin.y + country.frame.size.height+2;
		}		
		
		f = f + 7; 
		
		int r = f + 225;
		
		contact = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain]; 
		contact.frame = CGRectMake(10, r, 130, 40); 
		contact.backgroundColor = [UIColor clearColor];
		//[contact setBackgroundImage:[UIImage imageNamed:@"contacts@2x.png"] forState:UIControlStateNormal];
		//[contact setBackgroundImage:[UIImage imageNamed:@"contacts2@2x.png"] forState:UIControlStateHighlighted];
		//[contact setBackgroundImage:[UIImage imageNamed:@"contacts2@2x.png"] forState:UIControlStateSelected];
		[contact setTitle:@"Add to Contacts" forState:UIControlStateNormal];
		[contact setTitle:@"Add to Contacts" forState:UIControlStateHighlighted];
		[contact setTitle:@"Add to Contacts" forState:UIControlStateSelected];
		contact.titleLabel.font = [UIFont boldSystemFontOfSize:13];	
		contact.titleLabel.textColor = [UIColor colorWithRed:(50/255.f) green:(79/255.f) blue:(133/255.f) alpha:1.0];
		[contact addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];	
		[self.tableView addSubview:contact];	
		
		share = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain]; 
		share.frame = CGRectMake(180, r, 130, 40);
		share.backgroundColor = [UIColor clearColor];
		//[share setBackgroundImage:[UIImage imageNamed:@"location@2x.png"] forState:UIControlStateNormal];
		//[share setBackgroundImage:[UIImage imageNamed:@"location2@2x.png"] forState:UIControlStateHighlighted];
		//[share setBackgroundImage:[UIImage imageNamed:@"location2@2x.png"] forState:UIControlStateSelected];
		[share setTitle:@"Share Location" forState:UIControlStateNormal];
		[share setTitle:@"Share Location" forState:UIControlStateHighlighted];
		[share setTitle:@"Share Location" forState:UIControlStateSelected];
		share.titleLabel.font = [UIFont boldSystemFontOfSize:13];		
		share.titleLabel.textColor = [UIColor colorWithRed:(50/255.f) green:(79/255.f) blue:(133/255.f) alpha:1.0];
		[share addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];	
		[self.tableView addSubview:share];	
		
		labelPosition = contact.frame;
		t = (int)labelPosition.origin.y + contact.frame.size.height+2;
		
		return f;
	}
	else{
		return 40;
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSUInteger const AdressTag = 2;
	static NSUInteger const StrTag = 3;
	static NSUInteger const SuburbTag = 4;
	static NSUInteger const PosTag = 5;
	static NSUInteger const CountryTag = 6;
	static NSUInteger const Dir1Tag = 7;
	static NSUInteger const Dir2Tag = 8;	
	
	UILabel *dir1 = nil;
	UILabel *dir2 = nil;
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;

		if(indexPath.section == 0){
			self.adress.tag = AdressTag;
			[cell.contentView addSubview:self.adress];
			
			if (![app.street isEqualToString:@""]) {
				self.str.tag = StrTag;
				[cell.contentView addSubview:self.str];
			}
			
			if (![app.region isEqualToString:@""]) {
				self.suburb.tag = SuburbTag;
				[cell.contentView addSubview:self.suburb];
			}
			
			if (![app.postcode isEqualToString:@""]) {
				self.pos.tag = PosTag;
				[cell.contentView addSubview:self.pos];	
			}
			
			if (![app.postcode isEqualToString:@""]) {
				self.country.tag = CountryTag;
				[cell.contentView addSubview:self.country];
			}
		}
		else{
			if(indexPath.row == 0){
				dir1 = [[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)] autorelease];
				dir1.tag = Dir1Tag;
				dir1.backgroundColor = [UIColor clearColor];
				dir1.font = [UIFont boldSystemFontOfSize:13];
				dir1.textColor = [UIColor colorWithRed:(50/255.f) green:(79/255.f) blue:(133/255.f) alpha:1.0];
				dir1.textAlignment = UITextAlignmentCenter;
				dir1.text = @"Directions To Here";
				[cell.contentView addSubview:dir1];
			}
			else{
				dir2 = [[[UILabel alloc] initWithFrame:CGRectMake(50, 10, 200, 20)] autorelease];
				dir2.tag = Dir2Tag;
				dir2.backgroundColor = [UIColor clearColor];
				dir2.font = [UIFont boldSystemFontOfSize:13];
				dir2.textColor = [UIColor colorWithRed:(50/255.f) green:(79/255.f) blue:(133/255.f) alpha:1.0];
				dir2.textAlignment = UITextAlignmentCenter;
				dir2.text = @"Directions From Here";
				[cell.contentView addSubview:dir2];
			}
		}
	}   
	else{
		self.adress = (UILabel *)[cell.contentView viewWithTag:AdressTag];
		self.str = (UILabel *)[cell.contentView viewWithTag:StrTag];
		self.suburb = (UILabel *)[cell.contentView viewWithTag:SuburbTag];
		self.pos = (UILabel *)[cell.contentView viewWithTag:PosTag];
		self.country = (UILabel *)[cell.contentView viewWithTag:CountryTag];
		dir1 = (UILabel *)[cell.contentView viewWithTag:Dir1Tag];
		dir2 = (UILabel *)[cell.contentView viewWithTag:Dir2Tag];
	}	
	
	t = t + 10; 
	self.tableView.contentSize = CGSizeMake(0, t);	
	
    return cell;
}


- (void)tableView:(UITableView *)tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(indexPath.section == 0) [self.navigationController popViewControllerAnimated:YES];
	else{
		if(indexPath.row == 0){
			
			/*MapWithRouts *routs = [[MapWithRouts alloc] init];
			routs.title = @"Directions";
			routs.event = app;
			[self.navigationController pushViewController:routs animated:YES];
			[routs release];*/
			
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:
					[NSString stringWithFormat:@"http://maps.google.com/maps/m?daddr=%f,%f", app.latitude, app.longitude]]];
			//&daddr=%f,%f , 44.437711, 26.097367
			
			
			//@"http://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway%2c+Mountain+View%2c+CA&sensor=true"
		}
		else{
			
			/*SearchRouts *routs = [[SearchRouts alloc] init];
			routs.title = @"Directions";
			routs.eve = app;
			[self.navigationController pushViewController:routs animated:YES];
			[routs release];*/
			
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:
				[NSString stringWithFormat:@"http://maps.google.com/maps/m?saddr=%f,%f", app.latitude, app.longitude]]];
		}
	}
}



-(void)addContact:(UIButton*)sender {
	
	/*ABRecordRef person = ABPersonCreate();
	CFErrorRef error = NULL;
	
		//Phone number is a list of phone number, so create a multivalue    
	ABMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	BOOL didAdd = ABMultiValueAddValueAndLabel(phoneNumberMultiValue, app.phone, kABPersonPhoneMobileLabel, NULL);
		//ABMultiValueAddValueAndLabel(phoneNumberMultiValue , ap.phone, kABPersonPhoneMobileLabel, NULL);
	
	if(didAdd == YES){
		
		ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, &error);
		if(error == NULL){
			ABUnknownPersonViewController *controller = [[ABUnknownPersonViewController alloc] init];
			controller.unknownPersonViewDelegate = self;			
			controller.displayedPerson = person;
			controller.allowsAddingToAddressBook = YES;
			controller.navigationItem.title = @"Save contact";
			
			[self.navigationController pushViewController:controller animated:YES];		
			[controller release];
		}
		else 
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
															message:@"Could not create unknown user" 
														   delegate:nil 
												  cancelButtonTitle:@"Cancel"
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	}
	
	CFRelease(person);
	CFRelease(phoneNumberMultiValue);*/	
	
	
	contacts = [[UIActionSheet alloc] initWithTitle:nil
													   delegate:self
											  cancelButtonTitle:@"Cancel"
										 destructiveButtonTitle:nil
											  otherButtonTitles:@"Create New Contact", @"Add to Existing Contact", nil];
	
	[contacts showInView:self.parentViewController.tabBarController.view];
	[contacts release];	
	i = 1;
}

- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}


- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person{
	
	[self dismissModalViewControllerAnimated:YES];
}

-(void)Share:(UIButton*)sender {
	
	sheet = [[UIActionSheet alloc] initWithTitle:nil
													   delegate:self
											  cancelButtonTitle:@"Cancel"
										 destructiveButtonTitle:nil
											  otherButtonTitles:@"Email", @"SMS", nil];
	
	[sheet showInView:self.parentViewController.tabBarController.view];
    [sheet release];	
	i = 0;
}



-(void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{	
		if(i == 1){
			
			//ABAddressBookRef addressBook = ABAddressBookCreate(); 
			ABRecordRef person = ABPersonCreate(); 
			CFErrorRef error = NULL;
			
			
			// firstname
			//ABRecordSetValue(person, kABPersonFirstNameProperty, @"Don Juan", NULL);
			
			//phone
			if (![app.phone isEqualToString:@""]) {
				ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
				ABMultiValueAddValueAndLabel(phoneNumberMultiValue , app.phone, kABPersonPhoneMobileLabel, NULL);
				ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, &error); 
				CFRelease(phoneNumberMultiValue); 
			}
			
			// email
			if (![app.email isEqualToString:@""]) {
				ABMutableMultiValueRef email = ABMultiValueCreateMutable(kABMultiStringPropertyType);
				ABMultiValueAddValueAndLabel(email, app.email, CFSTR("email"), NULL);
				ABRecordSetValue(person, kABPersonEmailProperty, email, &error);
				CFRelease(email); 
			}
			
			if (![app.web isEqualToString:@""]) {
				ABMutableMultiValueRef web = ABMultiValueCreateMutable(kABMultiStringPropertyType);
				ABMultiValueAddValueAndLabel(web, app.web, CFSTR("home page"), NULL);
				ABRecordSetValue(person, kABPersonURLProperty, web, &error);
				CFRelease(web); 
			}
			
			// Start of Address
			ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);  
			NSMutableDictionary *addressDict = [[NSMutableDictionary alloc] init];
			if (![app.street isEqualToString:@""]) {
				[addressDict setObject:app.street forKey:(NSString *)kABPersonAddressStreetKey];  
			}
			if (![app.postcode isEqualToString:@""]) {
				[addressDict setObject:app.postcode forKey:(NSString *)kABPersonAddressZIPKey];  
			}
			if (![app.location isEqualToString:@""]) {
				[addressDict setObject:app.location forKey:(NSString *)kABPersonAddressCityKey]; 
			}
			ABMultiValueAddValueAndLabel(address, addressDict, kABWorkLabel, NULL);
			ABRecordSetValue(person, kABPersonAddressProperty, address, &error); 
			[addressDict release];
			CFRelease(address); 
			// End of Address
			
			if (error != NULL)  NSLog(@"Error: %@", error);
			
			
			ABNewPersonViewController *newPersonViewController = [[ABNewPersonViewController alloc] init];
			newPersonViewController.newPersonViewDelegate = self;
			newPersonViewController.displayedPerson = person;
			
			UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newPersonViewController];
			[self.navigationController presentModalViewController:nav animated:YES];
			
			[newPersonViewController release];
			[nav release];
			CFRelease(person);
		}
		else{
			
			Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));		
		
		
			if (mailClass != nil) {
				if ([mailClass canSendMail]) {
					[self performSelector:@selector(displayMailComposerSheet)];
				}
				else {
					UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"This device is not configured to send emaild" 
																 message:nil 
																delegate:self 
													   cancelButtonTitle:@"Ok"
													   otherButtonTitles:nil];
				
					[alert3 show];
					[alert3 release];
				}
			}
			else	{
				UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"This device is not configured to send emaild" 
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
				[alert4 show];
				[alert4 release];
			}		
		}
	}

	if (buttonIndex == 1)
	{		
		if(i == 1){
			ABPeoplePickerNavigationController *pikerViewController = [[ABPeoplePickerNavigationController alloc] init];
			pikerViewController.peoplePickerDelegate = self;
			
			[self.navigationController presentModalViewController:pikerViewController animated:YES];
  
		}
		else{
			
			Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
			
			if (messageClass != nil) { 			
					// Check whether the current device is configured for sending SMS messages
				if ([messageClass canSendText]) {
					[self performSelector:@selector(displaySMSComposerSheet)];
				}
				else {	
					
					UIAlertView *alert5 = [[UIAlertView alloc] initWithTitle:@"Device not configured to send SMS/MMS." 
																	 message:nil 
																	delegate:self 
														   cancelButtonTitle:@"Ok"
														   otherButtonTitles:nil];
					
					[alert5 show];
					[alert5 release];				
					
				}
			}
			else {
				UIAlertView *alert6 = [[UIAlertView alloc] initWithTitle:@"Device not configured to send SMS/MMS." 
																 message:nil 
																delegate:self 
													   cancelButtonTitle:@"Ok"
													   otherButtonTitles:nil];
				
				[alert6 show];
				[alert6 release];
			}
		}
	}
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
	
	ABNewPersonViewController *newPersonViewController = [[ABNewPersonViewController alloc] init];
	newPersonViewController.newPersonViewDelegate = self;
	newPersonViewController.displayedPerson = person;
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc]
								   initWithTitle:@"Cancel"
								   style:UIBarButtonItemStyleBordered
								   target: self
								   action: @selector(cancelContact)] autorelease];
	newPersonViewController.navigationItem.leftBarButtonItem = addButton;
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newPersonViewController];
	[peoplePicker presentModalViewController:nav animated:YES];
	
	return YES;
}

-(void)cancelContact{
	[self dismissModalViewControllerAnimated:YES];
}


-(void)displayMailComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:[NSString stringWithFormat:@"%@", app.eventTitle]];
	
	
		// Set up recipients
		//NSArray *toRecipients = [NSArray arrayWithObject:@"ionut_gyn@yahoo.com"]; 
		//NSArray *ccRecipients = [NSArray arrayWithObjects:nil]; 
		//NSArray *bccRecipients = [NSArray arrayWithObject:nil]; 
	
		//[picker setToRecipients:toRecipients];
		//[picker setCcRecipients:ccRecipients];	
		//[picker setBccRecipients:bccRecipients];
	
		// Attach an image to the email
		//NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
		//NSData *myData = UIImagePNGRepresentation(event.eventImage2);
		//[NSData dataWithContentsOfFile:path];
		//[picker addAttachmentData:myData mimeType:@"image/png" fileName:nil];
	
		// Fill out the email body text
	

		//NSString *emailBody = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps?daddr==%@&amp;saddr=%f,%f", app.latitude, app.longitude]];
	NSString *emailBody = [NSString stringWithFormat:@"Hey check this out\n\nhttp://maps.google.com/maps?q=%f,%f", app.latitude, app.longitude];
	
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
	[picker release];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller 
		  didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			feedbackMsg = [NSString stringWithFormat:@"Mail sending canceled"];
			UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert4 show];
			[alert4 release];
			break;
		case MFMailComposeResultSaved:
			feedbackMsg = [NSString stringWithFormat:@"Mail saved"];
			UIAlertView *alert5 = [[UIAlertView alloc] initWithTitle:feedbackMsg
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert5 show];
			[alert5 release];
			break;
		case MFMailComposeResultSent:
			feedbackMsg = [NSString stringWithFormat:@"Mail sent"];
			UIAlertView *alert6 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert6 show];
			[alert6 release];
			break;
		case MFMailComposeResultFailed:
			feedbackMsg = [NSString stringWithFormat:@"Mail sending failed"];
			UIAlertView *alert7 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert7 show];
			[alert7 release];
			break;
		default:
			feedbackMsg = [NSString stringWithFormat:@"Mail not sent"];
			UIAlertView *alert8 = [[UIAlertView alloc] initWithTitle:feedbackMsg 
															 message:nil 
															delegate:self 
												   cancelButtonTitle:@"Ok"
												   otherButtonTitles:nil];
			
			[alert8 show];
			[alert8 release];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


-(void)displaySMSComposerSheet 
{
   
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;
	//picker.recipients = [NSArray arrayWithObject:@"3424234234"];
    //picker.body = @"Sent from iLoveGC on iPhone";
    NSString *content = [NSString stringWithFormat: @"Hey check this out! %@ - Address: %@ %@ %@ Sent from iLoveGC on iPhone", app.eventTitle, app.street, app.region, app.postcode];
    picker.body = content;
	[self presentModalViewController:picker animated:YES];
	[picker release];
   	//NSString *stringURL = @"mms:+40727986645";
	//NSURL *url = [NSURL URLWithString:stringURL];
	//[[UIApplication sharedApplication] openURL:url];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


- (void)dealloc {
	
	[adress release];
	[suburb release];
	[str release];
	[country release];
	[pos release];
	
	[view2 release];
	[tableView release];
	
	//[feedbackMsg release];
	//[sheet release];

	[contact release];
	[share release];

	[app release];
	[image release];
	[titleLabel release];
    [super dealloc];
}


@end
