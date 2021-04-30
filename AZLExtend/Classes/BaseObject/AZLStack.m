//
//  AZLStack.m
//  AZLExtend_Example
//
//  Created by lizihong on 2021/4/30.
//  Copyright © 2021 azusalee. All rights reserved.
//

#import "AZLStack.h"
#import "AZLListNode.h"

@interface AZLStack()

@property (nonatomic, strong) AZLListNode *topListNode;

@end

@implementation AZLStack

- (void)pushObject:(id)obj{
    AZLListNode *listNode = [[AZLListNode alloc] init];
    listNode.value = obj;
    listNode.next = self.topListNode;
    self.topListNode = listNode;
}

- (nullable id)popObject{
    id obj = self.topListNode.value;
    self.topListNode = self.topListNode.next;
    return obj;
}

@end
