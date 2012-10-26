//
//  AppDelegate.m
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import "AppDelegate.h"
#import "ShortcutDataController.h"
#import "MasterViewController.h"
#import "Shortcut.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        NSLog(@"first time");
        [fileManager copyItemAtPath:bundle toPath:path error:&error];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        [NSKeyedArchiver archiveRootObject:temp toFile:path];
    }
    NSLog(@"%@", path);

    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    MasterViewController *firstViewController = (MasterViewController *)[[navigationController viewControllers] objectAtIndex:0];
    
    aDataController = [[ShortcutDataController alloc] initWithPath:path];
    firstViewController.dataController = aDataController;
    
    NSLog(@"didfinishlaunching");
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [NSKeyedArchiver archiveRootObject:aDataController.masterShortcutList toFile:path];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [NSKeyedArchiver archiveRootObject:aDataController.masterShortcutList toFile:path];
}

@end
