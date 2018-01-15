//
//  CGResetNameResult.h
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGResetIconModel;

/**
 重置的错误类型

 - CGResetErrorTypeUnknown: 未知错误
 - CGResetErrorTypeNone: 没有错误
 - CGResetErrorTypeMoveCacheFolder: 移动到缓存目录，需要后续处理
 - CGResetErrorTypeNoChangeFileName: 没有更改文件名
 - CGResetErrorTypeExisted: 文件名重复
 - CGResetErrorTypeNotMoveCacheFolder: 不能移动到缓存目录
 
 */
typedef NS_ENUM(NSInteger, CGResetErrorType) {
    CGResetErrorTypeUnknown = -1,
    CGResetErrorTypeNone,
    CGResetErrorTypeMoveCacheFolder,
    CGResetErrorTypeNoChangeFileName,
    CGResetErrorTypeExisted,
    CGResetErrorTypeNotMoveCacheFolder,
};

@interface CGResetNameResult : NSObject

@property (nonatomic, strong, readonly) CGResetIconModel *imageModel;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, assign) CGResetErrorType errorType;
/** 文件名重复时的缓存路径 */
@property (nonatomic, strong) NSString *cacheFilePath;

@property (nonatomic, strong) NSError *resetError;

- (instancetype)initWithImageModel:(CGResetIconModel *)imageModel;

@end
