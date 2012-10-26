//
//  CreditsViewController.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/28/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditsViewController : UIViewController

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *creditsNavBar;
@property (weak, nonatomic) IBOutlet UIWebView *creditsWebView;

@end
