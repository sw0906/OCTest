//
//  NestedInteger.m
//  OCTest
//
//  Created by shou wei on 26/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "NestedInteger.h"

@interface NestedInteger()


@end

@implementation NestedInteger

- (BOOL) isInteger
{
    return [_list count] == 0 ;
}
- (NSInteger) getInteger
{
    return _number;
}

- (NSArray<NestedInteger *> *) getList
{
    return _list;
}
@end







@interface NestedIterator()
@property(nonatomic, strong)NSMutableArray<NestedInteger *> *list;
@property(nonatomic) NSInteger indexFlag;
@end


@implementation NestedIterator

+ (id)nestedIterator:(NSArray<NestedInteger *> *)list
{
    return [[self alloc] initWithArray:list];
}

- (id)initWithArray:(NSArray<NestedInteger *> *)list
{
    self = [super init];
    if(self)
    {
        _indexFlag = 0;
        _list = [[NSMutableArray<NestedInteger*> alloc] init];
        [self flatenNestedArray:list];
    }
    return self;
}

- (void)flatenNestedArray:(NSArray<NestedInteger *> *)list
{
    for(NestedInteger *n in list)
    {
        if([n isInteger])
        {
            [_list addObject:n];
        }
        else
        {
            [self flatenNestedArray:[n getList]];
        }
    }
}



- (NSInteger) next
{
    if([self hasNext])
    {
        NSInteger v = [_list[_indexFlag] getInteger];
        _indexFlag++;
        return v;
    }
    
    return 0;
}


- (BOOL) hasNext
{
    return _indexFlag < [_list count];
}


-(NSArray<NestedInteger *> *)allObjects
{
    return _list;
}
@end


