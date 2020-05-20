//
//  WMZFormTextViewCell.h
//  WMZForm
//
//  Created by wmz on 2020/4/27.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZFormTextViewCell : WMZFormBaseCell
@property(nonatomic,strong)UITextView *writeView;
@property(nonatomic,strong)UILabel *titleLa;
@end

NS_ASSUME_NONNULL_END
