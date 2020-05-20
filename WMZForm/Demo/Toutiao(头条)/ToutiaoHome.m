

//
//  ToutiaoHome.m
//  WMZForm
//
//  Created by wmz on 2020/5/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "ToutiaoHome.h"

@implementation ToutiaoHome

- (void)viewDidLoad{
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
               .wFormSectionData([strongObject getFormArr])
               .wFormFootHeight(10)
               .wFormFootBackGround(FormColor(0xeeeeee));
           });
       }
}

- (NSArray*)getFormArr{
    NSMutableArray *marr = [NSMutableArray new];
    WMZFormRowModel *model = nil;
    int x = arc4random() % 2;
    if (x == 0) {
        model = FormRowModel()
        .wFormCellName(@(FormCellIcon))
        .wFormIcon([self getRandomImage][0])
        .wFormName([self getRandomName])
        .wFormDetail([self getRandomName])
        .wFormCustomNameLabel(^(UILabel * _Nullable name) {
            name.textColor = FormColor(0x333333);
            name.font = [UIFont systemFontOfSize:14.0f weight:100];
        })
        .wFormCustomDetailLabel(^(UILabel * _Nullable detail) {
            detail.textColor = FormColor(0x999999);
            detail.font = [UIFont systemFontOfSize:13.0f];
        });
        [marr addObject:model];
    }
    model = FormRowModel()
    .wFormRowData(@{@"minLines":@(3),
                    @"top":(x != 0)?@(FormYOffset):@(5),
                    @"showAllText":@(YES)})
    .wFormCellName(@(FormCellText))
    .wFormName([self getRandomDetail]);
    [marr addObject:model];
    
    int y = arc4random() % 2;
    if (y == 0) {
        model = FormRowModel()
        .wFormCellName(@(FormCellImage))
        .wFormValue([self getRandomImage])
        .wFormRowData(@{@"maxCount":@(3),@"top":@(0)});
        [marr addObject:model];
    }else{
        model = FormRowModel()
        .wFormCellName(@"TouTiaoCommentCell");
        [marr addObject:model];
    }
    return [NSArray arrayWithArray:marr];
}

@end
