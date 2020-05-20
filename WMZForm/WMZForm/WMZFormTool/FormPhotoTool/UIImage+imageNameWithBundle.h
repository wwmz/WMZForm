//
//  UIImage+imageNameWithBundle.h
//  WMZForm
//
//  Created by wmz on 2020/5/13.
//  Copyright © 2020 wmz. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (imageNameWithBundle)
+ (UIImage*)formBundleImage:(NSString*)name;
@end

NS_ASSUME_NONNULL_END
