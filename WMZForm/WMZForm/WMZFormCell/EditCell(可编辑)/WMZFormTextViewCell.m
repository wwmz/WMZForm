//
//  WMZFormTextViewCell.m
//  WMZForm
//
//  Created by wmz on 2020/4/27.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormTextViewCell.h"
@interface WMZFormTextViewCell()<UITextViewDelegate>
@end
@implementation WMZFormTextViewCell

- (void)UI{

    self.warningLabel = [UILabel new];
    [self.contentView addSubview:self.warningLabel];
    [self.warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(-FormYOffset);
         make.right.mas_equalTo(-FormXOffset);
    }];
    
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(FormXOffset).priorityHigh();
         make.top.mas_equalTo(FormYOffset);
         make.right.mas_equalTo(-FormXOffset);
    }];
    
    self.detailLa = [UILabel new];
    [self.contentView addSubview:self.detailLa];
    [self.detailLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLa.mas_bottom).offset(7);
        make.left.mas_equalTo(FormXOffset/2);
        make.width.lessThanOrEqualTo(self).multipliedBy(0.2);
    }];
    
    self.writeView.delegate = self;
    [self.contentView addSubview:self.writeView];
    [self.writeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLa.mas_right);
        make.width.lessThanOrEqualTo(self).multipliedBy(0.8);
        make.top.equalTo(self.nameLa.mas_bottom);
        make.bottom.equalTo(self.warningLabel.mas_top);
        make.height.mas_lessThanOrEqualTo(FormDefaulTextViewMaxHeight).priorityHigh();
        make.height.mas_greaterThanOrEqualTo(FormDefaulTextViewMinHeight).priorityHigh();
    }];

    [self.writeView addSubview:self.titleLa];
    [self.titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.top.mas_equalTo(6);
        make.right.mas_equalTo(0);
    }];
}

- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    if (model.formCustomTextView) {
        model.formCustomTextView(self.writeView);
    }else{
        self.writeView.font = [UIFont systemFontOfSize:FormDefaultDetailFont];
        self.writeView.textColor = FormDefaultDetailColor;
        self.writeView.textAlignment = NSTextAlignmentLeft;
    }
    self.warningLabel.textColor = FormColor(0x666666);
    self.writeView.showsHorizontalScrollIndicator = NO;
    self.writeView.showsVerticalScrollIndicator = NO;
    self.writeView.text = model.formValue;
    self.titleLa.hidden = model.formValue&&[model.formValue length];
    self.warningLabel.hidden = !model.formRowData[@"maxNum"];
    self.warningLabel.text = model.formRowData[@"maxNum"]?[NSString stringWithFormat:@"%ld/%@",[model.formValue length],model.formRowData[@"maxNum"]]:@"";
    self.titleLa.text = model.formRowData[@"placeholder"]?:@"";
    self.detailLa.text = [NSString stringWithFormat:@" %@",model.formDetail?:@""];
    model.changeHeight = YES;
    [self.writeView layoutIfNeeded];
//    self.writeView.scrollEnabled = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    id maxNum = self.model.formRowData[@"maxNum"];
    if (maxNum&&textView.text.length>=[maxNum intValue]&&![text isEqual:@""]) {
        return NO;
    }
    NSString *mainText = @"";
    if ([text isEqual:@""]) {
        if (![textView.text isEqualToString:@""]) {
            mainText = [textView.text substringToIndex:[textView.text length] - 1];
        }else{
            mainText = textView.text;
        }
    }else{
        mainText = [NSString stringWithFormat:@"%@%@",textView.text,text];
    }
    if (maxNum) {
        if (mainText.length>[maxNum intValue]) {
             self.warningLabel.text = [NSString stringWithFormat:@"%@/%@",maxNum,maxNum];
            return NO;
        }else{
             self.warningLabel.text = [NSString stringWithFormat:@"%ld/%@",mainText.length,maxNum];
        }
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    [self tableViewUpdate];
//    if (self.writeView.frame.size.height>=FormDefaulTextViewMaxHeight&&self.writeView.scrollEnabled ==NO) {
//        self.writeView.scrollEnabled = YES;
//    }
    self.model.formValue = textView.text;
    self.titleLa.hidden = [textView.text length];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.formDelagate&&[self.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
        [self.formDelagate didSelectCell:self target:textView action:@"editTextFieldAction"];
    }
}
- (UITextView *)writeView{
    if (!_writeView) {
        _writeView = [UITextView new];
        _writeView.scrollEnabled = YES;
    }
    return _writeView;
}
- (UILabel *)titleLa{
    if (!_titleLa) {
        _titleLa = [UILabel new];
        _titleLa.textColor = FormColor(0x999999);
        _titleLa.font = [UIFont systemFontOfSize:FormDefaultNameFont];
        _titleLa.numberOfLines = 0;
    }
    return _titleLa;
}

@end
