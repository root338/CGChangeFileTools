//
//  CGChangeIconNameRule.h
//  TestIcon
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 修改 icon 的规则类型

 - CGChangeIconNameRuleTypeDefalut: 默认的规则，提供文件名头部 + 图片宽度 + 图片高度(以指定分隔符(mark 实例属性)分隔, 重复文件以"-n", (n 表示数字) 叠加)
 */
typedef NS_ENUM(NSInteger, CGChangeIconNameRuleType) {
    
    CGChangeIconNameRuleTypeDefalut,
    
};

@interface CGChangeIconNameRule : NSObject

@property (nonatomic, assign) CGChangeIconNameRuleType ruleType;

@property (nonatomic, strong) NSString *iconNameHeader;

/// 分隔符，默认 @"_"
@property (nonatomic, strong) NSString *mark;

@end
