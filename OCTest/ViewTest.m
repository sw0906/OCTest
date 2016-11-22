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
    [self superview];
}

-(void)testCommonView
{
    
    UIView *a = [UIView new];
    UIView *b = [UIView new];
    [a addSubview:b];
    [self addSubview:a];
    [self commonSuperView:b];
}

-(UIView *)commonSuperView:(UIView *)a
{
    NSMutableSet *views = [NSMutableSet new];
    while( a )
    {
        [views addObject:a];
        a = [a superview];
    }
    
    UIView *me = self;
    while (me) {
        if ([views containsObject:me]) {
            return me;
        }
        
        me = [me superview];
    }
    
    return nil;
}
@end
