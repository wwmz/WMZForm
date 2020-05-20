




//
//  WMZFormEmptyView.m
//  WMZForm
//
//  Created by wmz on 2020/5/1.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormEmptyView.h"
#import "UIImage+imageNameWithBundle.h"
@implementation WMZFormEmptyView

- (instancetype)initWithFrame:(CGRect)frame data:(NSDictionary*)dic{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        self.data = dic;
    }
    return self;
}
- (void)setData:(NSDictionary *)data{
    self.label.center = self.center;
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, CGRectGetMinY(self.label.frame)-self.imageView.frame.size.height, self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.imageView.center = CGPointMake(self.center.x, self.imageView.center.y);
    self.imageView.image = [UIImage formBundleImage:data[@"image"]?:@"formIcon"];
    self.label.text = data[@"name"]?:@"暂无数据";
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.tag = 999;
        _imageView.frame = CGRectMake(0, 0, self.bounds.size.width<200?self.bounds.size.width*0.8:200, self.bounds.size.height<200?self.bounds.size.height*0.8:200);
    }
    return _imageView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        _label.tag = 998;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.frame = CGRectMake(0, 0, self.bounds.size.width, 40);
    }
    return _label;
}

@end
