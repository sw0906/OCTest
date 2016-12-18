//
//  TreeNode.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TreeNode.h"

@implementation DuLinkNodeWithIndex

+ (id) linkNodeWithNum:(NSNumber *)num withKey:(NSNumber *)key;
{
    return [[self alloc] initNum:num withKey:key];
}


- (id) initNum:(NSNumber *) val withKey:(NSNumber *)key
{
    if( self = [super init])
    {
        self.index = key;
        self.val = val;
        self.next = nil;
        self.prev = nil;
    }
    return self;
}

@end



@implementation DuLinkNode
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
        self.prev = nil;
    }
    return self;
}

@end

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


//copying
- (id)copyWithZone:(NSZone *)zone {
    TreeNode *copy = [[[self class] allocWithZone:zone] init];
    if (!copy) {
        return nil;
    }
    copy.left = self.left;
    copy.right = self.right;
    copy.val = self.val;
    return copy;
}





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
