//
//  NSString+URLEncode.h
//  TechMovie
//
//  Created by 達郎 植田 on 12/08/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

@end
