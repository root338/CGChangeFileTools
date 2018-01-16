//
//  CGAddPropertyMethod.h
//  TestIcon
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 添加属性方法的类型

 - CGAddPropertyMethodTypeGet: 添加get方法
 - CGAddPropertyMethodTypeSet: 添加set方法
 - CGAddPropertyMethodTypeGetAndSet: 添加 get/set 方法
 */
typedef NS_OPTIONS(NSInteger, CGAddPropertyMethodType) {
    
    CGAddPropertyMethodTypeGet          = 1 << 0,
    CGAddPropertyMethodTypeSet          = 1 << 1,
    CGAddPropertyMethodTypeGetAndSet    = CGAddPropertyMethodTypeGet | CGAddPropertyMethodTypeSet,
};

@interface CGAddPropertyMethod : NSObject

@property (nonatomic, strong, readonly) NSString *nameStr;

@property (nonatomic, strong, readonly) NSString *valueStr;

@property (nonatomic, assign, getter=isHidden) BOOL hidden;
@property (nullable, nonatomic, strong, setter=setupNameValue:) NSString *nameValue;

@property (nonatomic, strong, readwrite) NSString *readWriteValue;

@property (nonatomic, strong) NSArray<NSArray *> *arrayList;
@property (nonatomic, strong) NSDictionary<NSNumber *, NSString *> *dictionary;

@property (nonatomic, assign) CGAddPropertyMethodType addType;

@property (nonatomic, strong) NSString *targetPath;

@property NSInteger count;

- (void)startAddMethod;

@end

NS_ASSUME_NONNULL_END
