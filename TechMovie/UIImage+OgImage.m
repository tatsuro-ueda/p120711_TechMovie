//
//  UIImage+OgImage.m
//  GetOgImage
//
//  Created by 達郎 植田 on 12/08/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+OgImage.h"
#import "NSString+Encode.h"

@implementation UIImage (OgImage)

// get URL of og:image by [NSURL ogImageWithURL:url]
+ (UIImage *)ogImageWithURL:(NSURL *)url
{	
    // Get the web page HTML
    NSString *data_str = [NSString encodedStringWithContentsOfURL:url];
    
    // prepare regular expression to find text
    NSError *error   = nil;
    NSRegularExpression *regexp =
    [NSRegularExpression regularExpressionWithPattern:
     @"<meta property=\"og:image\" content=\".+\""
                                              options:0
                                                error:&error];
    
    // find by regular expression
    NSTextCheckingResult *match =
    [regexp firstMatchInString:data_str options:0 range:NSMakeRange(0, data_str.length)];
    
    // get the first result
    NSRange resultRange = [match rangeAtIndex:0];
    NSLog(@"match=%@", [data_str substringWithRange:resultRange]); 
    
    if (match) {
        
        // get the og:image URL from the find result
        NSRange urlRange = NSMakeRange(resultRange.location + 35, resultRange.length - 35 - 1);
        
        // make image with data from og:image URL
        NSURL *urlOgImage = [NSURL URLWithString:[data_str substringWithRange:urlRange]];
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:urlOgImage]];
    }
    return nil;
}

@end
