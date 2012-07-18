//
//  WebViewController.h
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property NSURL *URLForSegue;
@property (strong, nonatomic) IBOutlet UIView *actIndicatorBack;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actIndicator;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
- (IBAction)back:(id)sender;
@end
