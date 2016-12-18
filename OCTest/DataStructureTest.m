//
//  DataStructureTest.m
//  OCTest
//
//  Created by shou wei on 18/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DataStructureTest.h"

@implementation LRUCache

-(id)init{
    if (self = [super init]) {
        self.head = [DuLinkNodeWithIndex new];
        self.tail = [DuLinkNodeWithIndex new];
        self.head.next = self.tail;
        self.tail.prev = self.head;
        self.map = [NSMutableDictionary new];
        self.maxCount = 4;
    }
    return self;
}

-(void)addToTail:(DuLinkNodeWithIndex *)node
{
    DuLinkNodeWithIndex *tailPre = self.tail.prev;
    tailPre.next = node;
    node.prev = tailPre;
    node.next = self.tail;
    self.tail.prev = node;
}


-(void)moveNodeToTail:(DuLinkNodeWithIndex *)node
{
    DuLinkNodeWithIndex *pre = node.prev;
    DuLinkNodeWithIndex *next = node.next;
    pre.next = next;
    next.prev = pre;
    
    [self addToTail:node];
}

-(DuLinkNodeWithIndex *)removeFromHead
{
    DuLinkNodeWithIndex *node = self.head.next;
    self.head.next = self.head.next.next;
    self.head.next.prev = self.head;
    return node;
}

-(NSNumber *)getCache:(NSNumber *)key
{
    DuLinkNodeWithIndex *tempNode = self.map[key];
    if (!tempNode) {
        return @(-1);
    }
    [self moveNodeToTail:tempNode];
    return tempNode.val;
}


-(void)setCache:(NSNumber *)value withKey:(NSNumber *)key
{
    NSNumber *re = [self getCache:key];
    if ([re isEqual: @(-1)]) {
        DuLinkNodeWithIndex *newNode = [DuLinkNodeWithIndex linkNodeWithNum:value withKey:key];
        self.map[key] = newNode;
        [self addToTail:newNode];
        
        NSInteger currentCount = self.map.count; //!!
        if (currentCount > self.maxCount) {
            DuLinkNodeWithIndex *node = [self removeFromHead];
            [self.map removeObjectForKey:node.index];
            currentCount--;
        }
    }
    else
    {
        DuLinkNodeWithIndex *tempNode = self.map[key];
        tempNode.val = value;
    }
}


@end


@implementation DataStructureTest
-(void)testData
{
    [self testLRU];
}


#pragma mark - LRU
- (void)testLRU
{
    //set 2 3 4 5 6  -  3 4 5 6
    //get 3 -  4 5 6 3
    //get 3 - 4 5 6 3
    //get 6 - 4 5 3 6
    //set 5(7) - 4 3 6 7
    LRUCache *lru = [LRUCache new];
    [lru getCache:@(2)];
    
    [lru setCache:@(2) withKey:@(2)];
    [lru setCache:@(3) withKey:@(3)];
    [lru setCache:@(4) withKey:@(4)];
    [lru setCache:@(5) withKey:@(5)];
    [lru setCache:@(6) withKey:@(6)];
    
    NSLog(@"%ld", [lru.head.next.val integerValue]);
    [lru getCache:@(3)];
    
    NSLog(@"%ld", [lru.head.next.val integerValue]);
    
    [lru getCache:@(3)];
    NSLog(@"%ld", [lru.head.next.val integerValue]);
    
    [lru getCache:@(6)];
    NSLog(@"%ld", [lru.head.next.val integerValue]);
    
    [lru setCache:@(7) withKey:@(5)];
    NSLog(@"%ld", [lru.head.next.val integerValue]);
}

@end
