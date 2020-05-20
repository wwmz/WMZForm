//
//  WMZFormIconCell.m
//  WMZForm
//
//  Created by wmz on 2020/4/22.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormIconCell.h"

@implementation WMZFormIconCell
- (void)UI{
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset);
        make.top.mas_equalTo(FormYOffset);
        make.size.mas_equalTo(FormDefaultImageSize).priorityHigh();
    }];
    
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(FormXOffset);
        make.right.mas_equalTo(-FormXOffset);
        make.top.equalTo(self.iconImageView.mas_top);
    }];
    
    self.detailLa = [UILabel new];
    [self.contentView addSubview:self.detailLa];
    [self.detailLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLa.mas_left);
        make.top.equalTo(self.nameLa.mas_bottom).offset(5);
        make.right.mas_equalTo(-FormXOffset);
    }];
    
    [self.contentView addSubview:self.allTextLa];
    self.allTextLa.userInteractionEnabled = YES;
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allText:)];
    [self.allTextLa addGestureRecognizer:ta];
    [self.allTextLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLa.mas_left);
        make.top.equalTo(self.detailLa.mas_bottom).offset(5);
        make.bottom.mas_equalTo(-5);
    }];
}

- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    self.nameLa.numberOfLines = 1;
    self.iconImageView.image = [UIImage formBundleImage:model.formIcon?:@""];
    if (model.formCustomImageView) {
        model.formCustomImageView(self.iconImageView);
    }else{
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        self.iconImageView.layer.masksToBounds = NO;
        self.iconImageView.layer.cornerRadius = 0;
    }

    if (!model.oneLineHeight) {
        model.oneLineHeight = [WMZFormTool heightForTextView:CGSizeMake(self.frame.size.width-FormXOffset*2, CGFLOAT_MAX) WithText:@"测试" WithFont:self.detailLa.font.pointSize];
    }
    if (!model.maxLineHeight) {
        model.maxLineHeight = [WMZFormTool heightForTextView:CGSizeMake(self.frame.size.width-FormXOffset*2, CGFLOAT_MAX) WithText:model.formDetail WithFont:self.detailLa.font.pointSize];
    }
    NSInteger minLine = model.formRowData[@"minLines"]?[model.formRowData[@"minLines"] intValue]:FormMinLines;
    BOOL show = NO;
    if (model.maxLineHeight>model.oneLineHeight*minLine) {
        show = YES;
    }
    self.detailLa.numberOfLines = show?(model.isSelected?0:minLine):0;
    self.allTextLa.text =  show?(model.isSelected?@"收起":@"全文"):@"";
    model.changeHeight = YES;
}

- (void)allText:(UITapGestureRecognizer*)ta{
    self.model.isSelected = !self.model.isSelected;
    self.allTextLa.text =  self.model.isSelected?@"收起":@"全文";
    NSInteger minLine = self.model.formRowData[@"minLines"]?[self.model.formRowData[@"minLines"] intValue]:FormMinLines;
    self.detailLa.numberOfLines = self.model.isSelected?0:minLine;
    [self tableViewUpdate];
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}
- (UILabel *)allTextLa{
    if (!_allTextLa) {
        _allTextLa = [UILabel new];
        _allTextLa.textColor = FormAllTextColor;
    }
    return _allTextLa;
}

@end
