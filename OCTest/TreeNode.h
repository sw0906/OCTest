//
//  TreeNode.h
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LinkNode : NSObject
@property (nonatomic) NSInteger val;
@property (nonatomic, strong) LinkNode *next;
+ (id) linkNodeWithVal:(NSInteger)num;
- (id) init:(NSInteger) val;
@end


@interface TreeNode : NSObject<NSCopying>
@property (nonatomic) NSInteger val;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;
+ (id)treeNodeWithVal:(NSInteger)num;
- (id) init:(NSInteger) val;
@end

