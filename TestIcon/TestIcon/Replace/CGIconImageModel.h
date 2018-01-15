//
//  CGIconImageModel.h
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AppKit;

@interface CGIconImageModel : NSObject

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong, readonly) NSImage *image;

/// 图片像素大小
@property (nonatomic, assign, readonly) NSSize imagePixelSize;

@end

/**
 图片替换结果
 */
@interface CGIconImageReplaceResult : NSObject

@property (nonatomic, strong) NSImage *originImage;
@property (nonatomic, strong) NSImage *replaceImage;

/**
 原始文件地址
 */
@property (nonatomic, strong) NSString *originFilePath;

/**
 替换文件地址
 */
@property (nonatomic, strong) NSString *replaceFilePath;

/**
 错误对象
 */
@property (nonatomic, strong) NSError *error;

@end
