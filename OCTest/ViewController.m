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
#import "TreeTest.h"
#import "LinkTest.h"
#import "ViewTest.h"
#import "CustomCell.h"
#import "FBTest.h"
#import "StringTest.h"
#import "BinarySearchTest.h"
#import "DataStructureTest.h"
#import "GraphTest.h"
#import "SearchTest.h"
#import "ArrayNumberTest.h"

@interface ViewController ()
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testCommon];
//    [self testDp];
//    [self testDispatch];
    [self testTree];
//    [self testView];
//    [self testFb];
    [self testString];
    [self testBS];
//    [self testLink];
//    [self testData];
//    [self testGraph];
//    [self testSearch];
    [self testArrayNumber];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Array Number
-(void)testArrayNumber
{
    ArrayNumberTest *test = [ArrayNumberTest new];
    [test testArray];
}

#pragma mark - search
-(void)testSearch
{
    SearchTest *search = [SearchTest new];
    [search testSearch];
}

#pragma mark - graph
-(void)testGraph
{
    GraphTest *graph = [GraphTest new];
    [graph testGraph];
}


#pragma mark - data structrue
- (void)testData
{
    DataStructureTest *data = [DataStructureTest new];
    [data testData];
}

#pragma mark - link node
-(void)testLink
{
    LinkTest *lt = [LinkTest new];
    [lt testLink];
}

#pragma mark - binary search
-(void)testBS
{
    BinarySearchTest *bs = [BinarySearchTest new];
    [bs testBS];
}

#pragma mark - string

-(void)testString
{
    StringTest *str = [StringTest new];
    [str testString];
}

#pragma mark - fb
-(void)testFb
{
    FBTest *fb = [FBTest new];
    [fb testFb];
}

#pragma mark - dp

-(void)testCommon
{
    CommonTest *ct = [[CommonTest alloc] init];
    [ct testCommon];
}

//#import "DpTest.h"
-(void)testDp
{
    DpTest *test = [[DpTest alloc] init];
    [test testDp];
}




#pragma mark - treeNode
- (void)testTree
{
    TreeTest *tree = [[TreeTest alloc] init];
//    [tree testLCA];
    [tree testTree];
}



#pragma mark - viewTest
-(void)testView
{
    ViewTest *v = [ViewTest new];
    [v testView];
}



#pragma mark - dispatch
-(void)testDispatch
{
    [self testDispatchBlock];
    [self testDispatchToken];
    [self testDispatch3];
}

-(void)testDispatchBlock // block
{
    dispatch_cancel_block_t cancelBlock = dispatch_async_if(dispatch_get_main_queue(), ^{
        NSLog(@"Block 1 executed");
    });
    
    cancelBlock(YES);
}

- (void) testDispatchToken // token
{
    CancellationToken *token = cancellable_dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"Here");
    });
    
    [token cancel];
}


- (void)testDispatch3
{
    CancellationToken *t = [self cancellable_dispatch_after2:dispatch_time(DISPATCH_TIME_NOW,  2 * NSEC_PER_SEC) withQueue:dispatch_get_main_queue() withBlock:^{
        NSLog(@"pass");
    }];
    t.cancelled = YES;
    
    
    dispatch_cancel_block_t cancelBlock = [self cancellable_dispatch_after3:dispatch_time(DISPATCH_TIME_NOW,  2 * NSEC_PER_SEC) withQueue:dispatch_get_main_queue() withBlock:^{
        NSLog(@"pass2");
    }];

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


-(dispatch_cancel_block_t)cancellable_dispatch_after3:(dispatch_time_t)t withQueue:(dispatch_queue_t)q withBlock:(dispatch_block_t)b
{
    dispatch_cancel_block_t cancelBlock = ^(BOOL isCancelled)
    {
        if (!isCancelled) {
            b();
        }
    };
    return cancelBlock;
}

#pragma mark - Operation queue

- (void)testMutiThread
{
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    queue.maxConcurrentOperationCount = 4;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"test");
    }];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"test1");
    }];//[[NSOperation alloc] init];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"test2");
    }];
    
    //    [op addDependency:op2];
    [queue addOperation:op];
    [queue addOperation:op2];
    //    BOOL cancellable = op2.isCancelled;
    //    [op2 cancel];
    //    [queue setSuspended:YES];
    //    [queue cancelAllOperations];
}




#pragma mark - test cache



@end

//- (void)testDispatch3
//{
//    __weak NSNumber *number = [NSNumber numberWithBool:YES];
//    cancellable_dispatch_after3(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"Here");
//    }, number);
//    number = [NSNumber numberWithBool:NO];
//}
//
//- (void)testDispatch
//{
////    __block NSNumber *number = [NSNumber numberWithBool:NO];
//    __block int number = 1;
//    [self cancellable_dispatch_after4:dispatch_time(DISPATCH_TIME_NOW,  2 * NSEC_PER_SEC) withQueue:dispatch_get_main_queue() withBlock:^{
//        NSLog(@"pass");
//    } withFlag:number];
//    number = 0;
////    number = [NSNumber numberWithBool:YES];
//}
//
//
//- (void) cancellable_dispatch_after4:(dispatch_time_t)t withQueue:(dispatch_queue_t)q withBlock:(dispatch_block_t)b withFlag:( int )number
//{
//    dispatch_block_t newBlock = ^{
//        if ( number != 0)
//            b();
//    };
//    dispatch_after(t, q, newBlock);
//}

