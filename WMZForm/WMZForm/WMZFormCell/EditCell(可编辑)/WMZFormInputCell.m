


//
//  WMZFormInputCell.m
//  WMZForm
//
//  Created by wmz on 2020/4/22.
//  Copyright © 2020 wmz. All rights reserved.
//
 


#import "WMZFormInputCell.h"
@implementation WMZFormInputCell
- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
        make.width.mas_equalTo(self).multipliedBy(0.2);
    }];

    self.detailLa = [UILabel new];
    [self.contentView addSubview:self.detailLa];
    [self.detailLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLa.mas_top);
        make.right.mas_equalTo(-FormXOffset).priorityHigh();
    }];
    
    self.textField = [UITextField new];
    self.textField.delegate = self;
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLa.mas_top);
        make.right.equalTo(self.detailLa.mas_left).priorityHigh();
        make.width.mas_equalTo(self).multipliedBy(0.75);
    }];
    
    self.warningLabel = [UILabel new];
    [self.contentView addSubview:self.warningLabel];
    [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.equalTo(self.textField.mas_bottom);
        make.right.mas_equalTo(-FormXOffset);
        make.bottom.mas_equalTo(-FormYOffset);
    }];
}
- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    model.changeHeight = YES;
    self.detailLa.text = model.formDetail?[NSString stringWithFormat:@" %@",model.formDetail]:@"";
}
@end
