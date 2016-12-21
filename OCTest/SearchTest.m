//
//  SearchTest.m
//  OCTest
//
//  Created by admin on 19/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "SearchTest.h"

@implementation SearchTest
-(void)testSearch
{
    [self testSubsets2];
}


#pragma mark -  Subsets II
-(void)testSubsets2
{
    NSArray *array = @[@(1), @(2), @(2)];
    NSMutableArray *re =[self subsetsWithDup:array];
}


//Given a list of numbers that may has duplicate numbers, return all possible subsets
//
//Notice
//
//Each element in a subset must be in non-descending order.
//The ordering between two subsets is free.
//The solution set must not contain duplicate subsets.
//Have you met this question in a real interview? Yes
//Example
//If S = [1,2,2], a solution is:
//
//[
// [2],
// [1],
// [1,2,2],
// [2,2],
// [1,2],
// []
// ]

// vector<vector<int> > subsetsWithDup( vector<int> &num) {
-(NSMutableArray *)subsetsWithDup:(NSArray *)nums
{
    NSArray *sortNums = [nums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (NSNumber *)obj1 > (NSNumber *)obj2 ? NSOrderedDescending : NSOrderedAscending;
    }];
    NSMutableArray *result = [NSMutableArray new];
    NSMutableIndexSet *indexSet = [NSMutableIndexSet new];
    [self subsetsHelper:indexSet result:result subset:[NSMutableArray new] startPoint:0 nums:sortNums];
    return result;
}

-(void)subsetsHelper:(NSMutableIndexSet *)indexSet result:(NSMutableArray *)result subset:(NSMutableArray *)subset startPoint:(NSInteger)start nums:(NSArray *)nums
{
    NSMutableArray *subsetCopy = [subset mutableCopy];
    NSMutableIndexSet *indexSetCopy = [indexSet mutableCopy];
    
    [result addObject:subsetCopy];
    
    if (subsetCopy.count == nums.count) {
        return;
    }
    
    for (NSInteger i=start; i<nums.count; i++) {
        if (i>0 && (![indexSetCopy containsIndex:i-1]) && nums[i-1] == nums[i]) {
            continue;
        }
        
        [indexSetCopy addIndex:i];
        [subsetCopy addObject:nums[i]];
        [self subsetsHelper:indexSetCopy result:result subset:subsetCopy startPoint:i+1 nums:nums];//!!! copy important
        [indexSetCopy removeIndex:i];
        [subsetCopy removeObjectAtIndex:subsetCopy.count-1]; //!!! can't remove object
    }
}

@end
