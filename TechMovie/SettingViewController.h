//
//  SettingViewController.h
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tagField;
@property NSString *tagString;

- (IBAction)back:(id)sender;
@end
