//
//  BaseVC.h
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//


#import "WMZForm.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController<WMZFormDelegate>
- (NSString*)getRandomName;
- (NSString*)getRandomDetail;
- (NSString*)getRandomComment;
- (NSArray*)getRandomImage;
@end

NS_ASSUME_NONNULL_END
