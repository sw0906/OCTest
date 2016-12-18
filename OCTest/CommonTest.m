//
//  CommonTest.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CommonTest.h"
@interface BoolNumber : NSObject
@property (readwrite) BOOL boolValue;
@end

@implementation CommonTest

-(void)testCommon
{
}

#pragma mark -


-(void)testString
{
    NSString *s = @"a b c d e";
    NSString *array = [[NSArray alloc] componentsJoinedByString:s];
    NSLog(@"%@", array.description);
}



NSInteger intSort(id num1, id num2, void *context)
{
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


- (void)testFilter
{
    NSString *firstName = @"Trevor";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName == %@", firstName];
    NSArray<NSNumber *> *a = @[@2,@4,@5];
    NSPredicate *p2 = [NSPredicate predicateWithFormat:@"SELF > 3"];
    NSArray *array = [a filteredArrayUsingPredicate:p2];
    NSArray *array2 = [a filteredArrayUsingPredicate:predicate];
    NSLog(@"%ld - %ld", [array count], [array2 count]);
}


- (void)testSet
{
    NSRange range = NSMakeRange(1, 1);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    NSMutableIndexSet *mi_set = [[NSMutableIndexSet alloc] initWithIndexSet:set];
    [mi_set addIndex:2];
    
    NSArray *array1 = @[@"good", @"Hello, World!", @42, @43];
    [array1 objectsAtIndexes:set];
    
    NSMutableSet *mSet = [[NSMutableSet alloc] init];
    [mSet addObject:@1];
    [mSet containsObject:@1];

}

-(void)testArray{
    
    NSMutableArray *m_array = [NSMutableArray arrayWithObjects:@"good", @"Hello, World!", @42, @43, nil];
    [m_array addObject:@"Tutorials11"];
    [m_array addObjectsFromArray:@[@"Eezy",@"Tutorials"]];
    [m_array insertObject:@"Website" atIndex:1];
    
    
    
    NSLog(@"%@",m_array);
    
    
    
    
    NSMutableArray *nums = [NSMutableArray arrayWithObjects:@1, @2, @5, @4, @7,nil];
    [nums sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 < obj2 ? NSOrderedAscending : NSOrderedDescending; // 从大到小，是反的
    }];
    [nums sortUsingFunction:intSort context:nil];
    NSLog(@"%@",nums);
    
    
    
    //    - (void)addObject:(ObjectType)anObject;
    //    - (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;
    //    - (void)removeLastObject;
    //    - (void)removeObjectAtIndex:(NSUInteger)index;
    //    - (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;
}


-(void)testSort
{
    OCNode *n1 = [[OCNode alloc] init];
    n1.number = 1;
    n1.qq = 22;
    
    OCNode *n2 = [[OCNode alloc] init];
    n2.number = 2;
    n2.qq = 22;
    
    OCNode *n3 = [[OCNode alloc] init];
    n3.number = 3;
    n3.qq = 22;
    
    NSArray *nodes = [NSArray arrayWithObjects:n3,n1,n2, nil];
    NSMutableArray *mNodes = [NSMutableArray arrayWithArray:nodes];
    
    
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    NSArray *newNodes = [nodes sortedArrayUsingDescriptors:@[des]];
    [mNodes sortUsingDescriptors:@[des]];

    
    NSArray *newNodes1 =[nodes sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        OCNode *ob1 = (OCNode *)obj1;
        OCNode *ob2 = (OCNode *)obj2;
        return ob1.number > ob2.number ? NSOrderedDescending : NSOrderedAscending;
    }];
    
    
    
    NSLog(@"%@", newNodes1);
    NSLog(@"%@", newNodes);
    
}


-(void)testMap
{
    NSDictionary<NSString *, NSNumber *> *dic = @{
                          @"Mercedes-Benz SLK250" : [NSNumber numberWithInt:13],
                          @"Mercedes-Benz E350" : [NSNumber numberWithInt:22],
                          @"BMW M3 Coupe" : [NSNumber numberWithInt:19],
                          @"BMW X6" : [NSNumber numberWithInt:16],
                          };
    
    NSMutableDictionary *m_dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [m_dic setObject:@2329 forKey:@"qq2"];
    [m_dic setObject:@23292 forKey:@"qq"];
    [m_dic setObject:@2329 forKey:@"qqq"];
    [m_dic setObject:@2329 forKey:@"qq11"];
    //    [m_dic removeObjectForKey:@"qq"];
    NSLog(@"%@", m_dic.description);
    NSLog(@"%@", dic.description);
}




//We can return it from our cancellable_dispatch_after method like so:






//So anybody calling this API will have a BoolNumber object which can cancel the block from running anytime during the "when" waiting period




//+ (id)singleton {
//    static id sharedMyManager = nil;
//    @synchronized([MyObject class]){
//        if (sharedMyManager == nil) {
//            sharedMyManager = [[self alloc] init];
//        }
//    }
//    return sharedMyManager;
//}
//@end
//
////using block
//+ (id) singleton {
//    static SomeManager *sharedMyManager = nil;
//    static dispatch_once_t  onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedMyManager = [[self alloc] init];
//    });
//    return sharedMyManager;
//}
@end
