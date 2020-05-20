//
//  WMZFormNormalCell.m
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormNormalCell.h"

@implementation WMZFormNormalCell
- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
    }];
    
    self.detailLa = [UILabel new];
    [self.contentView addSubview:self.detailLa];
    [self.detailLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLa.mas_right).offset(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
        make.right.mas_equalTo(-FormXOffset);
        make.bottom.mas_equalTo(-FormYOffset);
    }];
    [self.nameLa setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.detailLa setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}
@end
