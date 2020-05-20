



//
//  WMZFormCommitCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormCommitCell.h"

@implementation WMZFormCommitCell

- (void)UI{
    [self.contentView addSubview:self.commit];
}

- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    CGFloat top =  0;
    if (model.formRowData[@"fill"]) {
        top = model.formRowData[@"top"]?[model.formRowData[@"top"] floatValue]:0;
        self.commit.frame = CGRectMake(0, top, model.formWidth, FormConfirmHeight);
        model.formCellHeight = CGRectGetMaxY(self.commit.frame);
    }else{
        top = model.formRowData[@"top"]?[model.formRowData[@"top"] floatValue]:FormYOffset;
        self.commit.frame = CGRectMake(FormXOffset, top, model.formWidth - 2*FormXOffset, FormConfirmHeight);
        model.formCellHeight = CGRectGetMaxY(self.commit.frame)+FormYOffset;
    }
    self.commit.userInteractionEnabled = !model.formRowData[@"fill"];
    if (model.formCustomButton) {
        model.formCustomButton(self.commit);
    }else{
        self.commit.backgroundColor = [UIColor orangeColor];
        [self.commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.commit.layer.masksToBounds = NO;
        self.commit.layer.borderWidth = 0;
        self.commit.layer.cornerRadius = 0;
    }
    [self.commit setTitle:model.formBtn forState:UIControlStateNormal];
}

- (void)commitAction:(WMZFormBtn*)sender{
   if (self.model.formRowData[@"type"]) {
       if (self.formDelagate&&[self.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
           [self.formDelagate didSelectCell:self target:sender action:@([self.model.formRowData[@"type"] intValue])];
       }
   }else{
       if (self.formDelagate&&[self.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
           [self.formDelagate didSelectCell:self target:sender action:@(FormClickCommit)];
       }
   }
}

- (WMZFormBtn *)commit{
    if (!_commit) {
        _commit = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
        [_commit addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commit;
}

@end
