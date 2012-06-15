//
//  AdressBook.m
//  MyProject
//
//  Created by ANDREI A on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdressBook.h"
#import "AppEvents.h"
#import "ILoveGCAppDelegate.h"


@implementation AdressBook

@synthesize tableView, list, ap, altlist;


- (void)viewDidLoad {
	[super viewDidLoad];
	
		//Set the title
	self.navigationItem.title = @"All Contacts";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	int count = [list count];
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}   
		
			// Set up the cell...
	ABRecordRef person = (ABRecordRef)[list objectAtIndex:indexPath.row];
	NSString *firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	cell.textLabel.text = firstName;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	ABRecordRef person = ABPersonCreate();
	person = (ABRecordRef)[list objectAtIndex:indexPath.row];
	
	CFErrorRef error = NULL;
	
		//Phone number is a list of phone number, so create a multivalue    
	ABMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	BOOL didAdd = ABMultiValueAddValueAndLabel(phoneNumberMultiValue, ap.phone, kABOtherLabel, NULL);
		//ABMultiValueAddValueAndLabel(phoneNumberMultiValue , ap.phone, kABPersonPhoneMobileLabel, NULL);
	
	if(didAdd == YES){
		
		ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, &error);
		NSString *firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		if(error == NULL){
			ABUnknownPersonViewController *controller = [[[ABUnknownPersonViewController alloc] init]autorelease];
			controller.unknownPersonViewDelegate = self;			
			controller.displayedPerson = person;
			controller.allowsAddingToAddressBook = YES;
				//controller.allowsActions = YES;
			
			controller.navigationItem.title = firstName;
			[self.navigationController pushViewController:controller animated:YES];		
			//[controller release];
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
	
	
		//UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
	CFRelease(person);
	CFRelease(phoneNumberMultiValue);	

}

- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


	// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person 
						   property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}



/*- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person{
	
	[self dismissModalViewControllerAnimated:YES];	
}

- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue{
	
	[self dismissModalViewControllerAnimated:YES];
}*/

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
	[self dismissModalViewControllerAnimated:YES];
}


/*- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	self.searchBar.showsCancelButton = YES;
	
	self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	self.searchBar.text = nil;
	self.searchBar.showsCancelButton = NO;
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	g = -1;
		//[altlist removeAllObjects];
	if([searchText isEqualToString:@""]){
		
		[tableView reloadData];
		return;
	}
	
	NSInteger counter = 0;
	

	for(int i = 0;i<[list count];i++)
	{
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
		
		ABRecordRef person = (ABRecordRef)[list objectAtIndex:i];
		NSString *str = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
		NSComparisonResult result = [str compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0,  [searchText length])];
		
		if (result == NSOrderedSame)
		{		
			[altlist addObject:str];
		}
		
		/*NSRange r = [name rangeOfString:searchText];
		 if(r.location != NSNotFound)
		 {
		 if(r.location== 0)
		 {
		 [tabledata addObject:name];
		 }
		 }
		
		
		counter++;
		
		[pool release];
		
	}
	
	[tableView reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[altlist removeAllObjects];
	[altlist addObjectsFromArray:list];
	
	@try{
		[tableView reloadData];
	}
	@catch(NSException *e){
		
	}
	
	[self.searchBar resignFirstResponder];
	self.searchBar.text = @"";
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.searchBar resignFirstResponder];
	g = -1;
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
	[altlist release];
	[ap release];
	[list release];
	[tableView release];
    [super dealloc];
}


@end
