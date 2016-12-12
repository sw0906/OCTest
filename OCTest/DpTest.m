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
    [self testLongCommonSub];
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

#pragma mark - longestIncreasingSubsequence
-(void)testLong
{
    NSArray *a = @[@4, @2, @4, @5, @7, @3];
    [self longestIncreasingSubsequence:a];
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
