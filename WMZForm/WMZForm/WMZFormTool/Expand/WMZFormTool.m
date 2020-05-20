






//
//  WMZFormTool.m
//  WMZForm
//
//  Created by wmz on 2020/4/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormTool.h"

@implementation WMZFormTool
//获取文本高度
+ (float)heightForTextView:(CGSize)constraint WithText: (NSString *) strText WithFont:(CGFloat)font{
    if (!strText||strText.length==0) {
        return 0;
    }
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}
                                        context:nil];
    float textHeight = size.size.height;
    return textHeight;
}
@end
