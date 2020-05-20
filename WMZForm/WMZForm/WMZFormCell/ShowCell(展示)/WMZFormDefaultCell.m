

//
//  WMZFormDefaultCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormDefaultCell.h"

@implementation WMZFormDefaultCell

- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(FormXOffset);
        make.top.equalTo(self.contentView).offset(FormYOffset).priorityHigh();
    }];
    
    self.detailLa = [UILabel new];
    [self.contentView addSubview:self.detailLa];
    [self.detailLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLa.mas_right).offset(FormXOffset);
        make.right.equalTo(self.contentView).offset(-FormXOffset);
        make.bottom.equalTo(self.contentView).offset(-FormYOffset).priorityHigh();
        make.top.equalTo(self.contentView).offset(FormYOffset);
    }];
    [self.nameLa setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.detailLa setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}
@end
