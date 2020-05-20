//
//  TencenFriendGroupVC.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "TencenFriendGroupVC.h"

@interface TencenFriendGroupVC ()

@end

@implementation TencenFriendGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    FormWeakSelf(self)
    WMZForm *form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height- FormTabBarHeight));
    [self.view addSubview:form];
    NSInteger count = 20;
    for (int i = 0; i<count; i++) {
        //内容
        form.wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
            FormStrongSelf(weakObject)
            sectionModel
            .wFormSectionData([strongObject getFormArr]);
        });
        //评论
        form.wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
            FormStrongSelf(weakObject)
            sectionModel
            .wFormSectionData([strongObject getComnentArr]);
        });

        //占位图
        form.wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
            rowModel
            .wFormShowLine((i == count -1)?NO:YES)
            .wFormCellHeight(15);
        });
    }
}
- (NSArray*)getFormArr{
    return @[
        FormRowModel()
        .wFormCellName(@(FormCellIcon))
        .wFormIcon(@"formIcon")
        .wFormRowData(@{@"showAllText":@(YES)})
        .wFormName([self getRandomName])
        .wFormDetail([self getRandomDetail]),
        
        FormRowModel()
        .wFormCellName(@(FormCellImage))
        .wFormValue([self getRandomImage])
        .wFormRowData(@{@"left":@(Form_GetWNum(140)),@"top":@(0)}),
        
        FormRowModel()
        .wFormCellName(@(FormCellText))
        .wFormName(@"\t\t 1小时前")
    ];
}
- (NSArray*)getComnentArr{
    NSMutableArray *marr = [NSMutableArray new];
    int x = arc4random() % 4;
    for (int j = 0; j<x; j++) {
        WMZFormRowModel *model =
        FormRowModel()
        .wFormCellName(@"TencenFriendCommentCell")
        .wFormDetail([self getRandomName])
        .wFormWarn([self getRandomName])
        .wFormName([self getRandomComment]);
        [marr addObject:model];
    }
    return [NSArray arrayWithArray:marr];
}
@end
