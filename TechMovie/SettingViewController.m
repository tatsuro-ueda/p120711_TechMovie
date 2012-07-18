//
//  SettingViewController.m
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize tagField;
@synthesize tagString = _tagString;

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
    
    tagField.text = [[NSUserDefaults standardUserDefaults] objectForKey:_tagString];
}

- (void)viewDidUnload
{
    [self setTagField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setObject:tagField.text forKey:_tagString];
    [tagField resignFirstResponder];
    return YES;
}

- (IBAction)back:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
