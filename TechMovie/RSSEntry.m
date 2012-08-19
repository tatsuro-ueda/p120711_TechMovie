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
@synthesize ogImageURL = _ogImageURL;
@synthesize isNewEntry = _isNewEntry;

- (id)init
{
    self = [super init];
    if (self) {
        
        // インスタンス変数の初期化
        _url = nil;
        _date = nil;
        _title = nil;
        _text = nil;
        _ogImageURL = nil;
        _isNewEntry = NO;
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _url = [aDecoder decodeObjectForKey:@"url"];
        _date = [aDecoder decodeObjectForKey:@"date"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        _text = [aDecoder decodeObjectForKey:@"text"];
        _ogImageURL = [aDecoder decodeObjectForKey:@"ogImageURL"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_url forKey:@"url"];
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_text forKey:@"text"];
    [aCoder encodeObject:_ogImageURL forKey:@"ogImageURL"];
}

@end
