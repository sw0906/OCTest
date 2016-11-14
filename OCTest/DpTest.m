//
//  DpTest.m
//  OCTest
//
//  Created by admin on 14/11/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DpTest.h"

@implementation DpTest

//jump
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

//longestIncreasingSubsequence
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
