//
//  FeedsTableViewController2.m
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedsTableViewController.h"

@interface FeedsTableViewController1 : FeedsTableViewController

- (IBAction)showSetting:(id)sender;

@end

@implementation FeedsTableViewController1

// Storyboardファイルからインスタンスが作成されたときに
// 使われるイニシャライザメソッド
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // インスタンス変数の初期化
        _itemsArray = nil;
        _tagString = @"Tag1";
    }
    return self;
}

- (IBAction)showSetting:(id)sender {
//    [self performSegueWithIdentifier:@"showSetting" sender:_tagString];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *filePath = [directory stringByAppendingPathComponent:@"data.dat"];

    BOOL successful = 
}

- (IBAction)refresh:(id)sender {
    [self requestTableData];
}

@end
