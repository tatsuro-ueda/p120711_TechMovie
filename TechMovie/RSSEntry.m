//
//  RSSEntry.m
//  TestRSSReader
//
//  Created by 達郎 植田 on 12/07/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry

@synthesize url = _url;
@synthesize date = _date;
@synthesize title = _title;
@synthesize text = _text;
@synthesize urlOgImage = _urlOgImage;

- (id)init
{
    self = [super init];
    if (self) {
        
        // インスタンス変数の初期化
        _url = nil;
        _date = nil;
        _title = nil;
        _text = nil;
        _urlOgImage = nil;
    }
    return self;
}

@end
