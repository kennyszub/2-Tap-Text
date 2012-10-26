//
//  MasterViewController.m
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "ShortcutDataController.h"
#import "Shortcut.h"

#import "AddShortCutViewControllerViewController.h"

// ADD OUR OWN PRODUCT IDENTIFIER HERE!!!
#define kInAppPurchaseProUpgradeProductId @"unlimitedshortcuts"

@interface MasterViewController () <AddShortCutViewControllerDelegate> 

@end
 

@implementation MasterViewController
@synthesize dataController = _dataController;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
        
    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithImage:button.currentImage style:UIBarButtonItemStylePlain target:self action:@selector(onInfoButtonPressed:)];
        
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray* toolBarobjects = [[NSArray alloc] initWithObjects:flexibleSpaceLeft, infoButton, nil];
    [self setToolbarItems:toolBarobjects];
    
    [self.navigationController setToolbarHidden:NO];
    
    self.navigationController.navigationBar.tintColor = [[UIColor alloc] initWithRed:65.0/255.0 green:121.0/255.0 blue:189.0/255.0 alpha:1.0];
    self.navigationController.toolbar.tintColor = [[UIColor alloc] initWithRed:65.0/255.0 green:121.0/255.0 blue:189.0/255.0 alpha:1.0];
}
- (void) onInfoButtonPressed:(id)sender {
    NSLog(@"Info Button pressed");
    [self performSegueWithIdentifier:@"info" sender:self];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfMasterShortcutList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShortcutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Shortcut *shortcutAtIndex = [self.dataController objectInMasterShortcutListAtIndex:indexPath.row];
    [[cell textLabel] setText:shortcutAtIndex.nickname];
    [[cell detailTextLabel] setText:shortcutAtIndex.message];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray* masterList = self.dataController.masterShortcutList;
    Shortcut *shortcut = [masterList objectAtIndex:fromIndexPath.row];
    [masterList removeObject:shortcut];
    [masterList insertObject:shortcut atIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowAddShortCutView"]) {
        AddShortCutViewControllerViewController *addController = (AddShortCutViewControllerViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        addController.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"editShortcut"]) {
        NSLog(@"editing shortcut");
        AddShortCutViewControllerViewController *addController = (AddShortCutViewControllerViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
       

        Shortcut* currShortcut = [self.dataController objectInMasterShortcutListAtIndex:currentRow.row];
        NSLog(@"%d", currentRow.row);
        NSString* loadedName = currShortcut.nickname;
        NSString* loadedNum = currShortcut.phoneNum;
        NSString* loadedMessage = currShortcut.message;
        [addController setPrefilledUITextWithName:loadedName number:loadedNum message:loadedMessage];
        
        addController.delegate = self;
    }
}


- (void) addShortCutViewControllerDidCancel:(AddShortCutViewControllerViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) addShortcutviewcontrollerDidFinish:(AddShortCutViewControllerViewController *)controller name:(NSString *)name phoneNum:(NSString *)number message:(NSString *)message {
    if (!editingMode) {
        if ([name length] || [number length] || [message length]) {
            [self.dataController addShortcutWithName:name phoneNum:number message:message];
        }
    } else {
        [self.dataController.masterShortcutList removeObjectAtIndex:currentRow.row];
        [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:currentRow] withRowAnimation:UITableViewRowAnimationFade];
        if ([name length] || [number length] || [message length]) {
            [self.dataController addShortcutWithName:name phoneNum:number message:message atIndex:currentRow.row];
            
        }
        
    }
    [[self tableView] reloadData];
    [self dismissModalViewControllerAnimated:YES];
}



-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result 
{
    [self dismissModalViewControllerAnimated:YES];
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else 
        NSLog(@"Message failed");
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Shortcut* currShortcut = [self.dataController objectInMasterShortcutListAtIndex:indexPath.row];
    NSString* message = currShortcut.message;
    NSString* number = currShortcut.phoneNum;
    
    if (editingMode) {
        NSLog(@"editing mode");
        currentRow = indexPath;
        [self performSegueWithIdentifier:@"editShortcut" sender:self];
    } else {
        MFMessageComposeViewController* controller = [[MFMessageComposeViewController alloc] init];
        if ([MFMessageComposeViewController canSendText]) {
            controller.body =  message;
            //parse through receipients
            NSScanner* numberScanner = [NSScanner scannerWithString:number];
            [numberScanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@","]];
            NSCharacterSet* charactersToSkip = [NSCharacterSet characterSetWithCharactersInString:@","];
            NSString* substring = @"";
            NSMutableArray *substrings = [NSMutableArray array];
            while (![numberScanner isAtEnd]) {
                [numberScanner scanUpToCharactersFromSet:charactersToSkip intoString:&substring];
                [numberScanner scanCharactersFromSet:charactersToSkip intoString:NULL];
                NSLog(@"%@", substring);
                [substrings addObject:substring];
            }
            
            controller.recipients = substrings;
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
        }
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataController.masterShortcutList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    editingMode = editing;
    if (editing == YES) {
        addButton = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = addButton;
    }
    [super setEditing:editing animated:animated];
}

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    // check if 6 items in list or if upgrade has been purchased
    if (([self.dataController countOfMasterShortcutList] < 4) || [[NSUserDefaults standardUserDefaults] boolForKey:@"isUpgradePurchased"]) {
        [self performSegueWithIdentifier:@"ShowAddShortCutView" sender:sender];
    } else {
        askToPurchase = [[UIAlertView alloc] initWithTitle:@"Get Unlimited Shortcuts?" message:@"If you want unlimited text shortcuts, an In-App purchase is required; for only $0.99." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
        [askToPurchase show];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == askToPurchase) {
        if (buttonIndex == 1) {
            NSLog(@"Purchased");
            if ([SKPaymentQueue canMakePayments]) {
                // ADD PRODUCT ID HERE -------------------- !!!!!!!!!!!!!!!!!!!!!!!!!!!****************$$$$$
                productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"unlimitedshortcuts"]];
                productsRequest.delegate = self;
                [productsRequest start];
            } else {
                UIAlertView *tmp = [[UIAlertView alloc] initWithTitle:@"Prohibited" 
                                                              message:@"Parental Control is enabled - cannot make purchase"                     
                                                             delegate:self 
                                                    cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [tmp show];
            }
        } else {
            NSLog(@"Cancel");
        }
    }
}

/* ------------- In App Purchase Code ---------- */


- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    upgradeProduct = [products count] == 1 ? [products objectAtIndex:0] : nil;
    if (upgradeProduct) {
        NSLog(@"Product title: %@", upgradeProduct.localizedTitle);
        NSLog(@"Product description: %@", upgradeProduct.localizedDescription);
        NSLog(@"Product id: %@", upgradeProduct.productIdentifier);
        
        SKPayment *payment = [SKPayment paymentWithProduct:upgradeProduct];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    for (NSString* invalidProductId in response.invalidProductIdentifiers) {
        NSLog(@"Invalid product id: %@", invalidProductId);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}

// called when transaction status is updated
- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void) recordTransaction:(SKPaymentTransaction *)transaction {
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId]) {
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"upgradeTransactionReceipt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) provideContent:(NSString *) productId {
    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isUpgradePurchased"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Finished purchase");
        UIAlertView *finishedPurchase = [[UIAlertView alloc] initWithTitle:@"Thank You!" 
                                                      message:@"You now have unlimited shortcuts."                     
                                                     delegate:self 
                                            cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [finishedPurchase show];
    }
}

- (void) finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction", nil];
    if (wasSuccessful) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
}

// called when the transaction was successful
- (void) completeTransaction:(SKPaymentTransaction *) transaction {
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

// called when a transaction has been restored and and successfully completed
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

// called when a transaction has failed
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

@end
