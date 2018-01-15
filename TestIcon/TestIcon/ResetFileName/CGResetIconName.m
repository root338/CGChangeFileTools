//
//  CGResetIconName.m
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGResetIconName.h"

#import "CGResetIconModel.h"
#import "CGResetNameResult.h"
#import "CGIconConfigModel.h"
#import "CGChangeIconNameRule.h"

@import AppKit;

@interface CGResetIconName ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *imageNameRepeatCountDict;

@property (nonatomic, strong) NSString *cacheFolderPath;

@end

@implementation CGResetIconName

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _iconPathExtension  = @"png";
    }
    return self;
}

- (void)startReset
{
    CGIconNameSameGroupModel *iconNameGroupModel    = [self resolveIconFolderPath:self.targetProjectIconFolderPath];
    
    [self operateResetImageWithGroupModel:iconNameGroupModel];
}

/// 写入文件
- (void)operateResetImageWithGroupModel:(CGIconNameSameGroupModel *)groupModel
{
    NSInteger totalCount        = groupModel.count;
    CGResetIconModel *iconModel = [groupModel pop];
    
    NSMutableArray *successResultArray  = [NSMutableArray array];
    NSMutableArray *faildResultArray    = [NSMutableArray array];
    
    while (iconModel) {
        
        CGResetNameResult *resultValue = [self writeIconFile:iconModel];
        if (resultValue.errorType == CGResetErrorTypeMoveCacheFolder) {
            [groupModel push:iconModel];
        }else {
            if (resultValue.errorType == CGResetErrorTypeNone || resultValue.errorType == CGResetErrorTypeNoChangeFileName) {
                [successResultArray addObject:resultValue];
            }else {
                [faildResultArray addObject:resultValue];
            }
        }
        
        iconModel   = [groupModel pop];
    }
    
    [self resetImageConfig:groupModel.iconConfigModel availableImages:successResultArray];
    
    NSLog(@"重置完成");
    NSLog(@"运行结果");
    NSLog(@"项目一共 %lu 文件", (unsigned long)totalCount);
    
    NSArray *successLog = [self logWithResultArray:successResultArray];
    NSArray *failureLog = [self logWithResultArray:faildResultArray];
    
    if (successLog.count > 0) {
        NSLog(@"重置成功(%lu): %@", (unsigned long)successLog.count, successLog);
    }
    
    if (failureLog.count > 0) {
        NSLog(@"重置失败(%lu): %@", (unsigned long)failureLog.count, failureLog);
    }
}

- (void)resetImageConfig:(CGIconNameSameGroupModel *)groupModel availableImages:(NSArray<CGResetNameResult *> *)imagesArray
{
    [groupModel.iconConfigModel.images enumerateObjectsUsingBlock:^(CGIconConfigImageModel * _Nonnull imageConfigModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [imagesArray enumerateObjectsUsingBlock:^(CGResetNameResult * _Nonnull resetResultModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (resetResultModel.imageModel.isRelation == NO) {
                
                if (NSEqualSizes(imageConfigModel.imageSize, resetResultModel.imageModel.imagePixelSize)) {
                    
                    imageConfigModel.filename               = resetResultModel.filePath.lastPathComponent;
                    resetResultModel.imageModel.isRelation  = YES;
                    *stop                                   = YES;
                }
            }
        }];
    }];
    
    
}

/// 写入文件
- (CGResetNameResult *)writeIconFile:(CGResetIconModel *)iconModel
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    CGResetNameResult *resultValue  = [[CGResetNameResult alloc] initWithImageModel:iconModel];
    
    NSString *iconNewName   = iconModel.didResetIconName;
    NSNumber *repeatCount   = self.imageNameRepeatCountDict[iconNewName];
    
    if (repeatCount.integerValue > 0) {
        iconNewName = [self resetIconName:iconNewName didRepeatCount:repeatCount.integerValue];
    }
    
    NSString *iconNewPath   = [iconModel.folderPath stringByAppendingPathComponent:iconNewName];
    if ([iconNewName isEqualToString:iconModel.iconName]) {
        /// 不需要替换
        resultValue.errorType   = CGResetErrorTypeNoChangeFileName;
        resultValue.filePath    = iconNewPath;
    }else {
        
        NSString *iconOriginPath = nil;
        if (iconModel.availablePathType == CGResetImagePathAvailableTypeIconOriginPath) {
            iconOriginPath  = [iconModel.folderPath stringByAppendingPathComponent:iconModel.iconName];
        }else if (iconModel.availablePathType == CGResetImagePathAvailableTypeCachePath) {
            iconOriginPath  = iconModel.cacheFilePath;
        }
        
        NSError *moveIconError  = nil;
        
        if ([fileManager fileExistsAtPath:iconNewPath]) {
            //文件已存在, 暂时移动到缓存目录
            NSString *cacheIconPath = nil;
            while (cacheIconPath == nil || [fileManager fileExistsAtPath:cacheIconPath] == YES) {
                
                NSString *cacheName = [self getCacheNameWithIconName:iconNewPath.lastPathComponent];
                cacheIconPath       = [self.cacheFolderPath stringByAppendingPathComponent:cacheName];
            }
            
            [fileManager moveItemAtPath:iconOriginPath toPath:cacheIconPath error:&moveIconError];
            if (moveIconError != nil) {
                
                resultValue.errorType   = CGResetErrorTypeNotMoveCacheFolder;
            }else {
                
                resultValue.errorType       = CGResetErrorTypeMoveCacheFolder;
                iconModel.cacheFilePath     = cacheIconPath;
                iconModel.availablePathType = CGResetImagePathAvailableTypeCachePath;
            }
        }else {
            
            [fileManager moveItemAtPath:iconOriginPath toPath:iconNewPath error:&moveIconError];
            
            if (moveIconError != nil) {
                resultValue.errorType   = CGResetErrorTypeUnknown;
            }else {
                if (repeatCount) {
                    repeatCount = @(repeatCount.integerValue + 1);
                }else {
                    repeatCount = @(1);
                }
                
                resultValue.filePath        = iconNewPath;
                iconModel.availablePathType = CGResetImagePathAvailableTypeDidResetPath;
                [self.imageNameRepeatCountDict setObject:repeatCount forKey:iconModel.didResetIconName];
            }
        }
        
        resultValue.resetError  = moveIconError;
    }
    
    return resultValue;
}

/// 解析 Icon 目录的文件
- (CGIconNameSameGroupModel *)resolveIconFolderPath:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSAssert1([fileManager fileExistsAtPath:folderPath], @"%@ 不是有效路径", folderPath);
    
    NSError *iconsPathError = nil;
    NSArray<NSString *> *iconsPath  = [fileManager contentsOfDirectoryAtPath:folderPath error:&iconsPathError];
    NSAssert1(iconsPathError == nil, @"获取 icons 目录中文件列表出错，ERROR: %@", iconsPathError);
    
    CGIconNameSameGroupModel *iconNameGroup  = [[CGIconNameSameGroupModel alloc] init];
    
    [iconsPath enumerateObjectsUsingBlock:^(NSString * _Nonnull iconName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[iconName pathExtension] isEqualToString: self.iconPathExtension]) {
            
            CGResetIconModel *iconModel = [[CGResetIconModel alloc] init];
            iconModel.iconName          = iconName;
            iconModel.folderPath        = self.targetProjectIconFolderPath;
            
            iconModel.didResetIconName  = [self resetImageModel:iconModel rule:self.changeNameRule];
            
            [iconNameGroup push:iconModel];
            
        }else if ([iconName hasSuffix:@".json"]) {
            NSData *imagesConfigData = [NSData dataWithContentsOfFile:[self.targetProjectIconFolderPath stringByAppendingPathComponent:iconName]];
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:imagesConfigData options:NSJSONReadingMutableContainers error:&jsonError];
            
            CGIconConfigModel *configModel  = [[CGIconConfigModel alloc] init];
            [configModel setValuesForKeysWithDictionary:json];
            
            iconNameGroup.iconConfigModel   = configModel;
        }
    }];
    return iconNameGroup;
}

/// 设置满足规则的图片名字
- (NSString *)resetImageModel:(CGResetIconModel *)iconModel rule:(CGChangeIconNameRule *)rule
{
    NSString *iconNewName   = nil;
    if (rule.ruleType == CGChangeIconNameRuleTypeDefalut) {
        
        NSMutableArray *iconNewNameArray    = [NSMutableArray array];
        if (rule.iconNameHeader) {
            
            [iconNewNameArray addObject:rule.iconNameHeader];
        }
        
        [iconNewNameArray addObject:[@(iconModel.imagePixelSize.width) stringValue]];
        [iconNewNameArray addObject:[@(iconModel.imagePixelSize.height) stringValue]];
        
        iconNewName = [iconNewNameArray componentsJoinedByString:rule.mark];
        iconNewName = [iconNewName stringByAppendingPathExtension:[iconModel.iconName pathExtension]];
    }
    
    return iconNewName;
}

/// 当名字重复时，重新设置的图片名
- (NSString *)resetIconName:(NSString *)iconName didRepeatCount:(NSInteger)repeatCount
{
    NSString *iconNewName = nil;
    if (self.changeNameRule.ruleType == CGChangeIconNameRuleTypeDefalut) {
        NSString *iconFileName = [iconName stringByDeletingPathExtension];
        iconNewName = [[NSString stringWithFormat:@"%@-%li", iconFileName, repeatCount] stringByAppendingPathExtension:iconName.pathExtension];
    }else {
        NSAssert(iconNewName, @"未实现");
    }
    
    return iconNewName;
}

/// 获取缓存的图片名
- (NSString *)getCacheNameWithIconName:(NSString *)iconName
{
    NSString *iconFileName  = [iconName stringByDeletingPathExtension];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate];
    NSInteger randomValue       = arc4random() % 100000000;
    NSString *cacheName = [[NSString stringWithFormat:@"TEMP+%@+%f%li", iconFileName, timeInterval, randomValue] stringByAppendingPathExtension:iconName.pathExtension];
    
    return cacheName;
}

- (NSArray<NSString *> *)logWithResultArray:(NSArray<CGResetNameResult *> *)resultArray
{
    NSMutableArray<NSString *> *logArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    [resultArray enumerateObjectsUsingBlock:^(CGResetNameResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *iconOriginName    = obj.imageModel.iconName;
        NSString *didResetName      = [obj.filePath lastPathComponent];
        NSString *logStr            = [NSString stringWithFormat:@"%@ => %@", iconOriginName, didResetName];
        if (!(obj.errorType == CGResetErrorTypeNone || obj.errorType == CGResetErrorTypeNoChangeFileName)) {
            logStr  = [logStr stringByAppendingFormat:@", error: %@", obj.resetError];
        }
        [logArray addObject:logStr];
    }];
    
    return logArray;
}

- (CGChangeIconNameRule *)changeNameRule
{
    if (_changeNameRule) {
        return _changeNameRule;
    }
    
    _changeNameRule = [[CGChangeIconNameRule alloc] init];
    
    return _changeNameRule;
}

- (NSMutableDictionary<NSString *, NSNumber *> *)imageNameRepeatCountDict
{
    if (_imageNameRepeatCountDict) {
        return _imageNameRepeatCountDict;
    }
    
    _imageNameRepeatCountDict = [NSMutableDictionary dictionary];
    
    return _imageNameRepeatCountDict;
}

- (NSString *)cacheFolderPath
{
    if (_cacheFolderPath) {
        return _cacheFolderPath;
    }
    
    NSArray *cacheList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceReferenceDate];
    NSInteger randomValue       = arc4random() % 100000000;
    NSString *folderName        = [NSString stringWithFormat:@"CG+%f%li", timeInterval, randomValue];
    
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    _cacheFolderPath            = [cacheList.firstObject stringByAppendingPathComponent:folderName];
    
    NSError *createFolderError  = nil;
    [fileManager createDirectoryAtPath:_cacheFolderPath withIntermediateDirectories:NO attributes:nil error:&createFolderError];
    NSAssert1(createFolderError == nil, @"创建缓存目录失败 %@", createFolderError);
    
    return _cacheFolderPath;
}

@end
