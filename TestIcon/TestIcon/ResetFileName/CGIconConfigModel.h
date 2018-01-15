//
//  CGIconConfigModel.h
//  TestIcon
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGIconConfigImageModel : NSObject

@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *idiom;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) NSString *scale;

@property (nonatomic, assign) CGSize imageSize;



@end

@interface CGIconConfigInfoModel : NSObject

@property (nonatomic, strong) NSNumber *version;
@property (nonatomic, strong) NSString *author;

@end

@interface CGIconConfigModel : NSObject

@property (nonatomic, strong) NSArray<CGIconConfigImageModel *> *images;
@property (nonatomic, strong) CGIconConfigInfoModel *info;

- (NSString *)json;

@end
