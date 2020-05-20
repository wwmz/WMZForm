//
//  WMZFormTagCell.h
//  WMZForm
//
//  Created by wmz on 2020/5/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBaseCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface WMZFormTagCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)WMZFormBtn *icon;
@end
@interface WMZFormTagCell : WMZFormBaseCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *myCollectionV;
@end


NS_ASSUME_NONNULL_END
