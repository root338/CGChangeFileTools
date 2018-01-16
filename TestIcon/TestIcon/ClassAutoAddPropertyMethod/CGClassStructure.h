//
//  CGClassStructure.h
//  TestIcon
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGPropertyStructure : NSObject



@end

@interface CGClassStructure : NSObject

@property (nonatomic, strong) NSArray<CGPropertyStructure *> *propertyList;

@end
