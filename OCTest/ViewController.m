//
//  ViewController.m
//  OCTest
//
//  Created by admin on 8/11/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "ViewController.h"
#import "OCNode.h"
#import "DpTest.h"
#import "CommonTest.h"
#import "CancellationToken.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testCommon];
    [self testDp];
    [self testDispatch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - dp

-(void)testCommon
{
    CommonTest *ct = [[CommonTest alloc] init];
    [ct testFilter];
}

//#import "DpTest.h"
-(void)testDp
{
    DpTest *test = [[DpTest alloc] init];
    [test testMinCut];
}


- (void) testDispatch2
{
    CancellationToken *token = cancellable_dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"Here");
    });
    
    [token cancel];
}

- (void)testDispatch
{
    CancellationToken *t = [self cancellable_dispatch_after2:dispatch_time(DISPATCH_TIME_NOW,  2 * NSEC_PER_SEC) withQueue:dispatch_get_main_queue() withBlock:^{
        NSLog(@"pass");
    }];
    t.cancelled = YES;
}


- (CancellationToken *) cancellable_dispatch_after2:(dispatch_time_t)t withQueue:(dispatch_queue_t)q withBlock:(dispatch_block_t)b
{
    CancellationToken *cancelState = [[CancellationToken alloc] init];
    // the newBlock only runs after "when" and only if the cancelState bool value is set to false
    dispatch_block_t newBlock = ^{
        if ( cancelState.cancelled == NO)
            b();
    };
    dispatch_after(t, q, newBlock);
    return cancelState;
}


@end
