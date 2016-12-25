//
//  DpTest.m
//  OCTest
//
//  Created by admin on 14/11/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DpTest.h"

//    for (int i=0; i<ls; i++) {
//        for (int j=0; j<ls; j++)
//        {
//            NSString *v = pali[i][j] ? @"y" : @"n";//init - default - true
//            if (pali[i][j] ) {
//                NSLog(@"i - %d, j - %d, pali[i][j] - %@", i, j, v);
//            }
//        }
//    }



@implementation DpTest

- (void)testDp
{
//    [self testInterLeavingString];
    [self testlong222];
}




#pragma mark - Interleaving String
-(void)testInterLeavingString
{
    NSString *s1 = @"aabcc";
    NSString *s2 = @"dbbca";
    NSString *s3 = @"aadbbcbcac", *s4 = @"aadbbbaccc";
    BOOL v1 = [self isInterleave:s1 withS2:s2 withS3:s3];
    BOOL v2 = [self isInterleave:s2 withS2:s1 withS3:s4];
}
//Given three strings: s1, s2, s3, determine whether s3 is formed by the interleaving of s1 and s2.
//
//Example
//For s1 = "aabcc", s2 = "dbbca"
//
//When s3 = "aadbbcbcac", return true.
//When s3 = "aadbbbaccc", return false.
//bool isInterleave(string s1, string s2, string s3) {
-(BOOL)isInterleave:(NSString *)s1 withS2:(NSString *)s2 withS3:(NSString *)s3
{
    //state
    BOOL dp[s1.length+1][s2.length+1];
    
    //init
    dp[0][0] = false;
    for (NSInteger i=1; i<=s1.length; i++) {
        dp[i][0] = [s1 characterAtIndex:i-1] == [s3 characterAtIndex:i-1];
    }
    for (NSInteger i=1; i<=s2.length; i++) {
        dp[0][i] = [s2 characterAtIndex:i-1] == [s3 characterAtIndex:i-1];
    }
    
    //main
    for (NSInteger i=1; i<=s1.length; i++) {
        for (NSInteger j=1; j<=s2.length; j++) {
            dp[i][j] = false;
            if (dp[i-1][j]) {
                BOOL v1 = [s1 characterAtIndex:i-1] == [s3 characterAtIndex:i+j-1];
                dp[i][j] = v1;
            }
            if (dp[i][j-1]) {
                BOOL v1 = [s2 characterAtIndex:j-1] == [s3 characterAtIndex:i+j-1];
                dp[i][j] = v1;
            }
        }
    }
    
    return dp[s1.length][s2.length];
}


#pragma mark - Distinct Subsequences

-(void)testDistinct
{
    NSString *s = @"rabbiitt";
    NSString *s2 = @"rabbbit";
    NSString *t = @"rabbit";
    NSInteger re1 = [self numDistinct:s withT:t];
    NSInteger re2 = [self numDistinct:s2 withT:t];
}

//Given a string S and a string T, count the number of distinct subsequences of T in S.
//
//A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ACE" is a subsequence of "ABCDE" while "AEC" is not).
//
//Example
//Given S = "rabbbit", T = "rabbit", return 3.

//int numDistinct(string &S, string &T) {

-(NSInteger)numDistinct:(NSString *)s withT:(NSString *)t
{
    NSInteger lengthS = s.length + 1;
    NSInteger lengthT = t.length + 1;
    
    //state
    NSInteger dp[lengthS][lengthT];
    
    //init
    for (NSInteger i=0; i<lengthS; i++) {
        dp[i][0] = 1;
    }
    for (NSInteger i=1; i<lengthT; i++) {
        dp[0][i] = 0;
    }
    
    //main
    for (NSInteger i=1; i<lengthS; i++) {
        for (NSInteger j=1; j<lengthT; j++) {
            if ([s characterAtIndex:i-1] == [t characterAtIndex:j-1]) {
                NSInteger num = dp[i-1][j-1] + dp[i-1][j];
                dp[i][j] = num;
            }
            else
            {
                dp[i][j] = dp[i-1][j];//!!important
            }
        }
    }
    return dp[s.length][t.length];
}

#pragma mark - Longest Common Substring
- (void)testLongCommonSub
{
    NSString *a =  @"abcdefgg";
    NSString *b = @"cbcdefdd";
    NSInteger re = [self longestCommonSubstring:a withB:b];
    NSLog(@"%ld", re);
}

//Example
//Given A = "ABCD", B = "CBCE", return 2.

// int longestCommonSubstring(string &A, string &B) {

- (NSInteger)longestCommonSubstring:(NSString *)a withB:(NSString *)b
{
    if (a.length == 0 || b.length == 0) {
        return 0;
    }
    
    //state
    NSInteger dp[a.length][b.length];
    
    //init
    NSInteger maxCount = 0;
    for (NSInteger i=0; i<a.length; i++) {
        if ([a characterAtIndex:i] == [b characterAtIndex:0]) {
            maxCount = 1;
            dp[i][0] = 1;
        }
        else
        {
            dp[i][0] = 0;
        }
    }
    
    for (NSInteger i=0; i<b.length; i++) {
        if ([b characterAtIndex:i] == [a characterAtIndex:0]) {
            maxCount = 1;
            dp[0][i] = 1;
        }
        else
        {
            dp[0][i] = 0;
        }
    }
    
    //dp
    for (NSInteger i=1; i<a.length; i++) {
        for (NSInteger j=1; j<b.length; j++) {
            if ([a characterAtIndex:i] == [b characterAtIndex:j]) {
                dp[i][j] = dp[i-1][j-1]+1;
                maxCount = MAX(dp[i][j], maxCount);
            }
            else
            {
                dp[i][j] = 0;
            }
        }
    }
    return maxCount;
}


#pragma mark - parlindrome cut
- (void)testMinCut
{
    int re = [self minCut:@"aabaab"];
    NSLog(@"%d", re);
}

- (int)minCut:(NSString *)s
{
    NSInteger ls = [s length];
    if (ls <= 1) {
        return 0;
    }
    
    //init
    BOOL pali[ls][ls];
    
    //init pali
    for (int i=0; i<ls; i++) {
        pali[i][i] = YES;
        if (i<ls-1 ) {
            pali[i][i+1] = [s characterAtIndex:i] == [s characterAtIndex:i+1];
        }
    }
    
    if (ls<3) {
        return pali[0][ls-1] ? 0 : 1;
    }
    
    for (NSInteger i = ls -3; i>=0; i--) {
        for (NSInteger j = i+2; j<ls; j++) {
            BOOL checkB = pali[i+1][j-1] && [s characterAtIndex:i] == [s characterAtIndex:j];
            pali[i][j] = checkB;
        }
    }
    
    
    //inti - count
    int count[ls+1];
    count[0] = 0;
    
    //dp - back tracing
    for (int i=1; i<=ls; i++) {
        count[i] = i;
        for (int j =0; j<i; j++) {
            if (pali[j][i-1]) {
                count[i] = MIN(count[i], count[j]+1);
            }
        }
        NSLog(@"i - %d, count[i] - %d", i, count[i]);
    }
    

    return count[ls]-1;
}

#pragma mark - minDistance
-(void)testEdit
{
    NSString *a = @"smart";
    NSString *b = @"mart";
    NSInteger dis = [self minDistance:a withB:b];
    NSLog(@"%ld", dis);
}

- (NSInteger)minDistance:(NSString *)a withB:(NSString *)b
{
    NSInteger al = [a length];
    NSInteger bl = [b length];
    
    if (!al && !bl) {
        return 0;
    }
    
    //state
    NSInteger dp[al+1][bl+1];
    
    for (int i=0; i<=al; i++) {
        dp[i][0] = i;
    }
    for (int i=0; i<=bl; i++) {
        dp[0][i] = i;
    }
    
    //dp
    for(int i=1; i<=al; i++)
    {
        for (int j=1; j<=bl; j++)
        {
            NSInteger minV = MIN(dp[i-1][j]+1, dp[i][j-1]+1);
            if([a characterAtIndex:(i-1)] == [b characterAtIndex:(j-1)]){
                minV = MIN(dp[i-1][j-1], minV);
            }
            else
            {
                minV = MIN(dp[i-1][j-1]+1, minV);
            }
            dp[i][j] = minV;
        }
    }
    return dp[al][bl];
}

#pragma mark - Jump
- (void)testJump2
{
    NSArray *array = @[@2,@3,@1,@1,@4];
    [self jump2:array];
}

- (NSInteger)jump2 :(NSArray *)A
{
    //state
    NSMutableArray *counts = [[NSMutableArray alloc] init];

    //init
    NSInteger size = [A count];
    for(int i = 0; i < size; i++)
    {
        [counts addObject:[NSNumber numberWithInteger:INT32_MAX]];
    }
    counts[0] = [NSNumber numberWithInteger:0];
    
    for (int i = 1; i<size; i++) {
        for (int j=0; j<i; j++) {
            if ([counts[j] integerValue]!= INT32_MAX && [A[j] integerValue] >= i-j) {
                NSInteger n = [counts[j] integerValue] + 1;
                counts[i] = MIN( counts[i], [NSNumber numberWithInteger:n]);
            }
        }
    }
    
    return [[counts lastObject] integerValue];
}

#pragma mark -  Longest Increasing Subsequence
-(void)testLong
{
    NSArray *a = @[@4, @2, @4, @5, @7, @3];
    [self longestIncreasingSubsequence:a];
}


//Given a sequence of integers, find the longest increasing subsequence (LIS).
//
//You code should return the length of the LIS.
//
//Clarification
//What's the definition of longest increasing subsequence?
//
//The longest increasing subsequence problem is to find a subsequence of a given sequence in which the subsequence's elements are in sorted order, lowest to highest, and in which the subsequence is as long as possible. This subsequence is not necessarily contiguous, or unique.
//
//https://en.wikipedia.org/wiki/Longest_increasing_subsequence
//
//Example
//For [5, 4, 1, 2, 3], the LIS is [1, 2, 3], return 3
//For [4, 2, 4, 5, 3, 7], the LIS is [2, 4, 5, 7], return 4
//    int longestIncreasingSubsequence(vector<int> nums) {

//-(void)test


-(NSUInteger) longestSubsequence:(NSArray *)input{
    NSUInteger maxValue = 0;
    NSInteger lengthI = input.count;
    NSInteger dp[lengthI];
    dp[0] = 0;
    for(NSInteger i=1; i<input.count; i++)
    {
        if([input[i] integerValue] -[input[i-1] integerValue]== 1)
        {
            dp[i] = dp[i-1]+1;
            maxValue = MAX(dp[i], maxValue);
        }
        else
        {
            dp[i] = 0;
        }
    }
    return maxValue;//dp[lengthI-1];
}

-(void)testlong222
{
    NSArray *array = @[@(1), @(2), @(3), @(5), @(7)];
    NSInteger re =[self longestSubsequence2:array];
}

-(NSUInteger) longestSubsequence2:(NSArray *)input{
    NSUInteger maxValue = 0;
//    NSInteger lengthI = input.count;
    // NSInteger dp[lengthI];
    NSInteger startPoint = 0;
//    dp[0] = 0;
    for(NSInteger i=1; i<input.count; i++)
    {
        if([input[i] integerValue] - [input[i-1] integerValue] == 1)
        {
            // dp[i] = dp[i-1]+1;
            NSInteger currentLength = i - startPoint + 1;
            maxValue = MAX(currentLength, maxValue);
        }
        else
        {
            // dp[i] = 0;
            startPoint = i;
        }
    }
    return maxValue;
}


-(NSInteger) longestIncreasingSubsequence:(NSArray *)a
{
    NSInteger size = [a count];
    
    //state
    NSMutableArray *counts = [[NSMutableArray alloc] init];
    
    //init
    for(int i = 0; i < size; i++)
    {
        [counts addObject:[NSNumber numberWithInteger:1]];
    }
    
    //dp
    NSNumber *maxV = @0;
    for (int i = 1; i<size; i++) {
        for (int j=0; j<i; j++) {
            if (a[i] > a[j]) {
                NSInteger n = [counts[j] integerValue] + 1;
                counts[i] = MAX(counts[i], [NSNumber numberWithInteger:n]);
            }
            maxV = MAX(maxV, counts[i]);
        }
    }
    
    return [maxV integerValue];
}

#pragma mark - Word Break
- (void)testWordBreak
{
    NSArray *array =  @[@"lint", @"code"];
    NSSet *dic = [NSSet setWithArray:array];
    [self wordBreak:@"lintcode" withDict:dic];
}

-(NSInteger)getMaxLength:(NSSet *)dict
{
    NSInteger maxl = 0;
    for (NSString *str in dict) {
        maxl = MAX(maxl, [str length]);
    }
    return maxl;
}

-(BOOL)wordBreak:(NSString *)s  withDict:(NSSet *)dict
{
    NSInteger maxL = [self getMaxLength:dict];
    NSInteger size = [s length];//[dict count];
    
    //init
    BOOL cut[size+1];
    cut[0] = true;
    for (int i=1; i<=size; i++) {
        cut[i] = false;
    }
    
    //dp
    for (int i=1; i<=size; i++)// <=
    {
        for (int j = 1; j<=maxL && j<=i; j++) {
            if (!cut[i-j])
                continue;
            
            NSRange range = NSMakeRange(i-j,j);//i-j
            NSString *subStr = [s substringWithRange:range];
            if([dict containsObject:subStr])
            {
                cut[i] = true;
                break;//!!don't forget
            }
        }
    }
    
//    for (int i=0; i<=size; i++) {
//        NSString *s = cut[i] ? @"true" : @"false";
//        NSLog(@"%@" , s);
//    }
    return cut[size];
}



@end
