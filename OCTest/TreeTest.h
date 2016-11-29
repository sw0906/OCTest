//
//  TreeTest.h
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface ResultType: NSObject
@property(nonatomic) NSInteger minV;
@property(nonatomic) NSInteger maxV;
@property(nonatomic) BOOL isValid;
@end



@interface TreeTest : NSObject
-(void)testValid;
- (void)testBTree;
- (void)testLCA;
- (void)testCopy;
-(void)testTreeToList;
-(void)testListToTree;

- (void)testTraverBlock;
@end
