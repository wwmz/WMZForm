//
//  WMZFormImageCell.h
//  WMZForm
//
//  Created by wmz on 2020/5/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZFormImageCell : WMZFormBaseCell
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *photoArr;

@end

NS_ASSUME_NONNULL_END
