//
//  SWManager.m
//  OCTest
//
//  Created by shou wei on 18/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SWManager.h"

@implementation SWManager

+ (id)sharedInstance
{
    static dispatch_once_t t;
    static SWManager *manager = nil;
    dispatch_once(&t, ^{
        manager = [SWManager new];
    });
    return manager;
}

@end
