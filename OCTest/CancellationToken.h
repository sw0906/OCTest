//
//  CancellationToken.h
//  OCTest
//
//  Created by shou wei on 21/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancellationToken : NSObject
@property BOOL cancelled;
-(void)cancel;

@end







//NS_INLINE void cancellable_dispatch_after3(dispatch_time_t time,
//                                                        dispatch_queue_t queue,
//                                                        dispatch_block_t block, NSNumber *number)
//{
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if ([number boolValue] == YES) {
//            block();
//        }
//    });
//}


NS_INLINE CancellationToken *cancellable_dispatch_after(dispatch_time_t time,
                                                        dispatch_queue_t queue,
                                                        dispatch_block_t block)
{
    __block CancellationToken *token = [CancellationToken new];
    
//    dispatch_block_t wrapper = ^{
//        if (!token.cancelled) {
//            block();
//        }
//    };
    
//    dispatch_after(time, queue, wrapper);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!token.cancelled) {
            block();
        }
    });
    return token;
}


