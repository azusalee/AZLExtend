//
//  UIView+ALInController.h
//  tasker
//
//  Created by yangming on 2019/6/10.
//  Copyright © 2019 BT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AZLExtend)

/// 获取视图所在的controller
- (nullable UIViewController *)azl_inViewController;

/// 获取当前响应的view
- (nullable UIView *)azl_getResponseView;

@end

NS_ASSUME_NONNULL_END
