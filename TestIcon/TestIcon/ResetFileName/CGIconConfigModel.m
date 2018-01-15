//
//  CGIconConfigModel.m
//  TestIcon
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGIconConfigModel.h"

@implementation CGIconConfigImageModel

- (NSSize)imageSize
{
    if (!NSEqualSizes(_imageSize, NSZeroSize)) {
        return _imageSize;
    }
    
    NSArray *sizeUnitArray  = [self.size componentsSeparatedByString:@"x"];
    NSInteger scale         = 0;
    NSRange range = [self.scale rangeOfString:@"x"];
    if (range.location != NSNotFound) {
        scale = [[self.scale substringWithRange:NSMakeRange(0, self.scale.length - range.location)] integerValue];
    }
    
    NSAssert(sizeUnitArray.count == 2 && scale >= 1, @"xcode配置文件格式已改需要更新修改方式!");
    
    if (sizeUnitArray.count == 2 && scale ) {
        
        _imageSize  = NSMakeSize([sizeUnitArray[0] floatValue] * scale, [sizeUnitArray[1] floatValue] * scale);
    }
    
    return _imageSize;
}

@end

@implementation CGIconConfigInfoModel

@end

@implementation CGIconConfigModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"images"]) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray *imagesValue   = value;
            NSMutableArray *images = [NSMutableArray arrayWithCapacity:imagesValue.count];
            [imagesValue enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGIconConfigImageModel *imageModel = [[CGIconConfigImageModel alloc] init];
                [imageModel setValuesForKeysWithDictionary:obj];
                [images addObject:imageModel];
            }];
            self.images = images;
        }
    }else if ([key isEqualToString:@"info"]) {
        
        CGIconConfigInfoModel *infoModel = [[CGIconConfigInfoModel alloc] init];
        [infoModel setValuesForKeysWithDictionary:value];
        self.info   = infoModel;
    }
}



@end

