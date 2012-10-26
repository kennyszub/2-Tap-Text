//
//  MasterViewController.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"


@class ShortcutDataController;

@interface MasterViewController : UITableViewController <MFMessageComposeViewControllerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver> {
    BOOL editingMode;
    NSIndexPath *currentRow;
    UIBarButtonItem *addButton;
    
    //In App purchase variables
    UIAlertView* askToPurchase;
    SKProductsRequest *productsRequest;
    SKProduct *upgradeProduct;
}

@property (strong, nonatomic) ShortcutDataController *dataController;
- (IBAction)addButtonTapped:(UIBarButtonItem *)sender;

- (void) recordTransaction:(SKPaymentTransaction *)transaction;
- (void) provideContent:(NSString *) productId;
- (void) finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful;
- (void) completeTransaction:(SKPaymentTransaction *) transaction;


@end
