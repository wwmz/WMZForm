//
//  WMZFormCheckCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormCheckCell.h"

@implementation WMZFormCheckCell
- (void)UI{
    [self.contentView addSubview:self.myBtn];
    [self.myBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-FormXOffset);
        make.size.mas_equalTo(FormDefaultCheckSize).priorityHigh();
    }];
    
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
        make.right.equalTo(self.myBtn.mas_left).offset(-FormXOffset);
    }];
    
    self.detailLa = [UILabel new];
    [self.contentView addSubview:self.detailLa];
    [self.detailLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLa.mas_left);
        make.top.equalTo(self.nameLa.mas_bottom);
        make.right.equalTo(self.nameLa.mas_right);
        make.bottom.mas_equalTo(-FormYOffset);
    }];
}
- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    if (!model.formValue) {
        model.valueChangeBlock = YES;
        model.formValue = @(NO);
        model.valueChangeBlock = NO;
    }
    if (model.formCustomButton) {
        model.formCustomButton(self.myBtn);
    }else{
        [self.myBtn setImage:[UIImage formBundleImage:FormCheckDefaultIcon] forState:UIControlStateNormal];
        [self.myBtn setImage:[UIImage formBundleImage:FormCheckDefaultSelectIcon] forState:UIControlStateSelected];
        [self.myBtn setTitleColor:FormDefaultBtnColor forState:UIControlStateNormal];
        self.myBtn.layer.masksToBounds = NO;
        self.myBtn.layer.borderWidth = 0;
        self.myBtn.layer.cornerRadius = 0;
        self.myBtn.titleLabel.font = [UIFont systemFontOfSize:FormDefaultBtnFont];
    }
    [self.myBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    self.myBtn.selected = model.formValue?[model.formValue boolValue]:NO;
    
    self.nameLa.attributedText = [[NSMutableAttributedString alloc] initWithString:model.formName?:@""];
}
- (void)tapAction:(WMZFormBtn*)sender{
    if (!self.model.formValue) {
        self.model.formValue = @(YES);
    }else{
        self.model.formValue = [self.model.formValue boolValue]?@(NO):@(YES);
    }
    sender.selected = self.model.formValue?[self.model.formValue boolValue]:NO;
}
- (UIButton *)myBtn{
    if (!_myBtn) {
        _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _myBtn;
}
@end
