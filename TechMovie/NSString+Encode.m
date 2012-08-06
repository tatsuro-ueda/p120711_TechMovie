//
//  NSString+Encode.m
//  GetOgImage
//
//  Created by 達郎 植田 on 12/08/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Encode.h"

@implementation NSString (Encode)

+ (NSString *)encodedStringWithContentsOfURL:(NSURL *)url
{
    // Get the web page HTML
    NSData *data = [NSData dataWithContentsOfURL:url];
    
	// response
	int enc_arr[] = {
		NSUTF8StringEncoding,			// UTF-8
		NSShiftJISStringEncoding,		// Shift_JIS
		NSJapaneseEUCStringEncoding,	// EUC-JP
		NSISO2022JPStringEncoding,		// JIS
		NSUnicodeStringEncoding,		// Unicode
		NSASCIIStringEncoding			// ASCII
	};
	NSString *data_str = nil;
	int max = sizeof(enc_arr) / sizeof(enc_arr[0]);
	for (int i=0; i<max; i++) {
		data_str = [
                    [NSString alloc]
                    initWithData : data
                    encoding : enc_arr[i]
                    ];
		if (data_str!=nil) {
			break;
		}
	}
	return data_str;    
}

@end
