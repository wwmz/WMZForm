//
//  TencenTabbar.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "TencenTabbar.h"
#import "TencenSetingVC.h"
#import "TencenFriendGroupVC.h"
@implementation TencenTabbar
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    self.view.backgroundColor = [UIColor whiteColor];
    TencenFriendGroupVC *na1 = [TencenFriendGroupVC new];
    na1.tabBarItem.title = @"朋友圈";
    na1.tabBarItem.image = [UIImage formBundleImage:@"form_nv"];
    TencenSetingVC *na2 = [TencenSetingVC new];
    na2.tabBarItem.title = @"设置";
    na2.tabBarItem.image = [UIImage formBundleImage:@"form_nan"];
    self.viewControllers = @[na1,na2];
}
@end
