//
//  JKChild.m
//  OCTest
//
//  Created by shou wei on 06/02/17.
//  Copyright © 2017年 admin. All rights reserved.
//



//  JKChild.m

#import "JKChild.h"

@implementation JKChild

- (id) init {
    if (self = [super init]) {
        self.happyVal = 100;
        //定时器，1秒钟调用一次timerAction：函数
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timerAction
{
    //方式一：
    //    _happyVal += 1;
    
    //方式二：
    _happyVal--;      //直接修改不会触发监听，还需通过KVC方式设置
    [self setValue:[NSNumber numberWithInteger:_happyVal] forKey:@"happyVal"];
}





@end




//  JKNurse.m

@implementation JKNurse

- (id)init{
    if (self = [super init]) {
        
        self.child = [JKChild new];
        
        //KVO 注册监听，监听JKChild类中happyVal的值变化
        [self.child addObserver:self forKeyPath:@"happyVal" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"xxx"];
    }
    return self;
}

- (id)initWithChild:(JKChild *)child {
    if (self = [super init]) {
        
        self.child = child;
        
        //KVO 注册监听，监听JKChild类中happyVal的值变化
        [self.child addObserver:self forKeyPath:@"happyVal" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"xxx"];
    }
    return self;
}

// 监听响应

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    NSLog(@"keyPath:%@, object:%@,change:%@, context:%@", object, keyPath, change, context);
}

//- (void)dealloc {
//    // 移除监听
//    [self.child removeObserver:self forKeyPath:@"happyVal"];
//    
//}

@end
