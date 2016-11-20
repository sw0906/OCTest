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

NS_INLINE CancellationToken *cancellable_dispatch_after(dispatch_time_t time, dispatch_queue_t queue, dispatch_block_t block) {
    __block CancellationToken *token = [CancellationToken new];
    dispatch_block_t wrapper = ^{
        if (!token.cancelled) {
            block();
        }
    };
    
    dispatch_after(time, queue, wrapper);
    return token;
}


