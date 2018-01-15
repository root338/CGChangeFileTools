//
//  CGIconImageModel.m
//  TestIcon
//
//  Created by apple on 2018/1/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CGIconImageModel.h"

@interface CGIconImageModel ()

@property (nonatomic, strong, readwrite) NSImage *image;
@property (nonatomic, assign, readwrite) NSSize imagePixelSize;

@end

@implementation CGIconImageModel

@synthesize image = _image;

- (NSImage *)image
{
    if (_image) {
        return _image;
    }
    
    _image = [[NSImage alloc] initWithContentsOfFile:self.filePath];
    return _image;
}

- (void)setImage:(NSImage *)image
{
    _image          = image;
    _imagePixelSize = NSZeroSize;
}

- (void)setFilePath:(NSString *)filePath
{
    
    if ([_filePath isEqualToString:filePath] == NO) {
        
        _filePath   = filePath;
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


@implementation CGIconImageReplaceResult

@end
