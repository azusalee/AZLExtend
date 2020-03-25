//
//  NSString+ALHelper.m
//  ALExampleTest
//
//  Created by 李梓洪 on 2018/5/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NSString+AZLHelper.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (ALHelper)

- (NSString *)azl_md5String{
    const char *cStr = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return [md5Str copy];
}

- (NSString *)azl_base64String{
    NSData *base64Data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [base64Data base64EncodedStringWithOptions:0];
}

- (NSString *)azl_utf8StringFromBase64{
    NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
}

- (NSString *)azl_urlEncodeString{
    NSMutableCharacterSet *charSet = [NSMutableCharacterSet alphanumericCharacterSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charSet];
}

- (NSArray *)azl_rangesWithString:(NSString*)subString{
    if (subString.length == 0) {
        return @[];
    }
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    NSRange range = NSMakeRange(0, 0);
    NSUInteger nextStartIndex = 0;
    while (1) {
        nextStartIndex = range.location+range.length;
        range = [self rangeOfString:subString options:NSCaseInsensitiveSearch range:NSMakeRange(nextStartIndex, self.length-nextStartIndex)];
        if (range.length > 0) {
            [ranges addObject:[NSValue valueWithRange:range]];
        }else{
            break;
        }
    }
    return ranges.copy;
}

+ (NSString*)azl_forceDecodeUtf8Data:(NSData *)data{

    NSString *utf8String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 尝试能不能转成utf8
    if (!utf8String) {
        // 数据含有非utf8字符
        //NSLog(@"解析log时检测到非utf8字符，尝试把可以解析的部分显示");
        NSMutableString *mutString = [[NSMutableString alloc] init];
        NSUInteger dataLength = data.length;
        NSUInteger pos = 0;
        NSUInteger stepLength = 1024;
        int trycount = 0;
        while (1) {
            if (pos+stepLength > dataLength) {
                stepLength = dataLength-pos;
            }
            NSData *subData = [data subdataWithRange:NSMakeRange(pos, stepLength)];
            NSString *tmpString = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
            if (!tmpString) {
                //检测到有问题数据的位置
                //尝试调整长度再解析
                if (trycount == 0) {
                    stepLength = 1025;
                }else if (trycount == 1) {
                    stepLength = 1026;
                }else if (trycount == 2) {
                    stepLength = 1027;
                }else if (trycount == 4) {
                    stepLength = 128;
                }else if (trycount == 5) {
                    stepLength = 129;
                }else if (trycount == 6) {
                    stepLength = 130;
                }
                trycount += 1;
                if (trycount <= 7) {
                    continue;
                }
                
                //经过多次尝试也解不了，用latin编码显示
                tmpString = [[NSString alloc] initWithData:subData encoding:NSISOLatin1StringEncoding];
            }
            
            [mutString appendString:tmpString];
            
            pos += stepLength;
            trycount = 0;
            if (pos == dataLength) {
                break;
            }
        }
        utf8String = mutString.copy;
    }
    
    return utf8String;
}

- (NSDictionary *)azl_queryDict{
    NSString *query = self;
    NSArray *array = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *queryDict = [[NSMutableDictionary alloc] init];
    
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *keyValue = [obj componentsSeparatedByString:@"="];
        if (keyValue.count > 1) {
            queryDict[keyValue[0]] = keyValue[1];
        }
    }];
    
    return queryDict.copy;
}

@end
