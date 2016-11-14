//
//  TreeTest.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TreeTest.h"

@implementation TreeTest

//balanced tree
- (void)testBTree
{
    TreeNode *root = [[TreeNode alloc] init:5];
    TreeNode *left = [[TreeNode alloc] init:3];
    TreeNode *right = [[TreeNode alloc] init:6];
    TreeNode *leftl = [[TreeNode alloc] init:2];
    TreeNode *leftr = [[TreeNode alloc] init:4];
    TreeNode *leftll = [[TreeNode alloc] init:1];
    root.left = left;
    root.right = right;
    left.left = leftl;
    left.right = leftr;
    leftl.left = leftll;
    [self isBalancedTree:root];
}

- (bool) isBalancedTree:(TreeNode *)root
{
    if(!root)
        return false;
    
    NSInteger re = [self heightOfTree:root];//MAX(lHeight, rHeight)+1;
    NSLog(@"%ld", re);
    return re != -1;
}


- (NSInteger) heightOfTree:(TreeNode *)node
{
    if(!node)
        return 0;
    
    NSInteger lHeight = [self heightOfTree:node.left];
    NSInteger rHeight = [self heightOfTree:node.right];
    
    if(lHeight == -1 || rHeight == -1)
        return -1;
    
    if(labs(lHeight - rHeight) > 1)
        return -1;
    
    
    return MAX(lHeight, rHeight)+1;
}




@end
