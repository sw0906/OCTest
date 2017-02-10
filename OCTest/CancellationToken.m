//
//  CancellationToken.m
//  OCTest
//
//  Created by shou wei on 21/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CancellationToken.h"


@implementation CancellationToken


-(void)cancel {
    self.cancelled = @YES;
    
}



- (void)testCancelableBlock
{
    dispatch_cancel_block_t cancelBlock = dispatch_async_if(dispatch_get_main_queue(), ^{
        NSLog(@"Block 1 executed");
    });
    
    // Canceling the block execution
    cancelBlock(YES);
    
    // Resuming the block execution
    // cancelBlock(NO);
}

//- (void) textFieldDidChange: (UITextField *)searchField {
//    // if we already had a cancelState object for a potentially running query, cancel it
//    if self.cancelState {
//        self.cancelSate.boolValue = YES;
//    }
//    
//    // do the work asynchronously in the background
//    self.cancelState = cancellable_dispatch_after(0, GLOBAL_ASYNC_QUEUE, ^{
//        self.resultContents = [ServerConn autocompleteSearchField: text];
//        // once we have results from the server, update the UI on the main thread
//        dispatch_async(mainQueue, ^{
//            [self.tableView reloadData];
//        });
//    });
//}



@end

