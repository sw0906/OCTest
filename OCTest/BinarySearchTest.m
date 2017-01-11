//
//  BinarySearchTest.m
//  OCTest
//
//  Created by admin on 15/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "BinarySearchTest.h"

@implementation MinMaxResult

- (id)init
{
    if(self = [super init])
    {
        self.minV = INT32_MAX;
        self.maxV = INT32_MIN;
    }
    return self;
}

@end


@implementation BinarySearchTest

- (void)testBS
{
//    [self testOccur];
//    [self testMaxInMountain];
//    [self testPeak];
//    [self testBVersion];
    [self testSRS];
}

#pragma mark - Total Occurrence of Target
-(void)testOccur
{
    NSArray *array = @[@(1), @(1), @(1), @(5), @(6)];
     NSArray *array1 = @[@(2), @(2), @(2), @(2), @(2)];
     NSArray *array2 = @[@(1), @(2), @(2), @(5), @(6)];
    NSInteger n1 = [self totalOccurrence:array withTarget:1];
    NSInteger n2 =[self totalOccurrence:array1 withTarget:2];
    NSInteger n3 = [self totalOccurrence:array2 withTarget:7];
}

//Given a target number and an integer array sorted in ascending order. Find the total number of occurrences of target in the array.
//
//Example
//Given [1, 3, 3, 4, 5] and target = 3, return 2.
//
//Given [2, 2, 3, 4, 6] and target = 4, return 1.
//
//Given [1, 2, 3, 4, 5] and target = 6, return 0.

//int totalOccurrence(vector<int>& A, int target) {
-(NSInteger)totalOccurrence:(NSArray *)a withTarget:(NSInteger)target
{
    if (!a.count) {
        return 0;
    }
    
    MinMaxResult *re = [MinMaxResult new];
    [self totalOccurHelper:a withTarget:target withStart:0 withEnd:a.count-1 withResult:re];
    
    if (re.minV != INT32_MAX) {
        return re.maxV - re.minV + 1;
    }
    return 0;
}

- (void)totalOccurHelper:(NSArray *)a withTarget:(NSInteger)target withStart:(NSInteger)start withEnd:(NSInteger)end withResult:(MinMaxResult *)re
{
    if (start + 1 == end) {
        if ([a[start] integerValue] == target) {
            re.minV = MIN(re.minV, start);
            re.maxV = MAX(re.maxV, start);
        }
        if ([a[end] integerValue] ==  target) {
            re.minV = MIN(re.minV, end);
            re.maxV = MAX(re.maxV, end);
        }
        return;
    }
    
    
    if ([a[start] integerValue] == target && [a[end] integerValue] == target) {
        re.minV = MIN(re.minV, start);
        re.maxV = MAX(re.maxV, end);
        return;
    }
    else
    {
        NSInteger mid = (end - start)/2 + start;
        [self totalOccurHelper:a withTarget:target withStart:start withEnd:mid withResult:re];
        [self totalOccurHelper:a withTarget:target withStart:mid withEnd:end withResult:re];
    }
}


#pragma mark - Maximum Number in Mountain Sequence
- (void)testMaxInMountain
{
    NSArray *array = @[@(1),  @(2), @(4), @(8), @(6), @(3)];
    NSArray *array1 = @[@(10),  @(12), @(14), @(8), @(6), @(3)];
    NSArray *array2 = @[@(10),  @(9), @(8), @(7), @(6), @(3)];
    NSArray *array3 = @[@(1),  @(4), @(5), @(7), @(8), @(3)];
    NSInteger re = [self mountainSequence:array];
    re =[self mountainSequence:array1];
    re =[self mountainSequence:array2];
    re =[self mountainSequence:array3];
}

//Example
//Given nums = [1, 2, 4, 8, 6, 3] return 8
//Given nums = [10, 9, 8, 7], return 10
//int mountainSequence(vector<int>& nums) {
- (NSInteger) mountainSequence:(NSArray<NSNumber *> *) nums
{
    if (nums.count == 0) {
        return 0;
    }
    
    NSInteger result = [self mountainSequence:nums withStart:0 withEnd:nums.count-1];

    return result;
}

- (NSInteger) mountainSequence:(NSArray<NSNumber *> *) nums withStart:(NSInteger)start withEnd:(NSInteger)end
{
    if (end == start + 1) {
        NSInteger result = nums[start] > nums[end] ? [nums[start] integerValue] : [nums[end] integerValue];
        return result;
    }
    NSInteger mid = (end - start)/2 + start;
    if (nums[start] > nums[mid]) {
        return [self mountainSequence:nums withStart:start withEnd:mid];
    }
    else
    {
        return [self mountainSequence:nums withStart:mid withEnd:end];
    }
}

#pragma mark - Find Peak Element
/*
There is an integer array which has the following features:

The numbers in adjacent positions are different.
A[0] < A[1] && A[A.length - 2] > A[A.length - 1].
We define a position P is a peek if:

A[P] > A[P-1] && A[P] > A[P+1]
Find a peak element in this array. Return the index of the peak.

Notice

The array may contains multiple peeks, find any of them.

Have you met this question in a real interview? Yes
Example
Given [1, 2, 1, 3, 4, 5, 7, 6]

Return index 1 (which is number 2) or 6 (which is number 7)
 
*/

//int findPeak(vector<int> A) {


- (void)testPeak
{
//    1, 2, 1, 3, 4, 5, 7, 6
    NSArray *array = @[@(1),  @(2), @(1), @(3), @(7), @(6)];
    NSArray *array1 = @[@(10),  @(12), @(14), @(8), @(6), @(3)];
    NSArray *array2 = @[@(10),  @(9), @(8), @(7), @(6), @(3)];
    NSArray *array3 = @[@(1),  @(4), @(5), @(7), @(8), @(3)];
    NSInteger re = [[self findPeak:array] integerValue];
    re =[self mountainSequence:array1];
    re =[self mountainSequence:array2];
    re =[self mountainSequence:array3];
}

- (NSNumber *)findPeak:(NSArray *)array
{
    return [self findPeakWithArray:array leftIndex:0 rightIndex:array.count-1];
}

- (NSNumber *)findPeakWithArray:(NSArray *)arr leftIndex:(NSInteger)l rightIndex:(NSInteger)r
{
    NSInteger mid = (r - l)/2 + l;
    
    if (r - l == 1) {
        return arr[r] > arr[l] ? arr[r] : arr[l];
    }
    
    if (arr[mid] > arr[mid + 1]) {
        return [self findPeakWithArray:arr leftIndex:l rightIndex:mid];
    }
    else
    {
        return [self findPeakWithArray:arr leftIndex:mid rightIndex:r];
    }
}


#pragma mark -  First Bad Version
/*
The code base version is an integer start from 1 to n. One day, someone committed a bad version in the code case, so it caused this version and the following versions are all failed in the unit tests. Find the first bad version.

You can call isBadVersion to help you determine which version is the first bad one. The details interface can be found in the code's annotation part.

Notice

Please read the annotation in code area to get the correct way to call isBadVersion in different language. For example, Java is SVNRepo.isBadVersion(v)

Have you met this question in a real interview? Yes
Example
Given n = 5:

isBadVersion(3) -> false
isBadVersion(5) -> true
isBadVersion(4) -> true
Here we are 100% sure that the 4th version is the first bad version.
*/

//int findFirstBadVersion(int n) {

-(void)testBVersion
{
    NSInteger version = [self findFirstBadVersion:22];
}


- (BOOL)isBadVersion:(NSInteger)n
{
    NSInteger badVersion = 7;
    return n>=badVersion ? YES : NO ;
}





//main
- (NSInteger)findFirstBadVersion:(NSInteger)n
{
    return [self findFBV_left:0 right:n];
}

- (NSInteger)findFBV_left:(NSInteger)l right:(NSInteger)r
{
    if ( l == r-1 ) {
        return [self isBadVersion:l] ? l : r;
    }
    
    NSInteger m = l + (r-l)/2;
    if ([self isBadVersion:m]) {
        return [self findFBV_left:l right:m];
    }
    else
    {
        return [self findFBV_left:m right:r];
    }
}

#pragma mark - Search in Rotated Sorted Array
/*
Suppose a sorted array is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

You are given a target value to search. If found in the array return its index, otherwise return -1.

You may assume no duplicate exists in the array.

Have you met this question in a real interview? Yes
Example
For [4, 5, 1, 2, 3] and target=1, return 2.

For [4, 5, 1, 2, 3] and target=0, return -1.
*/

//int search(vector<int> &A, int target) {



-(void)testSRS
{
    NSArray *arr = @[@(4), @(5), @(1), @(2), @(3)];
    NSInteger re = [self searchRSarray:arr target:@(6)];
    re = [self searchRSarray:arr target:@(2)];
    re = [self searchRSarray:arr target:@(1)];
}

//main
- (NSInteger)searchRSarray:(NSArray *)a target:(NSNumber *)target
{
    return [self searchRSAleft:0 right:a.count-1 target:target array:a];
}

- (NSInteger)searchRSAleft:(NSInteger)l right:(NSInteger)r target:(NSNumber *)t array:(NSArray *)a
{
    if (l == r-1) {
        if (a[l] == t)
            return l;
        else if(a[r] == t)
            return r;
        else
            return -1;
    }
    
    NSInteger m = l + (r-l)/2;
    if (a[l] < a[m]) {
        if (t >= a[l] && t <= a[m]) {
            return [self searchRSAleft:l right:m target:t array:a];
        }
        else
        {
            return [self searchRSAleft:m right:r target:t array:a];
        }
    }
    else
    {
        if (t >= a[m] && t <= a[r]) {
            return [self searchRSAleft:m right:r target:t array:a];
        }
        else
        {
            return [self searchRSAleft:l right:m target:t array:a];
        }
    }
}

@end
