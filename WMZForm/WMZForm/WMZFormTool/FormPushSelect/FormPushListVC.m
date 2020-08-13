//
//  FormPushListVC.m
//  WMZForm
//
//  Created by wmz on 2020/5/13.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "FormPushListVC.h"
@interface FormPushListVC ()<WMZFormDelegate>
@property(nonatomic,strong)WMZForm *form;
@end

@implementation FormPushListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.info[@"title"]?:@"列表选择";
    self.view.backgroundColor = [UIColor whiteColor];
    FormWeakSelf(self)
    self.form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height))
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
         FormStrongSelf(weakObject)
          sectionModel
          .wFormSectionData([strongObject getArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellEdit));
    })
    .wAddFormDelegate(self);
    [self.view addSubview:self.form];
    
    if (self.info[@"multipleSelection"]) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem = barItem;
    }
    if (self.navigationController&&
        !self.navigationController.navigationBar.translucent) {
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
}

- (void)onBtnAction{
    if (self.block) {
        NSMutableString *string = [NSMutableString new];
        NSMutableArray *modelArr = [NSMutableArray new];
        WMZFormSectionModel *sectionModel = self.form.arrayModel.dataArray[0];
        [sectionModel.formSectionData enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                [string appendFormat:@",%@",obj.formName];
                [modelArr addObject:obj];
            }
        }];
        if (modelArr.count) {
            [string deleteCharactersInRange:NSMakeRange(0, 1)];
            self.block(string, [NSArray arrayWithArray:modelArr]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSArray*)getArr{
    NSMutableArray *marr = [NSMutableArray new];
    if (self.info[@"data"]&&
        [self.info[@"data"] isKindOfClass:[NSArray class]]) {
        NSArray *data = [NSArray arrayWithArray:self.info[@"data"]];
        for (int i = 0; i<data.count; i++) {
            id row = data[i];
            NSString *name = @" ";
            if ([row isKindOfClass:[NSString class]]) {
                name = row;
            }else if([row isKindOfClass:[NSDictionary class]]) {
                name = row[@"name"];
            }
             WMZFormRowModel *model =
             FormRowModel()
            .wFormSelectInfo(@{@"check":@(YES)})
            .wFormRowData(row)
            .wFormName(name);
            
            if (self.selectModel) {
                if ([self.selectModel isKindOfClass:[NSArray class]]) {
                    [self.selectModel enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj.formName isEqualToString:model.formName]) {
                            model.isSelected = obj.isSelected;
                        }
                    }];
                }
            }
            if ([row isKindOfClass:[NSDictionary class]]&&
                row[@"isSelected"]&&
                [row[@"isSelected"] boolValue]) {
                model.isSelected = YES;
            }
            [marr addObject:model];
        }
    }
    return [NSArray arrayWithArray:marr];
}

- (void)form:(WMZForm *)form didSelectRowAtCell:(WMZFormBaseCell *)cell{
    cell.model.isSelected = !cell.model.isSelected;
    if (!self.info[@"multipleSelection"]) {
        WMZFormSectionModel *sectionModel = form.arrayModel.dataArray[0];
        [sectionModel.formSectionData enumerateObjectsUsingBlock:^(WMZFormRowModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx!=cell.model.indexPath.row) {
                obj.isSelected = NO;
                if ([obj.formRowData isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:obj.formRowData];
                    [mdic setObject:@(NO) forKey:@"isSelected"];
                    obj.wFormRowData(mdic);
                }
            }
        }];
    }
    [form wReloadData];
    if (cell.model.isSelected&&!self.info[@"multipleSelection"]) {
        if (self.block) {
            self.block(cell.model.formName, @[cell.model]);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }
}

@end
