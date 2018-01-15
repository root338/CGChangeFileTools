//
//  CGIconReplace.h
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 替换项目icon图标
 */
@interface CGIconReplace : NSObject

/// icon 文件扩展，默认为png
@property (nonatomic, strong) NSString *iconPathExtension;

@property (nonatomic, strong) NSString *iconFolderPath;
@property (nonatomic, strong) NSString *targetProjectIconFolderPath;

- (void)startReplace;

@end
