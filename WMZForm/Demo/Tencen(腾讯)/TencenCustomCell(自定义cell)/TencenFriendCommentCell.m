





//
//  TencenFriendCommentCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "TencenFriendCommentCell.h"

@implementation TencenFriendCommentCell

- (void)UI{
    [self.contentView addSubview:self.labelView];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Form_GetWNum(140));
        make.right.mas_equalTo(-FormXOffset);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.nameLa = [UILabel new];
    [self.labelView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.equalTo(self.labelView.mas_top);
        make.bottom.equalTo(self.labelView.mas_bottom);
    }];
}
- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
     self.nameLa.numberOfLines = 0;
     int x = arc4random() % 2;
    NSString *name = [NSString stringWithFormat:@"%@回复%@: %@",model.formDetail,model.formWarn,model.formName];
    if (x == 0) {
        name = [NSString stringWithFormat:@"%@: %@",model.formDetail,model.formName];
    }
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:name];
    [mStr addAttribute:NSForegroundColorAttributeName value:FormColor(0x5297E1) range:[name rangeOfString:model.formDetail]];
    [mStr addAttribute:NSForegroundColorAttributeName value:FormColor(0x5297E1) range:[name rangeOfString:model.formWarn]];
    self.nameLa.attributedText = mStr;
}
- (UIView *)labelView{
    if (!_labelView) {
        _labelView = [UIView new];
        _labelView.backgroundColor = FormColor(0xf7f7f7);
    }
    return _labelView;
}

@end
