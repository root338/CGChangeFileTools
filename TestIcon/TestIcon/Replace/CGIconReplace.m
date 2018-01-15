//
//  CGIconReplace.m
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGIconReplace.h"
#import "CGIconImageModel.h"

@interface CGIconReplace ()



@end

@implementation CGIconReplace

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _iconPathExtension  = @"png";
    }
    return self;
}

- (void)startReplace
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSAssert1([fileManager fileExistsAtPath:self.iconFolderPath], @"%@ 不是一个有效的目录", self.iconFolderPath);
    NSAssert1([fileManager fileExistsAtPath:self.targetProjectIconFolderPath], @"%@ 不是一个有效的目录", self.targetProjectIconFolderPath);
    
    NSArray<CGIconImageModel *> *iconImageList = [self iconImageListWithFolderPath:self.iconFolderPath];
    NSArray<CGIconImageModel *> *projectIconImageList   = [self iconImageListWithFolderPath:self.targetProjectIconFolderPath];
    
    NSMutableArray<CGIconImageReplaceResult *> *successArray    = [NSMutableArray array];
    NSMutableArray<CGIconImageReplaceResult *> *errorArray      = [NSMutableArray array];
    
    [projectIconImageList enumerateObjectsUsingBlock:^(CGIconImageModel * _Nonnull projectIconImageModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [iconImageList enumerateObjectsUsingBlock:^(CGIconImageModel * _Nonnull iconImageModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (CGSizeEqualToSize(projectIconImageModel.imagePixelSize, iconImageModel.imagePixelSize)) {
                
                BOOL isShouldReplace    = YES;
                
                CGIconImageReplaceResult *result    = [[CGIconImageReplaceResult alloc] init];
                result.originFilePath               = iconImageModel.filePath;
                result.replaceFilePath              = projectIconImageModel.filePath;
                result.originImage                  = iconImageModel.image;
                result.replaceImage                 = projectIconImageModel.image;
                
                NSError *removeProjectIconError = nil;
                if ([fileManager fileExistsAtPath:projectIconImageModel.filePath]) {
                    
                    [fileManager removeItemAtPath:projectIconImageModel.filePath error:&removeProjectIconError];
                    if (removeProjectIconError) {
                        isShouldReplace = NO;
                    }
                }
                
                NSError *replaceError = nil;
                if (isShouldReplace) {
                    [fileManager copyItemAtPath:iconImageModel.filePath toPath:projectIconImageModel.filePath error:&replaceError];
                }
                
                if (replaceError || removeProjectIconError) {
                    result.error    = replaceError;
                    [errorArray addObject:result];
                }else {
                    [successArray addObject:result];
                }
                
                *stop   = YES;
            }else {
                if (idx == iconImageList.count - 1) {
                    
                    NSLog(@"error: 没有找到 %@", NSStringFromSize(projectIconImageModel.image.size));
                }
            }
        }];
    }];
    
    NSArray<NSString *> *successFileName = [self resultWithResultArray:successArray];
    NSArray<NSString *> *errorFileName   = [self resultWithResultArray:errorArray];
    
    NSLog(@"执行完成");
    NSLog(@"运行结果：");
    NSLog(@"项目一共 %lu 文件", (unsigned long)projectIconImageList.count);
    
    if (successFileName.count) {
        NSLog(@"替换成功(%lu)：%@", (unsigned long)successFileName.count, successFileName);
    }
    if (errorFileName.count) {
        NSLog(@"替换失败(%lu)：%@", (unsigned long)errorFileName.count, errorFileName);
    }
}

- (NSMutableArray<CGIconImageModel *> *)iconImageListWithFolderPath:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *iconFolderError = nil;
    NSArray<NSString *> *iconFolderContents = [fileManager contentsOfDirectoryAtPath:folderPath error:&iconFolderError];
    NSAssert1(iconFolderError == nil, @"获取目录内容错误, error: %@", iconFolderError);
    
    NSMutableArray<CGIconImageModel *> *iconImageArray = [NSMutableArray array];
    [iconFolderContents enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj pathExtension] isEqualToString:self.iconPathExtension]) {
            NSString *iconImagePath = [folderPath stringByAppendingPathComponent:obj];
            CGIconImageModel *iconImageModel    = [[CGIconImageModel alloc] init];
            iconImageModel.filePath             = iconImagePath;
            [iconImageArray addObject:iconImageModel];
        }
    }];
    return iconImageArray;
}

- (NSArray<NSString *> *)resultWithResultArray:(NSArray<CGIconImageReplaceResult *> *)resultArray
{
    NSMutableArray<NSString *> *resultLogList   = [NSMutableArray arrayWithCapacity:resultArray.count];
    [resultArray enumerateObjectsUsingBlock:^(CGIconImageReplaceResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *resultLog = [NSMutableString stringWithFormat:@"%@ (%@) => %@ (%@)", obj.originFilePath.lastPathComponent, NSStringFromSize(obj.originImage.size), obj.replaceFilePath.lastPathComponent, NSStringFromSize(obj.replaceImage.size)];
        if (obj.error) {
            [resultLog appendFormat:@", error: %@", obj.error];
        }
        
        [resultLogList addObject:resultLog];
    }];
    return resultLogList;
}

@end
