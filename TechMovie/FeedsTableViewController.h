//
//  FeedsTableViewController.h
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedsTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray         *_itemsArray;
    NSString        *_tagString;
    NSMutableArray  *_ogImages;
    NSMutableArray  *_bkmImages;
    UIProgressView  *_progressView;
}
// リストに表示するアイテムを格納する配列
// 各要素は「RSSEntry」クラスのインスタンスとする
@property (strong) NSArray *itemsArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (void)reloadFromContentsOfURLsFromArray:(NSArray *)urlsArray;
- (NSArray *)itemsArrayFromContentsOfURL:(NSURL *)url;
- (NSURL *)urlAtIndex:(NSInteger)index;
- (void)requestTableData;

@end
