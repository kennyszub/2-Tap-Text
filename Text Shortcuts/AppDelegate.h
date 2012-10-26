//
//  AppDelegate.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortcutDataController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *path;
    ShortcutDataController *aDataController;
}

@property (strong, nonatomic) UIWindow *window;

@end
