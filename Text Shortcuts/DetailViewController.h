//
//  DetailViewController.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class Shortcut;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
