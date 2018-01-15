//
//  CGResetIconModel.h
//  TestIcon
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGIconConfigModel, CGResetNameResult;

/**
 图片的可用链接

 - CGResetImagePathAvailableTypeIconOriginPath: 原图片路径
 - CGResetImagePathAvailableTypeCachePath: 缓存的路径
 - CGResetImagePathAvailableTypeDidResetPath: 重置后的路径
 */
typedef NS_ENUM(NSInteger, CGResetImagePathAvailableType) {
    
    CGResetImagePathAvailableTypeIconOriginPath,
    CGResetImagePathAvailableTypeCachePath,
    CGResetImagePathAvailableTypeDidResetPath,
};

@interface CGResetIconModel : NSObject

@property (nonatomic, assign) CGResetImagePathAvailableType availablePathType;

/// icon 原来的名字
@property (nonatomic, strong) NSString *iconName;
/// icon 重命名的名字
@property (nonatomic, strong) NSString *didResetIconName;
/// icon 所在的目录
@property (nonatomic, strong) NSString *folderPath;

/// icon 缓存的路径, 在重置文件名时，新文件名被占用的情况下会设置
@property (nonatomic, strong) NSString *cacheFilePath;

/// icon 加载图片
@property (nonatomic, strong, readonly) NSImage *image;

@property (nonatomic, assign, readonly) NSSize imagePixelSize;

/// 是否已关联到配置文件
@property (nonatomic, assign) BOOL isRelation;

@end


@interface CGIconNameSameGroupModel : NSObject

/// icon 图片 json 配置内容
@property (nonatomic, strong) CGIconConfigModel *iconConfigModel;

@property (nonatomic, readonly) NSInteger count;

/// 创建 icon 对象 push
- (void)push:(CGResetIconModel *)iconModel;
- (CGResetIconModel *)pop;

@end
