//
//  CreditsViewController.m
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/28/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import "CreditsViewController.h"

@implementation CreditsViewController
@synthesize creditsNavBar;
@synthesize creditsWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    self.creditsNavBar.tintColor = [[UIColor alloc] initWithRed:65.0/255.0 green:121.0/255.0 blue:189.0/255.0 alpha:1.0];
    NSString *html = @"<!DOCTYPE html> <html> <head> <title>2-Tap Text</title> <style type=\"text/css\"> body { text-align:center; font-family:\"Century Gothic\", sans-serif; font-size:15px;} #title { font-weight:bold; font-size:25px; font-family:\"Century Gothic\", sans-serif; color:rgb(65, 121, 189); } .box { text-align:left; margin: 0px auto; } .align { /*border:5px solid blue;*/ width:295px; } #copyright {font-size:10px;} </style> </head> <body> <div id=\"title\">2-Tap Text</div> <br> <b>Developed by</b> <br>Ken Szubzda &amp; Samuel Ahn <br> <br><b>Questions/Comments?</b> <br><a href=\"mailto:2taptext@gmail.com\">2taptext@gmail.com</a> <br> <br>Please rate <a href=\"http://itunes.apple.com/us/app/2-tap-text/id523957178?ls=1&mt=8\"> 2-Tap Text</a> 5 stars! <br>We appreciate your support. <br> <br><b>Instructions</b> <div class=\"box align\"> -Press the \"+\" button to add a text shortcut. <br>-Enter in a text message and tap the blue \"+\" button in the Contact(s) field to select a recipient. <br>-Tap the button again to add additional recipients. <br>-Give your shortcut a custom name (if desired) by tapping the Custom Shortcut Name field. <br>-Once you have a shortcut created, just tap it to send your message. </div> <br><b>In-App Purchase</b> <div class=\"box align\"> -2-Tap Text comes with 4 free shortcuts. <br>-For unlimited shortcuts, you can make a $0.99 in-app purchase. Simply tap the \"+\" button once you have 4 shortcuts to make the purchase. <br>-To restore your purchase, press \"Buy\" again; you will not be charged if signed in with the purchasing account. <br> </div> <br><div id=\"copyright\">&copy; Copyright by Ken Szubzda &amp; Samuel Ahn 2012 <br>All Rights Reserved </div></body> </html>"; 
    [self.creditsWebView loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
        
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [self setCreditsNavBar:nil];
    [self setCreditsWebView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
