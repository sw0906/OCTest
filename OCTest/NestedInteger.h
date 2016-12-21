//
//  NestedInteger.h
//  OCTest
//
//  Created by shou wei on 26/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NestedIterator;

@interface NestedInteger : NSObject
@property(nonatomic) NSInteger number;
@property (nonatomic, strong) NSArray<NestedInteger *> *list;

- (BOOL) isInteger;
- (NSInteger) getInteger;
- (NSArray<NestedInteger *> *) getList;
//- (NestedIterator*) objectIterator;
@end


@interface NestedIterator : NSObject
+ (id)nestedIterator:(NSArray<NestedInteger *> *)list;


- (NSInteger) next;
- (BOOL) hasNext;
-(NSArray<NestedInteger *> *)allObjects;
@end




//class NestedIterator {
//public:
//    NestedIterator(vector<NestedInteger> &nestedList) {
//        // Initialize your data structure here.
//    }
//    
//    // @return {int} the next element in the iteration
//    int next() {
//        // Write your code here
//    }
//    
//    // @return {boolean} true if the iteration has more element or false
//    bool hasNext() {
//        // Write your code here
//    }
//};