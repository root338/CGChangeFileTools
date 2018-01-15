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

typedef NS_ENUM(NSInteger, CGChangeFileType) {
    
    CGChangeFileTypeNone,
    CGChangeFileTypeReplace,
    CGChangeFileTypeResetName,
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        CGChangeFileType changeType = CGChangeFileTypeNone;
        NSAssert(changeType == CGChangeFileTypeNone, @"运行程序存在一定风险！！！没有实现撤回功能，如果明白该风险注释该行，然后重新运行该程序");
        
        NSString *projectIconFolderPath = @"/Users/apple/dev/yuemeiProject/YMMainApp/QuickAskCommunity/QuickAskCommunity/Images.xcassets/AppIcon.appiconset";
        
        if (changeType == CGChangeFileTypeReplace) {
            // 替换图片
            NSString *iconFolderPath    = @"/Users/apple/Documents/MainAppIcon";
            
            CGIconReplace *iconReplace              = [[CGIconReplace alloc] init];
            iconReplace.iconFolderPath              = iconFolderPath;
            iconReplace.targetProjectIconFolderPath = projectIconFolderPath;
            
            [iconReplace startReplace];

        }else if (changeType == CGChangeFileTypeResetName) {
            // 重命名图片文件
            
            CGResetIconName *resetIconName  = [[CGResetIconName alloc] init];
            resetIconName.targetProjectIconFolderPath   = projectIconFolderPath;
            
            [resetIconName startReset];
        }else {
            
            NSLog(@"请设置已经实现的操作");
        }
    }
    return 0;
}
