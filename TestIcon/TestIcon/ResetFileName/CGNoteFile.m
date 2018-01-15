//
//  CGNoteFile.m
//  TestIcon
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGNoteFile.h"

@implementation CGNoteFile


/*
 
 NSError *readImageConfigError           = nil;
 NSMutableString *imageConfig            = [NSMutableString stringWithContentsOfFile:imageConfigPath encoding:NSUTF8StringEncoding error:&readImageConfigError];
 NSAssert1(readImageConfigError == nil, @"读取图片配置文件失败, Error: %@", readImageConfigError);
 
 NSString *pattern                       = @"[{][^{}]+[}]";
 NSError *createRegularExpressionError   = nil;
 NSRegularExpression *regularExpression  = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&createRegularExpressionError];
 
 NSAssert1(createRegularExpressionError == nil, @"创建匹配搜索对象失败, Error: %@", regularExpression);
 
 NSString *propertyPattern                       = @"\"[\\w]+\"[\\W]*:[\\W]*[\"]?[^\"\\n]+[\"]?";
 NSError *createPropertyRegularExpressionError   = nil;
 NSRegularExpression *propertyRegularExpression  = [NSRegularExpression regularExpressionWithPattern:propertyPattern options:NSRegularExpressionCaseInsensitive error:&createPropertyRegularExpressionError];
 
 NSArray<NSTextCheckingResult *> *textCheckingResultArray    = [regularExpression matchesInString:imageConfig options:NSMatchingReportCompletion range:NSMakeRange(0, imageConfig.length)];
 [textCheckingResultArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 
 NSString *imageDetailConfig = [imageConfig substringWithRange:obj.range];
 NSMutableDictionary<NSString *, id> *propertyDict   = [NSMutableDictionary dictionary];
 
 [propertyRegularExpression enumerateMatchesInString:imageDetailConfig options:NSMatchingReportCompletion range:NSMakeRange(0, imageDetailConfig.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
 
 if (result != nil) {
 
 NSString *propertyValue = [imageDetailConfig substringWithRange:result.range];
 
 }
 
 }];
 
 }];
 
 */

@end
