//
//  ArrayNumberTest.m
//  OCTest
//
//  Created by shou wei on 21/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ArrayNumberTest.h"

@implementation ArrayNumberTest
-(void)testArray
{
    [self testSubArray];
}

#pragma mark - Maximum Subarray
-(void)testSubArray
{
    NSArray *array =  @[@(-2), @(2), @(-3), @(4), @(-1), @(2), @(1), @(-5), @(3)];
    NSInteger result = [self maxSubArray:array];
}

//Given an array of integers, find a contiguous subarray which has the largest sum.
//
//Notice
//
//The subarray should contain at least one number.
//
//Example
//Given the array [−2,2,−3,4,−1,2,1,−5,3], the contiguous subarray [4,−1,2,1] has the largest sum = 6.
//  int maxSubArray(vector<int> nums) {

-(NSInteger)maxSubArray:(NSArray *)nums
{
    NSInteger maxValue = [nums[0] integerValue];
    NSInteger sum = 0;
    for (NSInteger i=0; i<nums.count; i++) {
        if (sum <0) {
            sum = 0;
        }
        sum += [nums[i] integerValue];
        maxValue = MAX(maxValue, sum);
    }
    return maxValue;
}

@end
