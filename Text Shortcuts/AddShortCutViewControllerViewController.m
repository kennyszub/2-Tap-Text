//
//  AddShortCutViewControllerViewController.m
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/22/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import "AddShortCutViewControllerViewController.h"

@interface AddShortCutViewControllerViewController ()

@end

@implementation AddShortCutViewControllerViewController

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */
@synthesize nameInput;
@synthesize phoneNumberInput;
@synthesize messageInput;

@synthesize loadedNameInput;
@synthesize loadedPhoneInput;
@synthesize loadedMessageInput;

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    if (editingMode) {
        nameInput.text = loadedNameInput;
        phoneNumberInput.text = loadedPhoneInput;
        messageInput.text = loadedMessageInput;
        editingMode = NO;
    }
    nameInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    messageInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    [messageInput becomeFirstResponder];
    
    self.navigationController.navigationBar.tintColor = [[UIColor alloc] initWithRed:65.0/255.0 green:121.0/255.0 blue:189.0/255.0 alpha:1.0];

    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setNameInput:nil];
    [self setPhoneNumberInput:nil];
    [self setMessageInput:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) setPrefilledUITextWithName:(NSString *)name number:(NSString *)number message:(NSString *)message {
    [self setLoadedNameInput:name];
    [self setLoadedPhoneInput:number];
    [self setLoadedMessageInput:message];
    editingMode = YES;
}


#pragma mark - Table view data source


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (IBAction)cancel:(id)sender {
    [[self delegate] addShortCutViewControllerDidCancel:self];
    
}

- (IBAction)done:(id)sender {
    [[self delegate] addShortcutviewcontrollerDidFinish:self name:self.nameInput.text phoneNum:self.phoneNumberInput.text message:self.messageInput.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.nameInput) || (textField == self.phoneNumberInput) || (textField == messageInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}




- (IBAction)addContact:(UIButton *)sender {
    NSLog(@"adding contact");
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    picker.peoplePickerDelegate = self;
    [self presentModalViewController:picker animated:YES];

}




- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    NSLog(@"got person record");
    return YES;
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //retrieve number
    NSLog(@"tapped number");
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
    NSString *phone = nil;
    if ((ABMultiValueGetCount(phoneNumbers) > 0)) {
        phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, identifier);
    } else {
        phone = @"[None]";
    }
    NSLog(@"retrieved number: %@", phone);
    
    //retrieve first and last name
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"retrieved first name: %@", firstName);
    NSLog(@"retrieve last name: %@", lastName);
    
    if ([nameInput.text length] == 0) {
        NSLog(@"setting name input");
        if ((firstName == nil) && (lastName == nil)) {
        
        } else if ((firstName == nil) && (lastName != nil)) {
            nameInput.text = lastName;
        } else if ((firstName != nil) && (lastName == nil)) {
            nameInput.text = firstName;
        } else {
            NSString* fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            nameInput.text = fullName;
        }
    } else {
        //when nameinput has people
        if ((firstName == nil) && (lastName == nil)) {
            
        } else if ((firstName == nil) && (lastName != nil)) {
            NSString* fullNames = [NSString stringWithFormat:@"%@, %@", nameInput.text, lastName];
            nameInput.text = fullNames;
        } else if ((firstName != nil) && (lastName == nil)) {
            NSString* fullNames = [NSString stringWithFormat:@"%@, %@", nameInput.text, firstName];
            nameInput.text = fullNames;
        } else {
            NSString* fullNames = [NSString stringWithFormat:@"%@, %@ %@", nameInput.text, firstName, lastName];
            nameInput.text = fullNames;
        }
    }
    
    if ([phoneNumberInput.text length] == 0) {
        phoneNumberInput.text = phone;
    } else {
        NSString* fullNumbers = [NSString stringWithFormat:@"%@, %@", phoneNumberInput.text, phone];
        NSLog(@"%@", fullNumbers);
        phoneNumberInput.text = fullNumbers;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}



@end
