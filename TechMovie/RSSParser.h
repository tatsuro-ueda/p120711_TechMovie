//
//  RSSParser.h
//  TestRSSReader
//
//  Created by 達郎 植田 on 12/07/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSSEntry;
@interface RSSParser : NSObject<NSXMLParserDelegate>
{
    UIProgressView  *_progressView;
    int             _totalLines;
}

// RSSの記事の配列
// 配列内の要素は「RSSEntry」クラスのインスタンスとする
@property (strong) NSMutableArray *entries;

// 解析中の情報
@property (strong, nonatomic) NSMutableArray *elementStack;
@property (strong, nonatomic) RSSEntry *curEntry;

- (BOOL)parseContentsOfURL:(NSURL *)url progressView:(UIProgressView *)progressView;
- (NSDate *)pubDateWithString:(NSString *)string;

@end
