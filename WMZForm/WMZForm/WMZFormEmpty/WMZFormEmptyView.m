




//
//  WMZFormEmptyView.m
//  WMZForm
//
//  Created by wmz on 2020/5/1.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormEmptyView.h"
#import "UIImage+imageNameWithBundle.h"
#import "WMZFormMacro.h"
@implementation WMZFormEmptyView

- (instancetype)initWithFrame:(CGRect)frame data:(NSDictionary*)dic{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.mas_width)
            .multipliedBy(0.4).priorityHigh();
            make.center.equalTo(self);
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.imageView.mas_bottom).offset(5);
            make.left.mas_equalTo(FormXOffset);
            make.right.mas_equalTo(-FormXOffset);
        }];
        self.data = dic;
    }
    return self;
}
- (void)setData:(NSDictionary *)data{
    _data = data;
    self.imageView.image = [UIImage formBundleImage:data[@"image"]?:@"formIcon"];
    self.label.text = data[@"name"]?:@"暂无数据";
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.tag = 999;
    }
    return _imageView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.tag = 998;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
