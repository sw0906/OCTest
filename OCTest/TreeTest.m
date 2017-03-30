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

-(void)testTree
{
//    [self testCopy];
//    [self testBSTtoLinkNode];
//    [self testListToTree];
    [self testValid];
    [self testBTSum];
    [self testing];
}





- (void)testing
{
    NSArray *strArray = @[@"lint", @"intl", @"tl", @"code", @"itnl", @"deco", @"decc"];
    
    //nums
    NSArray *nums = @[@2, @1, @0, @2, @0, @0, @3, @4];
    
    
    //tree
    TreeNode *root = [self getSampleTree];
    
    
    //number pad
    NSString *str4 = @"926";
    
    
    
    
}
















#pragma mark - Convert Binary Search Tree to Doubly Linked List

-(void)testBSTtoLinkNode
{
    TreeNode *root = [self getSampleTree];
    [self bstToDoublyList:root];
}

//Convert a binary search tree to doubly linked list with in-order traversal.
//
//Example
//Given a binary search tree:
//
//4
/// \
//2   5
/// \
//1   3
//return 1<->2<->3<->4<->5
//DoublyListNode* bstToDoublyList(TreeNode* root) {
- (DuLinkNode *)bstToDoublyList:(TreeNode *)root
{
    NSMutableArray *result = [NSMutableArray new];
    [self inorderTreeToListHelper:root withResult:result];
    DuLinkNode *node = [self listToLink:result];
    return node;
}

-(DuLinkNode *)listToLink:(NSArray *)array
{
    DuLinkNode *preNode = [DuLinkNode new];
    DuLinkNode *dummyNode = preNode;
    
    for (int i=0; i<array.count; i++) {
        DuLinkNode *curNode = [DuLinkNode linkNodeWithVal:[array[i] integerValue]];
        curNode.prev = preNode;
        preNode.next = curNode;
        preNode = curNode;
    }
    return dummyNode.next;
}





#pragma mark - Binary Tree Path Sum

- (void)testBTSum
{
    TreeNode *root = [self getSampleTree];
    NSArray *arr =[self binaryTreePathSum:root withTarget:12];
}

//Given a binary tree, find all paths that sum of the nodes in the path equals to a given number target.
//
//A valid path is from root node to any of the leaf nodes.
//
//Have you met this question in a real interview? Yes
//Example
//Given a binary tree, and target = 5:
//
//1
/// \
//2   4
/// \
//2   3

//return
//
//[
// [1, 2, 2],
// [1, 4]
// ]


//    vector<vector<int>> binaryTreePathSum(TreeNode *root, int target) {

//solution 2
-(NSArray *)binaryTreePathSum:(TreeNode *)root withTarget:(NSInteger) target
{
    NSMutableArray *result = [NSMutableArray new];
    NSMutableArray *sub = [NSMutableArray new];
//    [self binaryTreePathSumHelper1:root withTarget:target withSub:sub withResult:result];
    [self binaryTreePathSumHelper:root withTarget:target curVal:0 withSub:sub withResult:result];
    return [NSArray arrayWithArray:result];
}



-(void)binaryTreePathSumHelper:(TreeNode *)root withTarget:(NSInteger) target  curVal:(NSInteger)curV withSub:(NSMutableArray *)sub withResult:(NSMutableArray *)result
{
    if (!root) {
        return;
    }
    
    NSInteger val = root.val;
    [sub addObject:@(root.val)];
    curV += val;
    if (curV == target) {
        [result addObject:[sub copy]];
    }
    else if(curV < target)
    {
        [self binaryTreePathSumHelper:root.left withTarget:target curVal:curV withSub:[sub mutableCopy] withResult:result];
        
        [self binaryTreePathSumHelper:root.right withTarget:target curVal:curV withSub:[sub mutableCopy] withResult:result];
    }
}



//solution more
-(NSArray *)binaryTreePathSum1:(TreeNode *)root withTarget:(NSInteger) target
{
    NSMutableArray *result = [NSMutableArray new];
    NSMutableArray *sub = [NSMutableArray new];
    [self binaryTreePathSumHelper1:root withTarget:target withSub:sub withResult:result];
    return [NSArray arrayWithArray:result];
}


-(void)binaryTreePathSumHelper1:(TreeNode *)root withTarget:(NSInteger) target withSub:(NSMutableArray *)sub withResult:(NSMutableArray *)result
{
    if (!root)
        return;
    
    [sub addObject:@(root.val)];
    NSInteger curValue = [self getTotal:sub];
    
    if (curValue == target)
    {
        [result addObject:sub];
    }
    else if(curValue < target)
    {
        [self binaryTreePathSumHelper1:root.left withTarget:target withSub:[sub mutableCopy] withResult:result]; //!!! 必须新建一个数组，要不然出错
        [self binaryTreePathSumHelper1:root.right withTarget:target withSub:[sub mutableCopy] withResult:result];
    }
}

-(NSInteger)getTotal:(NSArray *)sub
{
    NSInteger re = 0;
    for (NSNumber *n in sub) {
        re += [n integerValue];
    }
    return re;
}






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
    left.left = leftl;
    left.right = leftr;
    leftl.left = leftll;
    
    TreeNode *root2 = [self getSampleTree];
    
    ResultType *re = [self isValidSearchTree:root];
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
    if (  left.maxV > val || right.minV < val ) //！！！node.left一起判断
    {
        return [[ResultType alloc] initNotValid];
    }
    
    return [[ResultType alloc] initWithMax:right.maxV withMin:left.minV withRoot:node];
}


//
-(ResultType *)isValidSearchTree1:(TreeNode *)node
{
    if (node == nil) {
        return [[ResultType alloc] init];
    }
    
    ResultType *left = [self isValidSearchTree1: node.left];
    ResultType *right = [self isValidSearchTree1: node.right];
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
    TreeNode *copyN = [root copy];//[root copyWithZone:NULL];
    
    if (copyN == root) {
        return;
    }
 
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
    
    TreeNode *left = [self findSameNode:r1.left withR2:r2.left withNode:n1];
    TreeNode *right = [self findSameNode:r1.right withR2:r2.right withNode:n1];
    
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
    NSRange leftR = NSMakeRange(0, mid);// -- [)
    TreeNode *left = [self listToInorderTree:[list subarrayWithRange:leftR]];
    
    //right
    NSRange rightR = NSMakeRange(mid+1, length-1-mid);
    TreeNode *right = [self listToInorderTree:[list subarrayWithRange:rightR]];
    
    TreeNode *root = [[TreeNode alloc] init:[list[mid] integerValue]];
    root.left = left;
    root.right = right;
    return root;
}


-(TreeNode *)listToInorderTree1:(NSArray *)list
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


//
//#pragma mark -  Binary Tree Path Sum
///*
//Given a binary tree, find all paths that sum of the nodes in the path equals to a given number target.
//
//A valid path is from root node to any of the leaf nodes.
//
//Have you met this question in a real interview? Yes
//Example
//Given a binary tree, and target = 5:
//
//1
/// \
//2   4
/// \
//2   3
//return
//
//[
// [1, 2, 2],
// [1, 4]
// ]
//*/
////vector<vector<int>> binaryTreePathSum(TreeNode *root, int target) {
//
//- (NSMutableArray *)binaryTreePathSum:(TreeNode *)root target:t
//{
//    return [NSMutableArray new];
//}
//
//- (void)binaryTreePathSumHelper:(NSMutableArray *)re subArray:(NSMutableArray *)sub target:(NSInteger)t treeNode:(TreeNode *)node
//{
//    if (!node)
//        return;
//    NSMutableArray *newSub = [sub mutableCopy];
//    [newSub addObject:@(node.val)];
//    NSInteger curV = [self getTotal:<#(NSArray *)#>]
//}
//
//- (NSInteger)getTotalCount:(NSArray *)sub
//{
//    NSInteger count = 0;
//    for (NSNumber *n in sub) {
//        count += [n integerValue];
//    }
//    return count;
//}


#pragma mark - helper
-(TreeNode *)getSampleTree
{
    TreeNode *root = [[TreeNode alloc] init:5];
    TreeNode *left = [[TreeNode alloc] init:3];
    TreeNode *right = [[TreeNode alloc] init:7];
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
