//
//  CGResetIconName.h
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGChangeIconNameRule;

/**
 重新设置项目 icon 的文件名
 */
@interface CGResetIconName : NSObject

@property (nonatomic, strong) CGChangeIconNameRule *changeNameRule;

/// icon 文件扩展，默认为png
@property (nonatomic, strong) NSString *iconPathExtension;

@property (nonatomic, strong) NSString *targetProjectIconFolderPath;

- (void)startReset;

@end
