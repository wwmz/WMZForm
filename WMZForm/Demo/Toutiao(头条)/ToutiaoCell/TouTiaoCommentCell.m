




//
//  TouTiaoCommentCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "TouTiaoCommentCell.h"

@implementation TouTiaoCommentCell
- (void)UI{
    [self.contentView addSubview:self.transferBtn];
    [self.transferBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.33);
        make.top.mas_equalTo(10);make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(35).priorityHigh();
    }];
    
    [self.contentView addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.34);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.left.equalTo(self.transferBtn.mas_right);
        make.height.mas_equalTo(35).priorityHigh();
    }];
    
    [self.contentView addSubview:self.priseBtn];
    [self.priseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(0.33);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.left.equalTo(self.commentBtn.mas_right);
        make.height.mas_equalTo(35).priorityHigh();
    }];
}
- (WMZFormBtn *)transferBtn{
    if (!_transferBtn) {
        _transferBtn = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
        [_transferBtn setTitle:@"55" forState:UIControlStateNormal];
        [_transferBtn setTitleColor:FormColor(0x666666) forState:UIControlStateNormal];
        [_transferBtn setImage:[UIImage formBundleImage:@"form_nan"] forState:UIControlStateNormal];
        _transferBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _transferBtn;
}
- (WMZFormBtn *)priseBtn{
    if (!_priseBtn) {
        _priseBtn = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
        [_priseBtn setTitle:@"1123" forState:UIControlStateNormal];
        [_priseBtn setTitleColor:FormColor(0x666666) forState:UIControlStateNormal];
        [_priseBtn setImage:[UIImage formBundleImage:@"form_nan"] forState:UIControlStateNormal];
        _priseBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _priseBtn;
}
- (WMZFormBtn *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
        _commentBtn = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitle:@"22331" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:FormColor(0x666666) forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage formBundleImage:@"form_nv"] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _commentBtn;
}
@end
