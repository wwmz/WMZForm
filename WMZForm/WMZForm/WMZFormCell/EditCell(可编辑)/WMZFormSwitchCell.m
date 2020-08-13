//
//  WMZFormSwitchCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormSwitchCell.h"

@implementation WMZFormSwitchCell

- (void)UI{
    [self.contentView addSubview:self.mySwitch];
    [self.mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(-FormXOffset);
    }];
    
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
        make.right.equalTo(self.mySwitch.mas_left).offset(-FormXOffset);
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
    self.mySwitch.on = model.formValue?[model.formValue boolValue]:NO;
    if (model.formCustomSwitch) {
        model.formCustomSwitch(self.mySwitch);
    }else{
        self.mySwitch.onTintColor = self.tmpSwitch.onTintColor;
        self.mySwitch.thumbTintColor = self.tmpSwitch.thumbTintColor;
        self.mySwitch.onImage = self.tmpSwitch.onImage;
        self.mySwitch.offImage = self.tmpSwitch.offImage;
    }
    self.nameLa.attributedText = [[NSMutableAttributedString alloc] initWithString:model.formName?:@""];
}
- (void)switchAction:(UISwitch*)mySwitch{
    self.model.formValue = @(mySwitch.isOn);
      if (self.formDelagate&&[self.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
          [self.formDelagate didSelectCell:self target:mySwitch action:@"switch"];
    }
}
- (UISwitch *)mySwitch{
    if (!_mySwitch) {
        _mySwitch = [UISwitch new];
        [_mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}
- (UISwitch *)tmpSwitch{
    if (!_tmpSwitch) {
        _tmpSwitch = [UISwitch new];
    }
    return _tmpSwitch;
}
@end
