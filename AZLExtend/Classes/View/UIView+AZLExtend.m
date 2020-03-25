//
//  UIView+ALInController.m
//  tasker
//
//  Created by yangming on 2019/6/10.
//  Copyright © 2019 BT. All rights reserved.
//

#import "UIView+AZLExtend.h"

@implementation UIView (AZLExtend)

- (nullable UIViewController *)azl_inViewController{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (nullable UIView *)azl_getResponseView{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *responseView = [subView azl_getResponseView];
        if (responseView != nil) {
            return responseView;
        }
    }
    return nil;
}

@end
