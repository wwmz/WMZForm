//
//  WMZFormBtn.h
//  WMZForm
//
//  Created by wmz on 2020/5/1.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSInteger{
    FormBtnPositionLeft     = 1,            //图片在左，文字在右，默认
    FormBtnPositionRight    = 2,            //图片在右，文字在左
    FormBtnPositionTop      = 3,            //图片在上，文字在下
    FormBtnPositionBottom   = 4,            //图片在下，文字在上
}FormBtnPosition;
NS_ASSUME_NONNULL_BEGIN

@interface WMZFormTreeModel : NSObject
//other
@property(nonatomic,assign)NSInteger index;
//other
@property(nonatomic,strong)NSDictionary *other;
//name
@property(nonatomic,copy)NSString *name;
//image
@property(nonatomic,copy)NSString *image;
//selectImage
@property(nonatomic,copy)NSString *selectImage;
//select
@property(nonatomic,assign)BOOL isSelected;
//position
@property(nonatomic,assign)FormBtnPosition position;
//positionOffset
@property(nonatomic,assign)CGFloat positionOffset;
@end


@interface WMZFormBtn : UIButton
//最大size
@property(nonatomic,assign)CGSize maxSize;
@property(nonatomic,strong)WMZFormTreeModel *model;
- (void)TagSetImagePosition:(FormBtnPosition)postion spacing:(CGFloat)spacing;
@end

NS_ASSUME_NONNULL_END
