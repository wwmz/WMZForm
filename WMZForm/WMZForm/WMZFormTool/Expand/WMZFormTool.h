//
//  WMZFormTool.h
//  WMZForm
//
//  Created by wmz on 2020/4/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WMZFormTool : NSObject
+ (float)heightForTextView:(CGSize)constraint WithText: (NSString *) strText WithFont:(CGFloat)font;
@end

NS_ASSUME_NONNULL_END
