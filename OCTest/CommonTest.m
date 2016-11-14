//
//  CommonTest.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "CommonTest.h"

@implementation CommonTest


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

-(void)testArray{
    
    NSRange range = NSMakeRange(1, 1);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    NSMutableIndexSet *mi_set = [[NSMutableIndexSet alloc] initWithIndexSet:set];
    [mi_set addIndex:2];
    
    
    
    NSArray *array1 = @[@"good", @"Hello, World!", @42, @43];
    [array1 objectsAtIndexes:set];
    
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
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    NSArray *newNodes = [nodes sortedArrayUsingDescriptors:@[des]];
    NSArray *newNodes1 =[nodes sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        OCNode *ob1 = (OCNode *)obj1;
        OCNode *ob2 = (OCNode *)obj2;
        return ob1.number > ob2.number ? NSOrderedDescending : NSOrderedAscending;
    }];
    
    
    
    NSLog(@"%@", newNodes1);
    
}


-(void)testMap
{
    NSDictionary *dic = @{
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
}

@end
