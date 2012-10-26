//
//  AddShortCutViewControllerViewController.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/22/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@protocol AddShortCutViewControllerDelegate;

@interface AddShortCutViewControllerViewController : UITableViewController <UITextFieldDelegate, ABPeoplePickerNavigationControllerDelegate> {
    BOOL editingMode;
}
@property (weak, nonatomic) id <AddShortCutViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberInput;
@property (weak, nonatomic) IBOutlet UITextField *messageInput;
- (IBAction)addContact:(UIButton *)sender;


@property (weak, nonatomic) NSString *loadedNameInput;
@property (weak, nonatomic) NSString *loadedPhoneInput;
@property (weak, nonatomic) NSString *loadedMessageInput;



- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (void) setPrefilledUITextWithName:(NSString *) name
                             number:(NSString *) number
                            message:(NSString *) message;

@end


@protocol AddShortCutViewControllerDelegate <NSObject>

- (void) addShortCutViewControllerDidCancel:(AddShortCutViewControllerViewController *) controller;
- (void) addShortcutviewcontrollerDidFinish:(AddShortCutViewControllerViewController *) controller
                                       name:(NSString *) name
                                   phoneNum:(NSString *) number
                                    message:(NSString *) message;



@end