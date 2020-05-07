//
//  UIView+ALInController.h
//  tasker
//
//  Created by lizihong on 2019/6/10.
//  Copyright © 2019 lizihong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AZLExtend)

@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat height;
@property CGFloat width;

/// 获取视图所在的controller
- (nullable UIViewController *)azl_inViewController;

/// 获取当前响应的view
- (nullable UIView *)azl_getResponseView;

@end

NS_ASSUME_NONNULL_END
