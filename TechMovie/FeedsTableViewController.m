//
//  FeedsTableViewController.m
//  TechMovie
//
//  Created by 達郎 植田 on 12/07/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedsTableViewController.h"
#import "RSSParser.h"
#import "RSSEntry.h"
#import "WebViewController.h"
#import "SettingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFJSONRequestOperation.h"
#import "UIImage+GIF.h"

const NSString *kStringURLHatebu = 
@"http://pipes.yahoo.com/pipes/pipe.run?_id=6adb7c2f4644af358fbe273293c80e43&_render=rss&tag=";

// リストアイテムのソート用関数
// 日付の降順ソートで使用する
static NSInteger dateDescending(id item1, id item2, void *context)
{
    // ここでは比較対象が必ず「RSSListTableDataSource」クラスの
    // 「_listItemsArray」の要素となる（それ以外の場所から呼び出さないため）
    
    NSDate *date1 = [item1 date];
    NSDate *date2 = [item2 date];
    
    return [date2 compare:date1];
}

@interface FeedsTableViewController ()

@end

@implementation FeedsTableViewController
@synthesize itemsArray = _itemsArray;
@synthesize tableView = _tableView;

// Storyboardファイルからインスタンスが作成されたときに
// 使われるイニシャライザメソッド
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // インスタンス変数の初期化
        _itemsArray = nil;
        _tagString = @"Tag";
        _ogImages = [NSMutableArray array];
        _bkmImages = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setItemsArray:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // 縦方向のみ対応する
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    // 親クラスの処理を呼び出す
    [super viewWillAppear:animated];
    
    // URLの配列を作成するためユーザーデフォルトからキーワードを読み込む
    NSString *keywordPlainString = [[NSUserDefaults standardUserDefaults] objectForKey:_tagString];
    
    // タブバーのタイトルを変える
    self.navigationController.title = keywordPlainString;
    
    // ナビゲーションアイテムのタイトルを変える
    self.navigationItem.title = [NSString stringWithFormat:@"「%@」の新着動画", keywordPlainString];
    
    //    [self requestTableData];
}

- (void)requestTableData
{
    // URLの配列を作成するためユーザーデフォルトからキーワードを読み込む
    NSString *keywordPlainString = [[NSUserDefaults standardUserDefaults] objectForKey:_tagString];
    
    // タブバーのタイトルを変える
    self.navigationController.title = keywordPlainString;
    
    // ナビゲーションアイテムのタイトルを変える
    self.navigationItem.title = [NSString stringWithFormat:@"「%@」の新着動画", keywordPlainString];
    
    // リロードが必要ならば行う
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"読み込んでいます"
                                                        message:@"\n\n"
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:nil];
    _progressView = [[UIProgressView alloc]
                     initWithFrame:CGRectMake(30.0f, 60.0f, 225.0f, 90.0f)];
    [alertView addSubview:_progressView];
    [_progressView setProgressViewStyle: UIProgressViewStyleBar];
    [alertView show];
    
    // 別スレッドを立てる
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        
        // RSSファイルのURLをつくる
        NSString *escapedUrlString = [keywordPlainString 
                                      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *myPipeURLString = 
        [NSString stringWithFormat:@"%@%@", kStringURLHatebu, escapedUrlString];
        
        // urlArrayをつくる
        NSArray *urls = [NSArray arrayWithObject:myPipeURLString];
        NSMutableArray *urlArray = [NSMutableArray array];
        for (NSString *str in urls) {
            NSURL *url = [NSURL URLWithString:str];
            if (url) {
                [urlArray addObject:url];
            }
        }
        
        // RSSファイルを読み込む
        [self reloadFromContentsOfURLsFromArray:urlArray];
        
        // メインスレッドに戻す
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        [mainQueue addOperationWithBlock:^{
            
            // テーブル更新
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            [self.tableView reloadData];

            // 新着動画の件数を表示する
            NSInteger numNewEntry = 0;
            for (RSSEntry *entry in self.itemsArray) {
                if (entry.isNewEntry) {
                    numNewEntry++;
                }
            }
            UIAlertView *alertView = [[UIAlertView alloc] init];
            if (numNewEntry > 0) {
                alertView.title = [NSString stringWithFormat:@"%d 件の新着動画があります",numNewEntry]; 
            } 
            else {
                alertView.title = @"新着動画はありません";
            }
            alertView.message = nil;
            alertView.delegate = self;
            [alertView addButtonWithTitle:@"OK"];
            [alertView show];

        }];
    }];
}    

#pragma mark - Table view data source

// リストテーブルのアイテム数を返すメソッド
// 「UITableViewDataSource」プロトコルの必須メソッド
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

// リストテーブルに表示するセルを返すメソッド
// 「UITableViewDataSource」プロトコルの必須メソッド
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    // 範囲チェックを行う
    if (indexPath.row < self.itemsArray.count) {
        
        // セルを作成する
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        // og:imageのビュー
        UIImageView *imageViewOgImage = (UIImageView *)[cell viewWithTag:5];
        NSURL *ogImageURL = [[self.itemsArray objectAtIndex:indexPath.row] ogImageURL];

        if (ogImageURL != nil) {
            UIImage* li = [UIImage animatedGIFNamed:@"loading3"];
            [imageViewOgImage setImageWithURL:ogImageURL
                             placeholderImage:li];
        }
        else {
            UIImage *noImage = [UIImage imageNamed:@"noImage2.png"];
            imageViewOgImage.image = noImage;
        }
        
        // 文字列を設定する
        UILabel *labelTitle = (UILabel*)[cell viewWithTag:1];
        UILabel *labelDate = (UILabel*)[cell viewWithTag:2];
        UILabel *labelDetail = (UILabel*)[cell viewWithTag:3];
        UILabel *labelHatebuNumber = (UILabel*)[cell viewWithTag:4];
        UILabel *labelNew = (UILabel*)[cell viewWithTag:6];
        
        // タイトルラベル
        labelTitle.text = [[NSString alloc] initWithString:
                       [[self.itemsArray objectAtIndex:indexPath.row] title]];
        
        // 「N日前」というラベル
        NSDate *datePub = [[self.itemsArray objectAtIndex:indexPath.row] date];
        NSTimeInterval t = [datePub timeIntervalSinceNow];
        NSInteger intervalDays = - t / (60 * 60 * 12);
        labelDate.text = [[NSString alloc] initWithFormat:@"%d 日前", intervalDays];
        
        // 「NEW」ラベル
        if ([[self.itemsArray objectAtIndex:indexPath.row] isNewEntry]) {
            labelNew.text = @"NEW";
        }
        else {
            labelNew.text = nil;
        }

        // 詳細ラベル
        // nilチェックしないとクラッシュする
        NSString *s = [[self.itemsArray objectAtIndex:indexPath.row] text];
        if (s == nil) {
            labelDetail.text = @"";
        }
        else {
            labelDetail.text = [[NSString alloc] initWithString:s];
        }
        
        // はてなに問い合わせるURLをつくる
        NSString *urlStringHatena = @"http://b.hatena.ne.jp/entry/jsonlite/?url=";
        NSString *urlStringTarget = 
        [NSString stringWithFormat:@"%@", [[self.itemsArray objectAtIndex:indexPath.row] url]];
        NSString *urlStringWhole = [NSString stringWithFormat:@"%@%@", urlStringHatena, urlStringTarget];
        NSURL *url = [NSURL URLWithString:urlStringWhole];
        
        // リクエストを送り、返ってきたJSONを解析してはてブ数を見つけ出す
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSInteger count = [[JSON valueForKeyPath:@"count"] integerValue];
            
            // はてブ数を表示させる
            labelHatebuNumber.text = [NSString stringWithFormat:@"%d users", count];
        } failure:nil];
        [operation start];
    }
    return cell;
}

// URLの配列を受け取り、「_listItemsArray」の内容を設定するメソッド
// 配列の各要素は「NSURL」クラスのインスタンスとする
- (void)reloadFromContentsOfURLsFromArray:(NSArray *)urlsArray
{
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
    
    for (NSURL *url in urlsArray) {
        @autoreleasepool {
            
            // URLから読み込む
            NSArray *itemsArray = [self itemsArrayFromContentsOfURL:url];
            
            // 配列に追加する
            [newArray addObjectsFromArray:itemsArray];
        }
    }
    // 作成した配列を日付をキーにして、降順ソートする
    [newArray sortUsingFunction:dateDescending context:NULL];
    
    // データメンバーに設定する
    self.itemsArray = newArray;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@.dat", _tagString];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    BOOL successful = [NSKeyedArchiver archiveRootObject:self.itemsArray toFile:filePath];
    if (successful) {
        NSLog(@"%@", @"データの保存に成功しました。");
    }
}

// URLからファイルを読み込み、アイテムの配列を返すメソッド
- (NSArray *)itemsArrayFromContentsOfURL:(NSURL *)url
{
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:0];
    RSSParser *parser = [[RSSParser alloc] init];
    
    // URLから読み込む
    if ([parser parseContentsOfURL:url progressView:_progressView tag:_tagString]) {
        
        // 記事を読み込む
        [newArray addObjectsFromArray:[parser entries]];
    }
    
    return newArray;
}

// 記事のURLを取得する
- (NSURL *)urlAtIndex:(NSInteger)index
{
    NSURL *url = nil;
    
    // 範囲チェック
    if (index < self.itemsArray.count) {
        
        url = [[self.itemsArray objectAtIndex:index] url];
    }
    return url;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    // データソースからURLを取得する
    NSURL *url;
    url = [self urlAtIndex:indexPath.row];
    
    // WebViewを開く
    [self performSegueWithIdentifier:@"showWebView" sender:url];
}

#pragma warning

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showWebView"]) {
        WebViewController *controller = segue.destinationViewController;
        NSLog(@"sender = %@", sender);
        controller.URLForSegue = (NSURL *)sender;
        controller.hidesBottomBarWhenPushed = YES;
    }
    else if ([segue.identifier isEqualToString:@"showSetting"]) {
        SettingViewController *controller = segue.destinationViewController;
        controller.tagString = (NSString *)sender;
    }
}

@end
