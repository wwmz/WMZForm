//
//  TouTiaoTabbar.m
//  WMZForm
//
//  Created by wmz on 2020/5/16.
//  Copyright © 2020 wmz. All rights reserved.
//
#import "ToutTiaoSetting.h"
#import "TouTiaoTabbar.h"
#import "ToutiaoHome.h"

@implementation TouTiaoTabbar
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头条";
    self.view.backgroundColor = [UIColor whiteColor];
    ToutiaoHome *na1 = [ToutiaoHome new];
    na1.tabBarItem.title = @"首页";
    na1.tabBarItem.image = [UIImage formBundleImage:@"form_nv"];
    ToutTiaoSetting *na2 = [ToutTiaoSetting new];
    na2.tabBarItem.title = @"我的";
    na2.tabBarItem.image = [UIImage formBundleImage:@"form_nan"];
    self.viewControllers = @[na1,na2];
}
@end
