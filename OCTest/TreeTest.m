//
//  TreeTest.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TreeTest.h"
@implementation ResultType

-(id)initWithMax:(NSInteger)maxV withMin:(NSInteger)minV withRoot:(TreeNode *)node
{
    if (self = [super init]) {
        self.isValid = YES;
        self.maxV = MAX(node.val, maxV);
        self.minV = MIN(node.val, minV);
    }
    return self;
}


-(id)initNotValid
{
    if (self = [super init]) {
        self.isValid = false;
        self.minV = INT_MAX;
        self.maxV = INT_MIN;
    }
    return self;
}


-(id)init
{
    if (self = [super init]) {
        self.isValid = true;
        self.minV = INT_MAX;
        self.maxV = INT_MIN;
    }
    return self;
}
@end










@implementation TreeTest

#pragma mark - is binary search tree

-(void)testValid
{
    TreeNode *root = [[TreeNode alloc] init:5];
    TreeNode *left = [[TreeNode alloc] init:3];
    TreeNode *right = [[TreeNode alloc] init:6];
    TreeNode *leftl = [[TreeNode alloc] init:2];
    TreeNode *leftr = [[TreeNode alloc] init:4];
    TreeNode *leftll = [[TreeNode alloc] init:1];
    root.left = left;
    root.right = right;
    left.left = leftll;
    left.right = leftr;
    leftll.left = leftl;
    
    TreeNode *root2 = [self getSampleTree];
    
    ResultType *re = [self isValidSearchTree:root2];
    NSString *str = re.isValid ? @"yes" : @"no";
    NSLog(@"%@", str);
}
-(ResultType *)isValidSearchTree:(TreeNode *)node
{
    if (node == nil) {
        return [[ResultType alloc] init];
    }
    
    ResultType *left = [self isValidSearchTree: node.left];
    ResultType *right = [self isValidSearchTree: node.right];
    if (!left.isValid || !right.isValid) {
        return [[ResultType alloc] initNotValid];
    }
    
    NSInteger val = node.val;
    if ( (node.left != nil && left.maxV > val) || (node.right != nil && right.minV < val ) ) //！！！node.left一起判断
    {
        return [[ResultType alloc] initNotValid];
    }
    
    return [[ResultType alloc] initWithMax:right.maxV withMin:left.minV withRoot:node];
}

#pragma mark - balanced tree
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


#pragma mark - lowestCommonAncestor
- (void)testLCA
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
    
    TreeNode *re = [self lcaWithRoot:root withA:leftll withB:right];
    NSLog(@"%ld", re.val);
}
- (TreeNode *)lcaWithRoot:(TreeNode *)root withA:(TreeNode *)a withB:(TreeNode *)b
{
    if (root == nil || root == a || root == b) {
        return root;
    }
    
    TreeNode *left = [self lcaWithRoot:root.left withA:a withB:b];
    TreeNode *right = [self lcaWithRoot:root.right withA:a withB:b];
    
    if (left != nil || right != nil ) {
        return root;
    }
    else if(left != nil )
    {
        return left;
    }
    else if(right != nil )
    {
        return right;
    }
    
    return nil;
}

#pragma mark - test copy
- (void)testCopy
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
    TreeNode *copyN = [root copyWithZone:NULL];
    
 
    TreeNode *node = [self findSameNode:root withR2:copyN withNode:leftr];
    NSLog(@"%ld", node.val);
}

-(TreeNode *)findSameNode:(TreeNode *)r1 withR2:(TreeNode *)r2 withNode:(TreeNode *)n1
{
    if (r1 == nil) {
        return nil;
    }
    
    if (r1 == n1 && r2.val == r1.val) {
        return r2;
    }
    
    TreeNode *left, *right;
    left = [self findSameNode:r1.left withR2:r2.left withNode:n1];
    
    right = [self findSameNode:r1.right withR2:r2.right withNode:n1];
    
    return left != nil ? left : right;
}



#pragma mark - traverse tree
typedef NSInteger (^traverseBlock)(NSInteger val);
NSInteger (^traverseBlock2)(NSInteger) = ^(NSInteger input) {
    NSLog(@"%ld\n", input);
    return input;
};

- (void)testTraverBlock
{
    TreeNode *node = [self getSampleTree];
    [self inOrderTraverseTree:node withBlock:^NSInteger(NSInteger val) {
        NSLog(@"%ld\n", val);
        return val;
    }];
    [self inOrderTraverseTree2:node];
}



- (void)inOrderTraverseTree2:(TreeNode *)root
{
    if (root == nil)
        return;
    
    [self inOrderTraverseTree2:root.left];
    traverseBlock2(root.val);
    [self inOrderTraverseTree2:root.right];
}


- (void)inOrderTraverseTree:(TreeNode *)root withBlock:(traverseBlock)block
{
    if (root == nil)
        return;
    
    [self inOrderTraverseTree:root.left withBlock:block];
    block(root.val);
    [self inOrderTraverseTree:root.right withBlock:block];
}


#pragma mark - treeToList

- (void)testTreeToList
{
    TreeNode *node = [self getSampleTree];
    NSArray *result = [self inOrderTreeToList:node];
    NSLog(@"%ld", [result count]);
}

- (NSArray *)inOrderTreeToList:(TreeNode *)root
{
    NSMutableArray *result = [NSMutableArray new];
    [self inorderTreeToListHelper:root withResult:result];
    return result;
}

-(void)inorderTreeToListHelper:(TreeNode *)root withResult:(NSMutableArray *)result
{
    if (root == nil)
        return;

    [self inorderTreeToListHelper:root.left withResult:result];
    [result addObject:@(root.val)];
    [self inorderTreeToListHelper:root.right withResult:result];
}


#pragma mark - list to Tree
-(void)testListToTree
{
    TreeNode *node = [self getSampleTree];
    NSArray *result = [self inOrderTreeToList:node];
    
    TreeNode *root = [self listToInorderTree:result];
    NSLog(@"%ld", root.val);
}

-(TreeNode *)listToInorderTree:(NSArray *)list
{
    NSInteger length = [list count];
    if (!length) {
        return nil;
    }
    
    NSInteger mid = length/2;
    
    //left
    TreeNode *left = nil;
    if (mid > 0)
    {
        NSRange leftR = NSMakeRange(0, mid);
        left = [self listToInorderTree:[list subarrayWithRange:leftR]];
    }
    
    //right
    TreeNode *right = nil;
    if ( mid+1 < length) {
        NSRange rightR = NSMakeRange(mid+1, length-mid-1);
        right = [self listToInorderTree:[list subarrayWithRange:rightR]];
    }
    
    TreeNode *root = [[TreeNode alloc] init:[list[mid] integerValue]];
    root.left = left;
    root.right = right;
    return root;
}





#pragma mark - helper
-(TreeNode *)getSampleTree
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
    return root;
}




@end
