//
//  CGResetNameResult.m
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGResetNameResult.h"

@import AppKit;

@interface CGResetNameResult ()

@property (nonatomic, strong, readwrite) CGResetIconModel *imageModel;

@end

@implementation CGResetNameResult

- (instancetype)initWithImageModel:(CGResetIconModel *)imageModel
{
    self = [super init];
    if (self) {
        
        _imageModel = imageModel;
    }
    return self;
}

@end
