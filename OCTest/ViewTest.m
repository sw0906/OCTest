//
//  ViewTest.m
//  OCTest
//
//  Created by shou wei on 17/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewTest.h"

@implementation ViewTest


-(void)testView
{
    [self testCommonView];
}

-(void)testCommonView
{
//    a
//    a1 b
//    b1 c
//    c1
    UIView *a = [UIView new];
    UIView *b = [UIView new];
    UIView *c = [UIView new];
    [a addSubview:b];
    [b addSubview:c];
  
    
    
    UIView *a1 = [UIView new];
    UIView *b1 = [UIView new];
    UIView *c1 = [UIView new];
    
    [a addSubview:a1];
    [a1 addSubview:b1];
    [b1 addSubview:c1];
    
    
    UIView *su = [self commonSuperView:c1 withOtherView:b1];
    UIView *su2 = [self commonSuperView:c withOtherView:a1];
    UIView *su3 = [self commonSuperView:a withOtherView:a1];
    
    BOOL v1 = (su == b1);
    BOOL v2 = (su2 == a);
    BOOL v3 = (su3 == a);
}

-(UIView *)commonSuperView:(UIView *)a withOtherView:(UIView *)b
{
    NSMutableSet *views = [NSMutableSet new];
    while( a )
    {
        [views addObject:a];
        a = [a superview];
    }
    
    UIView *me = b;
    while (me) {
        if ([views containsObject:me]) {
            return me;
        }
        
        me = [me superview];
    }
    
    return nil;
}



@end
