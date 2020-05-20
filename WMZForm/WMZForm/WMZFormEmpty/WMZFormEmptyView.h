//
//  WMZFormEmptyView.h
//  WMZForm
//
//  Created by wmz on 2020/5/1.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WMZFormEmptyView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)NSDictionary *data;
- (instancetype)initWithFrame:(CGRect)frame data:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
