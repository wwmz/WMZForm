//
//  PhotoBrowser.h
//  WMZForm
//
//  Created by wmz on 2019/9/5.
//  Copyright © 2019 wmz. All rights reserved.
//
#import <UIKit/UIKit.h>

@class PhotoBrowser;

@protocol PhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(PhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(PhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface PhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign) BOOL insert;
@property (nonatomic, weak) id<PhotoBrowserDelegate> delegate;

- (void)show;

@end
