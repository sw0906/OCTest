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
//    [self testSubsets2];
//    [self testWordLadder];
    [self testPermutation];
}




#pragma mark - Permutations II
- (void)testPermutation
{
    NSArray *array = @[@(2),@(1), @(2)];
    NSMutableArray *re = [self permuteUnique:array];
    
}
//Given a list of numbers with duplicate number in it. Find all unique permutations.
//
//Example
//For numbers [1,2,2] the unique permutations are:
//
//[
// [1,2,2],
// [2,1,2],
// [2,2,1]
// ]


//vector<vector<int> > permuteUnique(vector<int> &nums) {
-(NSMutableArray *)permuteUnique:(NSArray *)nums
{
    if(!nums)
        return nil;
    
    if(nums.count <= 1)
        return [nums mutableCopy];
    
    NSMutableArray *resulut = [[NSMutableArray alloc] init];
    NSMutableArray *subArray = [[NSMutableArray alloc] init];
    NSMutableArray *subIndex = [[NSMutableArray alloc] init];
    
    NSArray *sortNums = [nums sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull object1, id  _Nonnull object2) {
                             if((NSNumber *)object1 > (NSNumber *)object2)
                             {
                                 return NSOrderedDescending;
                             }
                             return NSOrderedAscending;
                         }];
    
    
    [self permuteUniqueWithNums:[sortNums mutableCopy] subArray:subArray subIndex:subIndex result:resulut];
    return resulut;
}

-(void)permuteUniqueWithNums:(NSMutableArray *)nums subArray:(NSMutableArray *)subArray
                    subIndex:(NSMutableArray *)subIndex result:(NSMutableArray *)result
{
    if(subArray.count == nums.count)
    {
        [result addObject:subArray];
        return;
    }
    
    for(NSInteger i=0; i<nums.count; i++)
    {
        if([subIndex containsObject:[NSNumber numberWithInteger:i]])
            continue;
        
        if(i>0 && nums[i-1] == nums[i] && [subIndex containsObject:[NSNumber numberWithInteger:i-1]])
            continue;
        
        [subArray addObject:nums[i]];
        [subIndex addObject:[NSNumber numberWithInteger:i]];
        [self permuteUniqueWithNums:nums subArray:[subArray mutableCopy] 
                           subIndex:[subIndex mutableCopy] result:result];
        [subArray removeObjectAtIndex:subArray.count-1];
        [subIndex removeObjectAtIndex:subIndex.count-1];
    }
}


#pragma mark - Word Ladder
- (void)testWordLadder
{
    NSString *start = @"hit";
    NSString *end = @"cog";
    NSArray *array = @[@"hot",@"dot",@"dog",@"lot",@"log"];
    NSInteger num =[self ladderLength:start end:end dict:[NSSet setWithArray:array]];
    NSLog(@"%ld",num);
    
}
//Given two words (start and end), and a dictionary, find the length of shortest transformation sequence from start to end, such that:
//
//Only one letter can be changed at a time
//Each intermediate word must exist in the dictionary
//
//
//Notice
//Return 0 if there is no such transformation sequence.
//All words have the same length.
//All words contain only lowercase alphabetic characters.
//
//
//Example
//Given:
//start = "hit"
//end = "cog"
//dict = ["hot","dot","dog","lot","log"]
//As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
//return its length 5.


//int ladderLength(string start, string end, unordered_set<string> &dict) {
-(NSInteger)ladderLength:(NSString *)start end:(NSString *)end dict:(NSSet *)dict
{
    if(!dict.count || start.length != end.length || start.length == 0)
        return 0;
    
    return [self ladderLengthBFS:start end:end dict:dict];
}

-(NSInteger)ladderLengthBFS:(NSString *)start end:(NSString *)end dict:(NSSet *)dic
{
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *curArray = [[NSMutableArray alloc] init];
    [curArray addObject:start];
    
    NSInteger count = 1;
    while(curArray.count)
    {
        count++;
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for(NSInteger i=0; i<curArray.count; i++)
        {
            NSMutableString *str = [curArray[i] mutableCopy];
            for(int j=0; j<str.length; j++)
            {
                for(int x=0; x<26; x++)
                {
                    char curC = 'a' + x;
                    NSString *newStr = [str stringByReplacingCharactersInRange:NSMakeRange(j,1) withString:[NSString stringWithFormat:@"%c", curC]];
                    
                    if([newStr isEqual:end])
                        return count;
                    
                    if([dic containsObject:newStr] && ![mutDic objectForKey:newStr])
                    {
                        mutDic[newStr] = [NSNumber numberWithInteger:count];
                        [tempArray addObject:newStr];
                    }
                }
            }
        }
        curArray = tempArray;
    }
    return 0;
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
