//
//  WMZFormVerificationCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/1.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormVerificationCell.h"

@implementation WMZFormVerificationCell

- (void)UI{
    
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
        make.width.mas_lessThanOrEqualTo(Form_GetWNum(170));
        make.width.mas_greaterThanOrEqualTo(Form_GetWNum(120));
    }];
    
    self.btn = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(FormDefaultBtnSize);
        make.centerY.mas_equalTo(self.nameLa.mas_centerY);
        make.right.mas_equalTo(-FormXOffset);
    }];
      
    self.textField = [UITextField new];
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLa.mas_top);
        make.right.equalTo(self.btn.mas_left).offset(-FormXOffset);
        make.left.equalTo(self.nameLa.mas_right).offset(FormXOffset/2);
    }];
    
    self.warningLabel = [UILabel new];
    [self.contentView addSubview:self.warningLabel];
    [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.equalTo(self.textField.mas_bottom);
        make.right.mas_equalTo(-FormXOffset);
        make.bottom.mas_equalTo(-FormYOffset);
    }];
    
    [self.btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    model.changeHeight = YES;
    [self getBtn:model];
    
}

- (void)getBtn:(WMZFormRowModel*)model{
    if (model.isSelected) {
        self.btn.userInteractionEnabled = NO;
        self.btn.backgroundColor = FormDefaultCodeSelectBackground;
        [self.btn setTitle:model.showContent forState:UIControlStateNormal];
        [self.btn setTitleColor:FormColor(0X999999) forState:UIControlStateNormal];
        self.btn.layer.borderColor = FormColor(0X999999).CGColor;
        self.btn.layer.borderWidth = FormK1px;
    }else{
        self.btn.userInteractionEnabled = YES;
        self.btn.backgroundColor = FormDefaultCodeBackground;
        [self.btn setTitle:model.showContent?:model.formBtn forState:UIControlStateNormal];
        [self.btn setTitleColor:FormColor(0Xffffff) forState:UIControlStateNormal];
        self.btn.layer.borderColor = self.btn.backgroundColor.CGColor;
        self.btn.layer.borderWidth = FormK1px;
    }
}
- (void)btnAction:(UIButton*)sender{
    sender.selected = ![sender isSelected];
    self.model.isSelected = !self.model.isSelected;
    if (self.model.isSelected) {
        self.model.second = self.model.formTime;
        [self timerAction:nil];
        [self startTimerWithTimeInterVal:1];;
        if (self.formDelagate&&[self.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
            [self.formDelagate didSelectCell:self target:sender action:@(FormVerficationClick)];
        }
    }
}

- (void)startTimerWithTimeInterVal:(NSTimeInterval)timeInterVal
{
    if (self.model.timer) return;
    self.model.timer = [NSTimer timerWithTimeInterval:timeInterVal
                                     target:self
                                   selector:@selector(timerAction:)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.model.timer
                              forMode:NSRunLoopCommonModes];
}
- (void)timerAction:(NSTimer *)timer
{
    if (self.model.second<=0) {
        [self stopTimer];
        self.model.showContent = self.model.formBtn;
        self.model.isSelected = NO;
    }else{
        self.model.second-=1;
        self.model.showContent = [NSString stringWithFormat:@"重新获取(%ld)",self.model.second];
        self.model.isSelected = YES;
    }
    [self getBtn:self.model];
}
- (void)stopTimer
{
    [self.model.timer invalidate];
    self.model.timer = nil;
}

@end
