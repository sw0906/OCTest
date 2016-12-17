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

@class DeepLinkManager;

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
//    [self testTree];
//    [self testView];
//    [self testFb];
//    [self testString];
//    [self testBS];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
//+ (instancetype)shareInstance {
//    static dispatch_once_t once;
//    static DeepLinkManager * deepLinkManager = nil;
//    
//    dispatch_once(&once, ^{
//        deepLinkManager = [[self alloc] init];
//    });
//    
//    return deepLinkManager;
//}

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


//
- (void)testDispatch3
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

