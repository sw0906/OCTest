//
//  DpTest.m
//  OCTest
//
//  Created by admin on 14/11/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "DpTest.h"

@implementation DpTest

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

@end
