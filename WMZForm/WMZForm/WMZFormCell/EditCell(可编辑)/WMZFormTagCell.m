//
//  WMZFormTagCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormTagCell.h"
@implementation WMZFormTagCell
- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_offset(FormXOffset);
        make.width.mas_equalTo(self).multipliedBy(0.25);
    }];
    
    [self.contentView addSubview:self.myCollectionV];
    [self.myCollectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-FormXOffset);
        make.height.mas_lessThanOrEqualTo(FormDefaulCollectionMaxHeight).priorityHigh();
        make.height.mas_greaterThanOrEqualTo(FormDefaulCollectionMinHeight).priorityHigh();
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self).multipliedBy(0.65);
        make.top.mas_equalTo(0);
    }];
    
}
- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    __block NSMutableArray *arr = [NSMutableArray arrayWithArray:model.formValue?:@[]];
    __block BOOL treeModel = NO;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[WMZFormTreeModel class]]) {
            treeModel = YES;
            *stop = YES;
        }
    }];
    if (treeModel) {
        arr = (NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            WMZFormTreeModel *tree = [WMZFormTreeModel new];
            if ([obj isKindOfClass:[NSString class]]) {
                tree.name = obj;
                arr[idx] = tree;
            }else if ([obj isKindOfClass:[NSDictionary class]]){
                tree.name = obj[@"name"];
                tree.image = obj[@"image"];
                tree.selectImage = obj[@"selectImage"];
                tree.other = obj[@"other"];
                tree.isSelected = obj[@"isSelected"];
                tree.position = obj[@"position"]?[obj[@"position"] intValue]:0;
                tree.positionOffset = obj[@"positionOffset"]?[obj[@"positionOffset"] floatValue]:0;
                arr[idx] = tree;
            }else if ([obj isKindOfClass:[WMZFormTreeModel class]]){
                
            }else{
                arr[idx] = tree;
            }
        }];
    }
    model.formValue = [NSArray arrayWithArray:arr];
    [self.myCollectionV reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WMZFormTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WMZFormTagCollectionViewCell class]) forIndexPath:indexPath];
    WMZFormTreeModel * model = self.model.formValue[indexPath.row];
    if (![model isKindOfClass:[WMZFormTreeModel class]]) {
        return cell;
    }
    model.index = indexPath.row;
    cell.icon.model = model;
    [cell.icon setTitle:model.name?:@"" forState:UIControlStateNormal];
    [cell.icon setImage:[UIImage formBundleImage:model.image?:@" "] forState:UIControlStateNormal];
    [cell.icon setImage:[UIImage formBundleImage:model.selectImage?:@" "] forState:UIControlStateSelected];
    [cell.icon TagSetImagePosition:model.position?:FormBtnPositionLeft spacing:model.positionOffset];
    cell.icon.selected = model.isSelected;
    cell.icon.titleLabel.textAlignment = NSTextAlignmentCenter;
    cell.icon.titleLabel.font = [UIFont systemFontOfSize:FormDefaultBtnFont];
    [cell.icon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cell.icon setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    cell.icon.userInteractionEnabled = NO;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [(NSArray *)self.model.formValue count];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WMZFormTagCollectionViewCell *cell = (WMZFormTagCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (!self.model.formRowData[@"moreSelect"]) {
        [self.model.formValue enumerateObjectsUsingBlock:^(WMZFormTreeModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj!=cell.icon.model) {
                obj.isSelected = NO;
            }
        }];
    }
    cell.icon.model.isSelected = !cell.icon.model.isSelected;
    [self.myCollectionV reloadData];
}
- (UICollectionView *)myCollectionV{
    if (!_myCollectionV) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.itemSize = CGSizeMake(FormDefaulCollectionMinHeight, FormDefaulCollectionMinHeight);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.scrollEnabled = NO;
        _myCollectionV.showsVerticalScrollIndicator = NO;
        _myCollectionV.showsHorizontalScrollIndicator = NO;
        _myCollectionV.backgroundColor = [UIColor clearColor];
        _myCollectionV.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        [_myCollectionV registerClass:[WMZFormTagCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([WMZFormTagCollectionViewCell class])];
    }
    return _myCollectionV;
}
@end

@implementation WMZFormTagCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self.contentView addSubview:self.icon];
        self.icon.frame = self.contentView.bounds;
    }
    return self;
}
- (WMZFormBtn *)icon{
    if (!_icon) {
        _icon = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
    }
    return _icon;
}
@end
