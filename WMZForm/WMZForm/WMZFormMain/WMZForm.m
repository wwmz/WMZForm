

//
//  WMZForm.m
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZForm.h"
@interface WMZForm()<UITableViewDataSource,UITableViewDelegate,WMZFormCellDelegate>
//嵌套数据类型
@property(nonatomic,assign)BOOL nested;
//嵌套数据类型
@property(nonatomic,weak)id <WMZFormDelegate> formDelegate;
//发生改变
@property(nonatomic,assign)BOOL change;
@end
@implementation WMZForm
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (![IQKeyboardManager sharedManager].enable) {
            [[IQKeyboardManager sharedManager] setEnable:YES];
        }
        if (![IQKeyboardManager sharedManager].enableAutoToolbar) {
            [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
        }
        [self.arrayModel addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
        self.tableView.frame = self.bounds;
        [self addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.emptyView = [[WMZFormEmptyView alloc]initWithFrame:self.bounds data:@{@"name":@"暂无数据",@"image":@"formIcon"}];
        self.emptyView.tag = 10086;
        [self addSubview:self.emptyView];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"dataArray"]) {
        self.change = YES;
        self.tableView.hidden = !self.arrayModel.dataArray.count;
        self.emptyView.hidden = self.arrayModel.dataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    WMZFormSectionModel *model = [self wFindSectionModelWithIndex:section];
    return model&&model.formSectionData.count?model.formFootHeight:0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    WMZFormSectionModel *model = [self wFindSectionModelWithIndex:section];
    return model&&model.formSectionData.count?model.formHeadHeight:0.01;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WMZFormFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([WMZFormFootView class])];
    WMZFormSectionModel *model = [self wFindSectionModelWithIndex:section];
    footView.contentView.backgroundColor = model.formFootBackGround?:FormColor(0xeeeeee);
    footView.textLa.text = model?model.formFootTitle:@"";
    footView.accessBtn.hidden = YES;
    footView.contentView.hidden = model&&model.formSectionData.count?NO:YES;
    return footView;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WMZFormHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([WMZFormHeadView class])];
    WMZFormSectionModel *model = [self wFindSectionModelWithIndex:section];
    headView.contentView.backgroundColor = model.formHeadBackGround?:FormColor(0xeeeeee);
    headView.textLa.text = model?model.formHeadTitle:@"";
    headView.accessBtn.selected = model.open;
    [headView.accessBtn setImage:[UIImage formBundleImage:@"form_dowm"] forState:UIControlStateNormal];
    [headView.accessBtn setImage:[UIImage formBundleImage:@"form_up"] forState:UIControlStateSelected];
    headView.accessBtn.hidden = !model;
    headView.accessBtn.tag = 10000 + section;
    headView.accessBtn.hidden = !model.formSectionInfo[@"fold"];
    [headView.accessBtn addTarget:self action:@selector(headViewAccessBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    headView.contentView.hidden = model&&model.formSectionData.count?NO:YES;
    return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id arr = self.nested?self.arrayModel.dataArray[section]:self.arrayModel.dataArray;
    NSInteger count = 1;
    if ([arr isKindOfClass:[NSArray class]]) {
        count =  [arr count];
    }else if ([NSStringFromClass([arr class]) isEqualToString:@"WMZFormSectionModel"]) {
        WMZFormSectionModel *sectionModel = (WMZFormSectionModel*)arr;
        count =  sectionModel.open?0:sectionModel.formSectionData.count;
    }
    return count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger count = self.nested?self.arrayModel.dataArray.count:(self.arrayModel.dataArray.count?1:0);
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WMZFormRowModel *model =  [self getIndexData:indexPath];
    //缓存高度
    if (model.formCellHeight > 0 && !model.changeHeight) {
        return model.formCellHeight;
    }else{
        return UITableViewAutomaticDimension;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WMZFormRowModel *model =  [self getIndexData:indexPath];
    NSString *cellName = ([model.formCellName isKindOfClass:[NSNumber class]]?self.cellTypeDic[model.formCellName]:model.formCellName);
    WMZFormBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[NSClassFromString(cellName) new]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    model.formWidth = tableView.frame.size.width;
    model.indexPath = indexPath;
    cell.model = model;
    cell.formDelagate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    WMZFormRowModel *model =  [self getIndexData:indexPath];
    model.formCellHeight = cell.frame.size.height;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    WMZFormRowModel *model =  [self getIndexData:indexPath];
    model.formSliderDelete = YES;
    return model.formSliderDelete;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self wDeleteFormRowWithIndexPath:indexPath];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WMZFormRowModel *model =  [self getIndexData:indexPath];
    if (model.formSelectInfo&&!model.formSelectInfo[@"check"]) {
        FormWeakSelf(self)
        [self clickWithType:model.formSelectInfo[@"type"]?[model.formSelectInfo[@"type"] intValue]:FormCellTypeSelect model:model block:^(id  _Nullable anyId) {
            model.formValue = anyId;
            FormStrongSelf(weakObject)
            [strongObject.tableView beginUpdates];
            [strongObject.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [strongObject.tableView endUpdates];
        }];
    }else{
        if (self.formDelegate&&[self.formDelegate respondsToSelector:@selector(form:didSelectRowAtCell:)]) {
            [self.formDelegate form:self didSelectRowAtCell:[tableView cellForRowAtIndexPath:indexPath]];
        }
    }
}
- (WMZFormRowModel*)getIndexData:(NSIndexPath*)indexPath{
    if (self.nested) {
        if ([self.arrayModel.dataArray[indexPath.section] isKindOfClass:[NSArray class]]) {
            if ([self.arrayModel.dataArray[indexPath.section] count]>0) {
                return [self checkModel:self.arrayModel.dataArray[indexPath.section][indexPath.row]];
            }else{
                 return [self checkModel:nil];
            }
        }else if ([NSStringFromClass([self.arrayModel.dataArray[indexPath.section]class]) isEqualToString:@"WMZFormSectionModel"]) {
            WMZFormSectionModel *sectionModel = (WMZFormSectionModel*)self.arrayModel.dataArray[indexPath.section];
            if (sectionModel.formSectionData.count>0) {
                return [self checkModel:sectionModel.formSectionData[indexPath.row]];
            }else{
                return [self checkModel:nil];
            }
        }else{
           return [self checkModel:self.arrayModel.dataArray[indexPath.section]];
        }
    }else{
        return [self checkModel:self.arrayModel.dataArray[indexPath.row]];
    }
}
#pragma -mark action
- (void)headViewAccessBtnAction:(UIButton*)sender{
    sender.selected = ![sender isSelected];
    WMZFormSectionModel *model = [self checkModel:self.arrayModel.dataArray[sender.tag - 10000] withClassName:@"WMZFormSectionModel" nested:YES];
    model.open = [sender isSelected];
    [UIView setAnimationsEnabled:NO];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 10000] withRowAnimation:UITableViewRowAnimationNone];
    [UIView setAnimationsEnabled:YES];
}
#pragma -mark Celldelegate
- (void)didSelectCell:(WMZFormBaseCell *)cell target:(UIView *)view action:(id)action{
    if ([view isKindOfClass:[UIButton class]]&&
        [action isKindOfClass:[NSNumber class]]&&
        ([action intValue] == FormClickCommit)){
        __block NSMutableArray *marr = [NSMutableArray new];
        [self.arrayModel.dataArray enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[WMZFormRowModel class]]) {
                if (obj.formKey&&[obj.formKey length]) {
                    [marr addObject:obj];
                }
            }else if ([obj isKindOfClass:[WMZFormSectionModel class]]){
                WMZFormSectionModel *sender = (WMZFormSectionModel*)obj;
                
                [sender.formSectionData enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (row.formKey&&[row.formKey length]) {
                        [marr addObject:row];
                    }
                }];
            }else if ([obj isKindOfClass:[NSArray class]]){
                NSArray *rowArr = (NSArray*)obj;
                WMZFormRowModel *row = rowArr[0];
                if (row&&row.formKey&&[row.formKey length]) {
                    [marr addObject:row];
                }
            }
        }];
        
        __block BOOL success = YES;
        NSMutableDictionary *mDic = [NSMutableDictionary new];
        [marr enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[WMZFormRowModel class]]) {
                __block NSMutableArray *marr = [NSMutableArray new];
                if ([obj.formValue isKindOfClass:[NSArray class]]) {
                    [obj.formValue enumerateObjectsUsingBlock:^(WMZFormTreeModel*  _Nonnull tree, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([tree isKindOfClass:[WMZFormTreeModel class]]) {
                            if (tree.isSelected) {
                                [marr addObject:tree];
                            }
                        }
                    }];
                    [mDic setValue:marr.count?marr:@[] forKey:obj.formKey];
                    if (!marr.count) {
                        if (obj.formRequired) {
                            success = NO;
                        }
                    }
                }else{
                    [mDic setValue:(obj.formValue?:@"") forKey:obj.formKey];
                    if (!obj.formValue||
                        ([obj.formValue isKindOfClass:[NSString class]]&&![obj.formValue length])) {
                        success = NO;
                        if (obj.formRequired) {
                            success = NO;
                        }
                    }
                }
            }
        }];
        if (self.formDelegate&&[self.formDelegate respondsToSelector:@selector(form:info:canCommit:)]) {
            [self.formDelegate form:self info:[NSDictionary dictionaryWithDictionary:mDic] canCommit:success];
        }
    }else{
        if (self.formDelegate&&[self.formDelegate respondsToSelector:@selector(form:subViewDidSelectRowAtCell:view:type:)]) {
            [self.formDelegate form:self subViewDidSelectRowAtCell:cell view:view type:action];
        }
    }
    if (cell.model.formClickBlock) {
        cell.model.formClickBlock(cell, action);
    }
}
- (WMZFormRowModel*)checkModel:(id)model{
    if (model&&[model isKindOfClass:[WMZFormRowModel class]]) {
        WMZFormRowModel *temp = (WMZFormRowModel*)model;
        return  temp;
    }
    WMZFormRowModel *cell = FormRowModel();
    return cell;
}
- (id)checkModel:(id)model withClassName:(NSString*)modelClassName nested:(BOOL)nested{
    id result = nil;
    if (nested) {
        if (self.nested&&[NSStringFromClass([model class]) isEqualToString:modelClassName]) {
            result = model;
        }
    }else{
        if ([NSStringFromClass([model class]) isEqualToString:modelClassName]) {
            result = model;
        }
    }
    return result;
}
- (BOOL)nested{
    if (self.change) {
        _nested = NO;
        for (id data in self.arrayModel.dataArray) {
            if (![NSStringFromClass([data class]) isEqualToString:@"WMZFormRowModel"]) {
                _nested = YES;
                break;
            }
        }
        self.change = NO;
        return _nested;
    }else{
        return _nested;
    }
}
//addRow 非初始化增加row调用 默认插入最后
- (BOOL)wAddFormRow:(WMZFormRowModel*)rowModel{
    return [self wAddFormRow:rowModel atIndex:self.arrayModel.dataArray.count];
}
//addRow 非初始化增加row调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormRowBlock:(FormRowBlock)addFormRow atIndex:(NSInteger)index{
    WMZFormRowModel *rowModel = FormRowModel();
    if (addFormRow) {
        addFormRow(rowModel);
    }
    return [self wAddFormRow:rowModel atIndex:index];
}
//addSection 非初始化增加section调用 默认插入最后
- (BOOL)wAddFormSection:(WMZFormSectionModel*)sectionModel{
   return [self wAddFormSection:sectionModel atIndex:self.arrayModel.dataArray.count];
}
//addSection 非初始化增加section调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormSectionBlock:(FormSectionBlock)addFormSection atIndex:(NSInteger)index{
    WMZFormSectionModel *sectionModel = FormSectionModel();
    if (addFormSection) {
        addFormSection(sectionModel);
    }
    return [self wAddFormSection:sectionModel atIndex:index];
}
//deleleSectionWithKey
- (BOOL)wDeleteFormSectionWithKey:(NSString*)key{
    return [[[self findSectionModelWithKey:key withIndex:0 withType:FormFindRowTypeKey actionType:FormRowActionDelete] objectForKey:@"result"] boolValue];
}
//deleleSectionWithKey
- (BOOL)wDeleteFormSectionWithIndex:(NSInteger)index{
    return [[[self findSectionModelWithKey:nil withIndex:index withType:FormFindRowTypeIndex actionType:FormRowActionDelete] objectForKey:@"result"] boolValue];
}
//deleleRowWithKey
- (BOOL)wDeleteFormRowWithKey:(NSString*)key{
    return [[[self findRowModelWithKey:key withIndexPath:nil withType:FormFindRowTypeKey actionType:FormRowActionDelete] objectForKey:@"result"] boolValue];
}
//deleleRowWithIndexPath
- (BOOL)wDeleteFormRowWithIndexPath:(NSIndexPath*)indexPath{
   return [[[self findRowModelWithKey:nil withIndexPath:indexPath withType:FormFindRowTypeIndexPath actionType:FormRowActionDelete] objectForKey:@"result"] boolValue];
}
//reloadSection With key
- (BOOL)wReloadSectionWithKey:(NSString*)key{
   return [[[self findSectionModelWithKey:key withIndex:0 withType:FormFindRowTypeKey actionType:FormRowActionReload] objectForKey:@"result"] boolValue];
}
//reloadSection With index
- (BOOL)wReloadSectionWithIndex:(NSInteger)index{
    return [[[self findSectionModelWithKey:nil withIndex:index withType:FormFindRowTypeIndex actionType:FormRowActionReload] objectForKey:@"result"] boolValue];
}
//reloadRow With key
- (BOOL)wReloadRowWithKey:(NSString*)key{
    return [[[self findRowModelWithKey:key withIndexPath:nil withType:FormFindRowTypeKey actionType:FormRowActionReload] objectForKey:@"result"] boolValue];
}
//reloadRow With key
- (BOOL)wReloadRowWithIndexPath:(NSIndexPath*)indexPath{
     return [[[self findRowModelWithKey:nil withIndexPath:indexPath withType:FormFindRowTypeIndexPath actionType:FormRowActionReload] objectForKey:@"result"] boolValue];
}
//getRow With key
- (WMZFormRowModel*)wFindRowModelWithKey:(NSString*)key{
    return [[self findRowModelWithKey:key withIndexPath:nil withType:FormFindRowTypeKey actionType:FormRowActionFind] objectForKey:@"model"];
}
//getRow With indexPath
- (WMZFormRowModel*)wFindRowModelWithIndexPath:(NSIndexPath*)indexPath{
    return [[self findRowModelWithKey:nil withIndexPath:indexPath withType:FormFindRowTypeIndexPath actionType:FormRowActionFind] objectForKey:@"model"];
}
//getSection With key
- (WMZFormSectionModel*)wFindSectionModelWithKey:(NSString*)key{
   return [[self findSectionModelWithKey:key withIndex:0 withType:FormFindRowTypeKey actionType:FormRowActionFind] objectForKey:@"sectionModel"];
}
//getSection With index
- (WMZFormSectionModel*)wFindSectionModelWithIndex:(NSInteger)index{
    return [[self findSectionModelWithKey:nil withIndex:index withType:FormFindRowTypeIndex actionType:FormRowActionFind] objectForKey:@"sectionModel"];
}
//reloadData
- (void)wReloadData{
    [UIView setAnimationsEnabled:NO];
    [self.tableView reloadData];
    [UIView setAnimationsEnabled:YES];
}
//自定义刷新
- (void)wReloadData:(FormCustomReload)block{
    [UIView setAnimationsEnabled:NO];
    if (block) {
        block(self.tableView);
    }else{
        [self.tableView reloadData];
    }
    [UIView setAnimationsEnabled:YES];
}
//addRow 非初始化增加row调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormRow:(WMZFormRowModel*)rowModel atIndex:(NSInteger)index{
    __block BOOL result = NO;
    if (!rowModel||![rowModel isKindOfClass:[WMZFormRowModel class]]){
        NSLog(@"请输入正确的rowModel"); return result;
    }
    if (index>=0&&index>(self.arrayModel.dataArray.count)){
        NSLog(@"请输入正确的index"); return result;
    }
    BOOL nested = [[self valueForKey:@"nested"] boolValue];
    if (index < 0) {
        [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] addObject:nested?@[rowModel]:rowModel];
    }else{
        [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] insertObject:nested?@[rowModel]:rowModel atIndex:index];
    }
    if (index>=0) {
        [self wReloadData];
    }
    result = YES;
    return result;
}
//addSection 非初始化增加section调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormSection:(WMZFormSectionModel*)sectionModel atIndex:(NSInteger)index{
    __block BOOL result = NO;
    if (!sectionModel||![sectionModel isKindOfClass:[WMZFormSectionModel class]]){
        NSLog(@"请输入正确的sectionModel"); return result;
    }
    if (index>=0&&index>(self.arrayModel.dataArray.count)){
        NSLog(@"请输入正确的index"); return result;
    };
    BOOL nestedBefore = [[self valueForKey:@"nested"] boolValue];
    sectionModel.formSectionData = sectionModel.formSectionData;
    sectionModel.sectionIndex = index;
    if (index < 0) {
        [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] addObject:sectionModel];
    }else{
        [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] insertObject:sectionModel atIndex:index];
    }
    BOOL change = NO;
    BOOL nestedAfter = [[self valueForKey:@"nested"] boolValue];
    if (nestedBefore!=nestedAfter) {
        change = YES;
        [self.arrayModel.dataArray enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[WMZFormRowModel class]]) {
                [self.arrayModel.dataArray replaceObjectAtIndex:idx withObject:@[obj]];
            }
        }];
    }
    
    if (index>=0) {
        [self wReloadData];
    }
    result = YES;
    return result;
}
- (NSDictionary*)findRowModelWithKey:(NSString*)key
              withIndexPath:(NSIndexPath*)indexPath
                   withType:(FormFindRowType)typp
                 actionType:(FormRowActionType)action{
       
     NSArray *arr = self.arrayModel.dataArray;
//      NSLog(@"%@",arr);
    __block NSMutableDictionary *mdic  = [NSMutableDictionary new];
    [mdic setObject:@(NO) forKey:@"result"];
    if (typp == FormFindRowTypeKey) {
        if (!key|| ![key isKindOfClass:[NSString class]]) {
             NSLog(@"请输入正确的key");
            return [NSDictionary dictionaryWithDictionary:mdic];
        };
    }else if(typp == FormFindRowTypeIndexPath){
        if (!indexPath||![indexPath isKindOfClass:[NSIndexPath class]]){
            NSLog(@"请输入正确的indexPath");
            return [NSDictionary dictionaryWithDictionary:mdic];
        };
    }else{
        return [NSDictionary dictionaryWithDictionary:mdic];
    }
    BOOL nested = [[self valueForKey:@"nested"] boolValue];
    
    [self.arrayModel.dataArray enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[WMZFormSectionModel class]]) {
            WMZFormSectionModel *section = (WMZFormSectionModel*)obj;
            [section.formSectionData enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull tmpObj, NSUInteger idx, BOOL * _Nonnull stop1) {
                  if ([tmpObj isKindOfClass:[WMZFormRowModel class]]) {
                      if (typp == FormFindRowTypeKey &&
                          [tmpObj.formKey isEqualToString:key]) {
                          [mdic setObject:tmpObj forKey:@"model"];
                          [mdic setObject:obj forKey:@"sectionModel"];
                          *stop = YES;
                      }else if(typp == FormFindRowTypeIndexPath &&
                               ([tmpObj.indexPath compare:indexPath] == NSOrderedSame)){
                          [mdic setObject:tmpObj forKey:@"model"];
                          [mdic setObject:obj forKey:@"sectionModel"];
                          *stop = YES;
                      }
                   }
            }];
        }else{
            if (nested) {
                if ([obj isKindOfClass:[NSArray class]]) {
                    NSArray *modelArr = (NSArray*)obj;
                    WMZFormRowModel *rowModel = modelArr.firstObject;
                    if (typp == FormFindRowTypeKey &&
                        [rowModel.formKey isEqualToString:key]) {
                        [mdic setObject:rowModel forKey:@"model"];
                        [mdic setObject:obj forKey:@"rowArr"];
                        *stop = YES;
                    }else if(typp == FormFindRowTypeIndexPath &&
                        ([rowModel.indexPath compare:indexPath] == NSOrderedSame)){
                        [mdic setObject:rowModel forKey:@"model"];
                        [mdic setObject:obj forKey:@"rowArr"];
                        *stop = YES;
                    }
                  }
            }else{
                if ([obj isKindOfClass:[WMZFormRowModel class]]) {
                    if (typp == FormFindRowTypeKey &&
                        [obj.formKey isEqualToString:key]) {
                        [mdic setObject:obj forKey:@"model"];
                        [mdic setObject:@(YES) forKey:@"self"];
                        *stop = YES;
                    }else if(typp == FormFindRowTypeIndexPath &&
                             ([obj.indexPath compare:indexPath] == NSOrderedSame)){
                             [mdic setObject:obj forKey:@"model"];
                             [mdic setObject:@(YES) forKey:@"self"];
                             *stop = YES;
                    }
                }
            }
          }
    }];
    WMZFormRowModel *rowModel = mdic[@"model"];
    if (rowModel) {
        //删除
        if (action == FormRowActionDelete) {
            WMZFormSectionModel *sectionModel = mdic[@"sectionModel"];
            NSArray *rowArr = mdic[@"rowArr"];
            id rowSelf = mdic[@"self"];
            if (sectionModel) {
                NSMutableArray *mArr = [NSMutableArray arrayWithArray:sectionModel.formSectionData];
                NSInteger index = [mArr indexOfObject:rowModel];
                if (index!=NSNotFound) {
                    [mArr removeObject:rowModel];
                    sectionModel.formSectionData = [NSArray arrayWithArray:mArr];
                    if (mArr.count> 0) {
                        [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] replaceObjectAtIndex:indexPath.section withObject:sectionModel];
                        
                    }else{
                        [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] removeObjectAtIndex:indexPath.section];
                    }
                    

                }
            }
            if (rowArr) {
                NSInteger index = [self.arrayModel.dataArray indexOfObject:rowArr];
                if (index!=NSNotFound) {
                    [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] removeObject:rowArr];
      
                }
            }
            if (rowSelf) {
                [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] removeObject:rowModel];
   
            }
          //更新
        }else if (action == FormRowActionReload){

        }
        [self wReloadData];;
    }
    [mdic setObject:rowModel?@(YES):@(NO) forKey:@"result"];
    return mdic;
}

- (NSDictionary*)findSectionModelWithKey:(NSString*)key
                              withIndex:(NSInteger)index
                               withType:(FormFindRowType)typp
                             actionType:(FormRowActionType)action{
    __block NSMutableDictionary *mdic  = [NSMutableDictionary new];
    [mdic setObject:@(NO) forKey:@"result"];
    if (typp == FormFindRowTypeKey) {
        if (!key|| ![key isKindOfClass:[NSString class]]) {
             NSLog(@"请输入正确的key");
            return [NSDictionary dictionaryWithDictionary:mdic];
        };
    }else if(typp == FormFindRowTypeIndex){
        if (index>(self.arrayModel.dataArray.count-1)){
            NSLog(@"请输入正确的index");
            return [NSDictionary dictionaryWithDictionary:mdic];
        };
    }else{
        return [NSDictionary dictionaryWithDictionary:mdic];
    }
   
    if (typp == FormFindRowTypeKey) {
        [self.arrayModel.dataArray enumerateObjectsUsingBlock:^(WMZFormSectionModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if ([obj isKindOfClass:[WMZFormSectionModel class]]) {
                   if (typp == FormFindRowTypeKey ) {
                       if ([obj.formSectionKey isEqualToString:key]) {
                           [mdic setObject:obj forKey:@"sectionModel"];
                           [mdic setObject:@(idx) forKey:@"sectionIndex"];
                           *stop = YES;
                       }
                   }
               }
        }];
    }else if (typp == FormFindRowTypeIndex) {
        WMZFormSectionModel *sectionModel = self.arrayModel.dataArray[index];
        if ([sectionModel isKindOfClass:[WMZFormSectionModel class]]) {
            [mdic setObject:sectionModel forKey:@"sectionModel"];
            [mdic setObject:@(index) forKey:@"sectionIndex"];
            
        }
    }
    WMZFormSectionModel *sectionModel = mdic[@"sectionModel"];
    if (sectionModel) {
        NSInteger resultIndex =  [mdic[@"sectionIndex"] integerValue];
        //删除
        if (action == FormRowActionDelete) {
            [[self.arrayModel mutableArrayValueForKeyPath:@"dataArray"] removeObjectAtIndex:resultIndex];
             [self wReloadData];
          //更新
        }else if (action == FormRowActionReload){
            sectionModel.formSectionData = sectionModel.formSectionData;
            [self wReloadData];
        }
    }
    [mdic setObject:sectionModel?@(YES):@(NO) forKey:@"result"];
    return mdic;
}
WMZForm * Form(CGRect rect){
    return [[WMZForm alloc]initWithFrame:rect];
}
- (WMZForm * _Nonnull (^)(FormRowBlock _Nonnull))wAddFormRow{
    return ^WMZForm*(FormRowBlock addFormRow){
        [self wAddFormRowBlock:addFormRow atIndex:-1];
        return self;
    };
}
- (WMZForm * _Nonnull (^)(FormSectionBlock _Nonnull))wAddFormSection{
    return ^WMZForm*(FormSectionBlock addFormSection){
        [self wAddFormSectionBlock:addFormSection atIndex:-1];
        return self;
    };
};
- (WMZForm * _Nullable (^)(id<WMZFormDelegate> _Nonnull))wAddFormDelegate{
     return ^WMZForm*(id<WMZFormDelegate> formDelegate){
        self.formDelegate = formDelegate;
        return self;
     };
}
- (WMZForm * _Nonnull (^)(NSDictionary * _Nonnull))wAddFormEmptyInfo{
    return ^WMZForm*(NSDictionary* formEmptyInfo){
        self.emptyView.data = formEmptyInfo;
       return self;
    };
}
@end
