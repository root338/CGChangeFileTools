//
//  CGResetIconModel.m
//  TestIcon
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGResetIconModel.h"

#import "CGResetNameResult.h"

@import AppKit;

@interface CGResetIconModel ()
{
    BOOL didStartResetIconName;
}

@property (nonatomic, strong, readwrite) NSImage *iconImage;
@property (nonatomic, assign, readwrite) NSSize imagePixelSize;
@end

@implementation CGResetIconModel

@synthesize image = _image;

- (NSImage *)image
{
    if (_iconImage) {
        return _iconImage;
    }
    
    if (self.iconName.length == 0 || self.folderPath.length == 0) {
        return nil;
    }
    
    _iconImage  = [[NSImage alloc] initWithContentsOfFile:[self.folderPath stringByAppendingPathComponent:self.iconName]];
    
    return _iconImage;
}

- (void)setImage:(NSImage *)image
{
    _image          = image;
    _imagePixelSize = NSZeroSize;
}

- (void)setFolderPath:(NSString *)folderPath
{
    if (![_folderPath isKindOfClass:[folderPath class]]) {
        
        _folderPath = folderPath;
        self.image  = nil;
    }
}

- (NSSize)imagePixelSize
{
    if (!CGSizeEqualToSize(_imagePixelSize, NSZeroSize)) {
        return _imagePixelSize;
    }
    
    if (self.image == nil ) {
        return NSZeroSize;
    }
    
    NSBitmapImageRep *bitmapImageRep    = [NSBitmapImageRep imageRepWithData:[self.image TIFFRepresentation]];
    _imagePixelSize = NSMakeSize(bitmapImageRep.pixelsWide, bitmapImageRep.pixelsHigh);
    
    return _imagePixelSize;
}

@end

@interface CGIconNameSameGroupModel ()
{
    
}

@property (nonatomic, strong) NSMutableArray<CGResetIconModel *> *iconModelArray;
@end

@implementation CGIconNameSameGroupModel

- (CGResetIconModel *)pop
{
    CGResetIconModel *iconModel = self.iconModelArray.firstObject;
    
    iconModel == nil ?: [self.iconModelArray removeObjectAtIndex:0];
    
    return iconModel;
}

- (void)push:(CGResetIconModel *)iconModel
{
    [self.iconModelArray addObject:iconModel];
}

- (NSMutableArray<CGResetIconModel *> *)iconModelArray
{
    if (_iconModelArray) {
        return _iconModelArray;
    }
    
    _iconModelArray = [NSMutableArray array];
    
    return _iconModelArray;
}

- (NSInteger)count
{
    return self.iconModelArray.count;
}

@end
