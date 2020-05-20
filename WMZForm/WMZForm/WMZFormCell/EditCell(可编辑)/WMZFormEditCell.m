


//
//  WMZFormEditCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/13.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormEditCell.h"

@implementation WMZFormEditCell

- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(FormXOffset);
        make.top.equalTo(self.contentView).offset(FormYOffset).priorityHigh();
    }];
    [self.contentView addSubview:self.valueLa];
    [self.valueLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLa.mas_right).offset(FormXOffset);
        make.right.equalTo(self.contentView).offset(-FormXOffset);
        make.bottom.equalTo(self.contentView).offset(-FormYOffset).priorityHigh();
        make.top.equalTo(self.contentView).offset(FormYOffset);
    }];
    [self.nameLa setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.valueLa setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}
- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    if (model.formCustomValueLabel) {
        model.formCustomValueLabel(self.valueLa);
    }else{
        self.valueLa.font = [UIFont systemFontOfSize:FormDefaultDetailFont];
        self.valueLa.textAlignment = NSTextAlignmentRight;
        self.valueLa.numberOfLines = 1;
        self.valueLa.backgroundColor = [UIColor clearColor];
        self.valueLa.layer.masksToBounds = NO;
        self.valueLa.layer.borderWidth = 0;
    }
    self.valueLa.text = model.formValue?:(model.formSelectInfo[@"title"]?:@" ");
    self.valueLa.textColor = model.formValue?FormDefaultDetailColor:FormColor(0x999999);
    if (model.formSelectInfo[@"check"]) {
        self.accessoryType = model.isSelected? UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    }else{
        self.accessoryType = (model.formAccessoryType == -1)? UITableViewCellAccessoryNone:model.formAccessoryType;
    }
}
- (UILabel *)valueLa{
    if (!_valueLa) {
        _valueLa = [UILabel new];
    }
    return _valueLa;
}

@end
