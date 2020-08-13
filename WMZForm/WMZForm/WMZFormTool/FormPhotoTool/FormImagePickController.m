




//
//  FormImagePickController.m
//  PostDelivery
//
//  Created by wmz on 2020/7/7.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "FormImagePickController.h"

@interface FormImagePickController ()

@end

@implementation FormImagePickController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    // Do any additional setup after loading the view.
}


@end
