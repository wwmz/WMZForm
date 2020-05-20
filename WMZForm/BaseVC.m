






//
//  BaseVC.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()
@property(nonatomic,strong)NSArray* nameArr;
@property(nonatomic,strong)NSArray* detailArr;
@property(nonatomic,strong)NSArray* imageArr;
@property(nonatomic,strong)NSArray* commentArr;
@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (NSString*)getRandomName{
    int x = arc4random() % self.nameArr.count;
    return self.nameArr[x];
}
- (NSString*)getRandomDetail{
    int x = arc4random() % self.detailArr.count;
    return self.detailArr[x];
}
- (NSArray*)getRandomImage{
    int x = arc4random() % self.imageArr.count;
    return self.imageArr[x];
}
- (NSString *)getRandomComment{
    int x = arc4random() % self.commentArr.count;
    return self.commentArr[x];
}
- (NSArray*)nameArr{
    if (!_nameArr) {
        _nameArr = @[@"杨明",@"wmz",@"wxx",@"乔布斯",@"xjj",@"小明",@"stepen-curry-yyud"];
    }
    return _nameArr;
}

- (NSArray *)commentArr{
    if (!_commentArr) {
        _commentArr = @[@"想要体会一年有多少价值，你可以去问一个失败重。",@"想要体会一年有多少价值，你可以去问一个失败重修的学生。",@"想要体会一月有多少价值，你可以去问一个。",@"想要体会一周有多少价值，你可以去问一个定期周刊的编辑。",@"想要体会一年有多少价值，想要体会一年有多少价值，你可以去问一个失败重修的学生想要体会一年有多少价值，你可以去问一个失败重修的学生",@"想要体会一年有多少价值，想要体会一年有多少价值，你可以去问一个失败重修的学生想要体会一年有多少价值，你可以去问一个失败重修的学生想要体会一年有多少价值，想要体会一年有多少价值，你可以去问一个失败重修的学生想要体会一年有多少价值，你可以去问一个失败重修的学生"];
    }
    return _commentArr;
}

- (NSArray*)detailArr{
    if (!_detailArr) {
        _detailArr = @[@"忙的时候，想要休息；\n度假的时候，想到未来。\n穷的时候，渴望富有；\n生活安逸了，怕幸福不能长久。\n该决定的时候，担心结果不如预期；\n看明白了，后悔当初没有下定决心。\n不属于自己的，常常心存欲望；\n握在手里了，又怀念未拥有前的轻松。\n生命若不是现在，那是何时",
            @"忙的时候，想要休息；\n度假的时候，想到未来。\n穷的时候，渴望富有；",
        @"一个人可以毫无道理跟你做一辈子亲戚",
        @"朋友就是喜欢你也了解你的人\n愿你都能珍惜身边每一个朋友\n因为你我有缘份，才能成为朋友",
        @"忙的时候，想要休息；\n度假的时候，想到未来。\n穷的时候，渴望富有；\n生活安逸了，怕幸福不能长久。\n该决定的时候，担心结果不如预期；看明白了，后悔当初没有下定决心。不属于自己的，常常心存欲望；\n握在手里了，又怀念未拥有前的轻松。\n生命若不是现在，那是何时",
        @"想要体会一年有多少价值，你可以去问一个失败重修的学生。\n想要体会一月有多少价值，你可以去问一个不幸早产的母亲。\n想要体会一周有多少价值，你可以去问一个定期周刊的编辑。\n想要体会一小时有多少价值，你可以去问一对等待相聚的恋人。\n想要体会一分钟有多少价值，你可以去问一个错过火车的旅人。\n想要体会一秒钟有多少价值，你可以去问一个死里逃生的幸运儿"];
    }
    return _detailArr;
}

- (NSArray *)imageArr{
    return @[
  @[@"formIcon",
  @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
  @"formIcon",],
  @[@"formIcon",
  @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
  @"formIcon",],
  @[@"formIcon",
  @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
  @"formIcon",
  @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
],
    @[@"formIcon",
    @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
    @"formIcon",
    @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
  ],
  @[@"formIcon",
    @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
    @"formIcon",
  ],
  @[@"formIcon"],
  @[@"formIcon",
    @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
  ],
    ];
}

- (void)dealloc{
    
}
@end
