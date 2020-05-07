//
//  UINavigationController+AZLExtend.m
//  ALExampleTest
//
//  Created by lizihong on 2018/7/18.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UINavigationController+AZLPop.h"

@implementation UINavigationController (AZLPop)

- (void)azl_forcePopToViewController:(UIViewController *)controller animated:(BOOL)animated{
    NSMutableArray *controllers = self.viewControllers.mutableCopy;
    if (![controllers containsObject:controller]) {
        [controllers insertObject:controller atIndex:controllers.count-1];
        self.viewControllers = controllers;
    }
    [self popToViewController:controller animated:animated];
}

- (void)azl_forcePopToViewControllerWithName:(NSString *)controllerName animated:(BOOL)animated{
    NSMutableArray *controllers = self.viewControllers.mutableCopy;
    for (UIViewController *controller in controllers) {
        if ([NSStringFromClass([controller class]) isEqualToString:controllerName]) {
            //找到controller，直接pop
            [self popToViewController:controller animated:animated];
            return;
        }
    }
    
    //沒有該controller，新建一個加進去
    id controller = [[NSClassFromString(controllerName) alloc] init];
    [controllers insertObject:controller atIndex:controllers.count-1];
    self.viewControllers = controllers;
    
    [self popToViewController:controller animated:animated];
}

- (NSArray<UIViewController*>*)azl_canPopToControllerClass:(Class)vcClass{
    NSMutableArray *controllerArray = [[NSMutableArray alloc] init];
    for (UIViewController *controller in self.viewControllers) {
        if ([controller isKindOfClass:vcClass]) {
            [controllerArray addObject:controller];
        }
    }
    return controllerArray.copy;
}

@end
