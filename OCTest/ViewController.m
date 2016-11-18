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


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testCommon];
    [self testDp];
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


@end
