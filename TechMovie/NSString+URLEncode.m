//
//  NSString+URLEncode.m
//  TechMovie
//
//  Created by 達郎 植田 on 12/08/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(encoding));
}

@end
