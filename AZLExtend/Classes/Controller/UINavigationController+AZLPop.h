//
//  UINavigationController+AZLExtend.h
//  ALExampleTest
//
//  Created by lizihong on 2018/7/18.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AZLPop)

/// 強制跳回vc（如果目標controller是新的，那麼會加進去再pop）
- (void)azl_forcePopToViewController:(UIViewController *)controller animated:(BOOL)animated;

/// 強制跳回某類controller(如果要跳的controller需要入参的话，不建议用这个方法)
- (void)azl_forcePopToViewControllerWithName:(NSString *)controllerName animated:(BOOL)animated;

/// 判斷push棧是否含有某類controller，有把該類的所有controller返回，沒有返回空數組
- (NSArray<UIViewController*>*)azl_canPopToControllerClass:(Class)vcClass;

@end
