//
//  TreeNode.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TreeNode.h"

@implementation LinkNode

+ (id) linkNodeWithVal:(NSInteger)num
{
    return [[self alloc] init:num];
}


- (id) init:(NSInteger) val
{
    if( self = [super init])
    {
        self.val = val;
        self.next = nil;
    }
    return self;
}


@end

@implementation TreeNode

+ (id)treeNodeWithVal:(NSInteger)num
{
    return [[self alloc] init:num];
}

-(id)init :(NSInteger) val {
    if ( self = [super init] ) {
        self.val = val;
        self.left = nil;
        self.right = nil;
    }
    return self;
}


@end
