//
//  NavigationViewController2.m
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController2 : UINavigationController

@end

@implementation NavigationViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Tag2"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"おもしろ" forKey:@"Tag2"];
        }
        self.tabBarItem.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"Tag2"];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
