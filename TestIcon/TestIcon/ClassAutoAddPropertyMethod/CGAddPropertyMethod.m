//
//  CGAddPropertyMethod.m
//  TestIcon
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGAddPropertyMethod.h"

#import <objc/runtime.h>

@interface CGAddPropertyMethod ()
{
    __weak NSObject *method;
}

@property (nonatomic, strong) NSFileManager *fileManager;

@property (nonatomic, strong, readwrite) NSString *valueStr;

@end

@implementation CGAddPropertyMethod

- (void)startAddMethod
{
    
    Class className = object_getClass(self);
    unsigned int propertyListCount  = 0;
    objc_property_t *propertyList   = class_copyPropertyList(className, &propertyListCount);
    
    
    unsigned int ivarListCount = 0;
    Ivar *ivarList = class_copyIvarList(className, &ivarListCount);
    for (int i = 0; i < ivarListCount; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"name: %s, encoding: %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    free(ivarList);
    
    for (int i = 0; i < propertyListCount; i++) {
        
        objc_property_t property_t  = propertyList[i];
        unsigned int propertyAttributeListCount = 0;
        
        objc_property_attribute_t *propertyAttributeList    = property_copyAttributeList(property_t, &propertyAttributeListCount);
        
        NSLog(@"%s", property_getName(property_t));
        for (int propertyAttributeIndex = 0; propertyAttributeIndex < propertyAttributeListCount; ) {
            
            objc_property_attribute_t property_attribute_t = propertyAttributeList[propertyAttributeIndex];
            NSLog(@"name: %s, value: %s", property_attribute_t.name, property_attribute_t.value);
            propertyAttributeIndex++;
        }
        free(propertyAttributeList);
    }
    free(propertyList);
    
//    BOOL isDirectory    = false;
//    BOOL isExists       = [self.fileManager fileExistsAtPath:self.targetPath isDirectory:&isDirectory];
//
//    if (isExists) {
//        if (isDirectory) {
//            [self handleFolderPath:self.targetPath];
//        }else {
//            [self handleFilePath:self.targetPath];
//        }
//    }
}

- (void)handleFilePath:(NSString *)filePath
{
    static NSArray *fileExtensionList = nil;
    if (fileExtensionList == nil) {
        fileExtensionList = @[
                              @"h",
                              @"m",
                              @"mm",
                              ];
    }
    NSString *fileExtension = filePath.pathExtension;
    if ([fileExtensionList containsObject:fileExtension]) {
        
    }
}

- (void)handleFolderPath:(NSString *)folderPath
{
    NSError *folderListError                = nil;
    NSArray<NSString *> *folderListArray    = [self.fileManager contentsOfDirectoryAtPath:folderPath error:&folderListError];
    NSAssert1(folderListError == nil, @"获取目录内路径列表失败, Error: %@", folderListError);
    
    for (NSString *obj in folderListArray) {
        
        NSString *path  = [folderPath stringByAppendingPathComponent:obj];
        BOOL isDirectory    = false;
        [self.fileManager fileExistsAtPath:path isDirectory:&isDirectory];
        if (isDirectory) {
            [self handleFolderPath:path];
        }else {
            [self handleFilePath:path];
        }
    }
    
}

//- (NSFileManager *)fileManager
//{
//    if (_fileManager) {
//        return _fileManager;
//    }
//
//    _fileManager = [NSFileManager defaultManager];
//
//    return _fileManager;
//}

- (void)setupNameValue:(NSString *)nameValue
{
    _nameValue  = nameValue;
}

- (BOOL)isHidden
{
    return _hidden;
}

@end
