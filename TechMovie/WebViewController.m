//
//  WebViewController.m
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;
@synthesize URLForSegue;
@synthesize actIndicatorBack;
@synthesize actIndicator;
@synthesize navBar;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.URLForSegue]];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setActIndicatorBack:nil];
    [self setActIndicator:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // 動画なので回転に対応するが上下反対はアウト
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [actIndicator startAnimating];
    actIndicatorBack.hidden = NO;
    self.navBar.topItem.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [actIndicator stopAnimating];
    actIndicatorBack.hidden = YES;
    self.navBar.topItem.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
