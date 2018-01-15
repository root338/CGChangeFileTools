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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        NSString *iconFolderPath    = @"/Users/apple/Documents/CloneMainAppIcon";
        NSString *projectIconFolderPath = @"/Users/apple/dev/yuemeiProject/YMMainApp/QuickAskCommunity/QuickAskCommunity/Images.xcassets/AppIcon.appiconset";
        
//        CGIconReplace *iconReplace              = [[CGIconReplace alloc] init];
//        iconReplace.iconFolderPath              = iconFolderPath;
//        iconReplace.targetProjectIconFolderPath = projectIconFolderPath;
//
//        [iconReplace startReplace];
        
        CGResetIconName *resetIconName  = [[CGResetIconName alloc] init];
        resetIconName.targetProjectIconFolderPath   = projectIconFolderPath;

        [resetIconName startReset];
    }
    return 0;
}
