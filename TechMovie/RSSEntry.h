//
//  RSSEntry.h
//  TestRSSReader
//
//  Created by 達郎 植田 on 12/07/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSEntry : NSObject<NSCoding>

@property (strong) NSURL *url;
@property (strong) NSDate *date;
@property (strong) NSString *title;
@property (strong) NSString *text;
@property (copy, atomic) NSURL *ogImageURL;
@property BOOL isNewEntry;

@end
