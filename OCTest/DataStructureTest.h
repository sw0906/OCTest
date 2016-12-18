//
//  DataStructureTest.h
//  OCTest
//
//  Created by shou wei on 18/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"


#pragma mark -  LRU Cache
//Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and set.
//
//get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
//set(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

@interface LRUCache : NSObject
@property (nonatomic, strong) DuLinkNodeWithIndex *head;//delete
@property (nonatomic, strong) DuLinkNodeWithIndex *tail;//add
@property (nonatomic, strong) NSMutableDictionary *map;

@property NSInteger maxCount;

-(NSNumber *)getCache:(NSNumber *)key;
-(void)setCache:(NSNumber *)value withKey:(NSNumber *)key;

@end

@interface DataStructureTest : NSObject
-(void)testData;
@end
