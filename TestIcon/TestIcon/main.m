//
//  main.m
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGIconReplace.h"
#import "CGResetIconName.h"
#import "CGAddPropertyMethod.h"

typedef NS_ENUM(NSInteger, CGChangeFileType) {
    
    CGChangeFileTypeNone,
    CGChangeFileTypeReplace,
    CGChangeFileTypeResetName,
    CGChangeFileTypeAddOCClassPropertyMethod,
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        CGChangeFileType changeType = CGChangeFileTypeAddOCClassPropertyMethod;
//        NSAssert(changeType == CGChangeFileTypeNone, @"运行程序存在一定风险！！！没有实现撤回功能，如果明白该风险注释该行，然后重新运行该程序");
        
//        NSString *projectFolderPath = @"/Users/apple/dev/yuemeiProject/YMMainApp/QuickAskCommunity/QuickAskCommunity/Images.xcassets/AppIcon.appiconset";
        NSString *projectFolderPath = @"/Users/apple/dev/MeProject/CGPhoto";
        
        if (changeType == CGChangeFileTypeReplace) {
            // 替换图片
            NSString *iconFolderPath    = @"/Users/apple/Documents/MainAppIcon";
            
            CGIconReplace *iconReplace              = [[CGIconReplace alloc] init];
            iconReplace.iconFolderPath              = iconFolderPath;
            iconReplace.targetProjectIconFolderPath = projectFolderPath;
            
            [iconReplace startReplace];

        }else if (changeType == CGChangeFileTypeResetName) {
            // 重命名图片文件
            
            CGResetIconName *resetIconName  = [[CGResetIconName alloc] init];
            resetIconName.targetProjectIconFolderPath   = projectFolderPath;
            
            [resetIconName startReset];
        }else if (changeType == CGChangeFileTypeAddOCClassPropertyMethod) {
            
            CGAddPropertyMethod *addPropertyMethod  = [[CGAddPropertyMethod alloc] init];
            addPropertyMethod.targetPath            = projectFolderPath;
            [addPropertyMethod startAddMethod];
        }else {
            
            NSLog(@"请设置已经实现的操作");
        }
    }
    return 0;
}
