//
//  UIImage+imageNameWithBundle.m
//  WMZForm
//
//  Created by wmz on 2020/5/13.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "UIImage+imageNameWithBundle.h"
#import "WMZFormBase.h"
@implementation UIImage (imageNameWithBundle)
+ (UIImage*)formBundleImage:(NSString*)name{
    NSBundle *bundle =  [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZFormBase class]] pathForResource:@"WMZForm" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"png"];
    if (!path) {
        return [UIImage imageNamed:name];
    }else{
        return [UIImage imageWithContentsOfFile:path];
    }
}
@end
