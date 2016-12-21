//
//  FBTest.m
//  OCTest
//
//  Created by shou wei on 25/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "FBTest.h"

@implementation FBTest

- (void)testFb
{
    [self testDu];
}



#pragma mark -  Anagram checker
- (void)testAnagram
{
    NSArray *array = @[@"lint", @"intl", @"tl", @"code", @"itnl", @"deco", @"decc"];
    NSMutableArray *re = [self getAnagramChcecker:array];
    NSLog(@"%ld", [re count]);
}

- (NSString *)getKey:(NSString *)str
{
    //init
    int dic[26];
    for (int i=0; i<26; i++) {
        dic[i] = 0;
    }
    for(int i=0; i<[str length]; i++)
    {
        char c = [str characterAtIndex:i];
        int n = c- 'a';
        dic[n] += 1;
    }
    
    //new string
    NSMutableString *newStr = [NSMutableString new];
    for(int i=0; i<26; i++) {
        int count = dic[i];
        while (count) {
            char c = 'a' + i;
            [newStr appendFormat:@"%c", c];
            count--;
        }
    }
    return newStr;
}

-(NSMutableArray *)getAnagramChcecker:(NSArray *)array
{
    NSMutableArray *re = [NSMutableArray new];
    NSMutableDictionary<NSString*, NSMutableArray<NSString *>*> *dic = [NSMutableDictionary new];
    
    for (NSString *s in array) {
        NSString *newS = [self getKey:s];
        if (dic[newS] != nil) {
            [dic[newS] addObject:s];
        }
        else
        {
            NSMutableArray<NSString *> *sub = [NSMutableArray new];
            [sub addObject:s];
            dic[newS] = sub;
        }
    }
    
    for (NSMutableArray *list in [dic allValues]) //!! allValues
    {
        [re addObject:list];
    }
    return re;
}






#pragma mark - string to number
- (void)testStoNum
{
    NSInteger num = [self stringToNumber:@"54782"];
    NSLog(@"%ld", num);
}
-(NSInteger)stringToNumber:(NSString *)str
{
    NSInteger total = 0;
    for (int i=0; i<[str length]; i++) {
        char c = [str characterAtIndex:i];
        NSInteger curNum = c - '0';
        total *= 10;
        total += curNum;
    }
    return total;
}



#pragma mark - nested
-(void)testNested
{
    NestedInteger *i1 = [NestedInteger new];
    NestedInteger *i2 = [NestedInteger new];
    NestedInteger *i3 = [NestedInteger new];
    NestedInteger *i4 = [NestedInteger new];
    NestedInteger *i5 = [NestedInteger new];
    NestedInteger *i6 = [NestedInteger new];
    i1.number = 1;
    i2.number = 2;
    i3.number = 3;
    i4.number = 4;
    i5.number = 5;
    i6.number = 6;
    
    NSMutableArray<NestedInteger *> *n2, *n3, *n4, *n5;
    n2 = [[NSMutableArray<NestedInteger *> alloc] init];
    n3 = [[NSMutableArray<NestedInteger *> alloc] init];
    n4 = [[NSMutableArray<NestedInteger *> alloc] init];
    n5 = [[NSMutableArray<NestedInteger *> alloc] init];
    [n2 addObject: i2];
    [n2 addObject: i3];
    [n3 addObject: i4];
    [n3 addObject: i5];
    NestedInteger *t2 = [[NestedInteger alloc] init];
    t2.list = n2;
    
    NestedInteger *t3 = [[NestedInteger alloc] init];
    t3.list = n3;
    NestedInteger *t4 = [[NestedInteger alloc] init];
    [n4 addObject:t3];
    [n4 addObject:i6];
    t4.list = n4;
    
    [n5 addObject:i1];
    [n5 addObject:t2];
    [n5 addObject:t4];
    
    NestedIterator *it = [NestedIterator nestedIterator:n5];
    [it allObjects]; //!!important
    
//    NSInteger n11 = [it next];
//    NSInteger n22 = [it next];
//    NSInteger n33 = [it next];
//    NSInteger n44 = [it next];
//    NSInteger n55 = [it next];
//    NSInteger n66 = [it next];
}


#pragma mark - number pad

-(void)testPhonePad
{
    NSString *str  = @"fb1";
    [self getArraysWithInputs:str];
}


-(NSArray *)getArraysWithInputs:(NSString *)str
{
    NSArray *counts = @[@0,@3,@3,@3,@3,@3,@4,@3,@4];
    NSMutableDictionary *dicNum = [NSMutableDictionary new];//dicNum[1] = @"1,a,b,c"
    NSMutableDictionary *dicChar = [NSMutableDictionary new];//dicChar[a] = 1
    
    //init dic
    char begin = 'a';
    for(int i=0; i<[counts count]; i++)
    {
        NSMutableArray *mutArray = [NSMutableArray new];
        NSString *curNumber = [NSString stringWithFormat:@"%d", i+1];
        
        int countC = [counts[i] intValue];
        while(countC)
        {
            NSString *curChar = [NSString stringWithFormat:@"%c", begin];
            dicChar[curChar] = curNumber;
            [mutArray addObject:curChar]; //add char
            begin++; // !!
            countC--; // !!
        }
        
        
        [mutArray addObject:curNumber];//add number
        dicNum[curNumber] = mutArray;
        dicChar[curNumber] = curNumber;
    }
    
    
    //result
    NSMutableArray *result = [NSMutableArray new];
    for(int i=0; i<[str length]; i++)
    {
        char c = [str characterAtIndex:i];
        NSString *n =  dicChar[[NSString stringWithFormat:@"%c", c]];
        NSMutableArray *counts = dicNum[n];//1 a b c
        
        
        NSMutableArray *tmp = [NSMutableArray new];
        for(int i=0; i<[counts count]; i++)
        {
            NSString *s = counts[i];
            if(![result count])
            {
                [tmp addObject:s];//1 a b c
            }
            else
            {
                for(NSString *t in result)
                {
                    NSString *fullStr = [t stringByAppendingString:s];
                    [tmp addObject:fullStr];
                }
            }
        }
        result = tmp; // !!!
    }
    return result;
    
}





#pragma mark - array
-(void)testArray
{
    NSArray *array = @[ @1, @0, @2, @0, @0, @3, @4];
    NSInteger number = [self getNonZeroNumbers:array];
    [self moveZeroToEnd:[array mutableCopy]];
    
    NSLog(@"%ld", number);
    
}


- (NSInteger)getNonZeroNumbers:(NSArray *)array
{
    NSInteger count = 0;
    NSNumber *zero = @(0);
    for (NSNumber* n in array) {
        if (n != zero) {
             count++;
        }
    }
    return count;
}

- (void)moveZeroToEnd:(NSMutableArray *)array
{
    if ([array count] <= 1) {
        return;
    }
    
    NSInteger i = 0, j = [array count]-1;
    while (i<j) {
        while ([array[i] integerValue] != 0) {
            i++;
        }
        
        while (array[j] == 0 ) {
            j--;
        }
        
        if (i<j) {
            NSNumber *tempN = array[j];
            array[j] = array[i];
            array[i] = tempN;
            i++;
            j--;
        }
        
    }
}


#pragma mark - du
- (void)testDu
{
    NSArray *array = @[@2, @1, @0, @2, @0, @0, @3, @4];
    NSMutableArray *muA = [array mutableCopy];
    [self removeDuplicate2:muA];
    
    NSString *words = @"abb abbd abb bdsf bbs dd bbs";
    NSArray *ws = [words componentsSeparatedByString:@" "];
    NSMutableArray *re = [ws mutableCopy];
    [self removeDuWords:re];
    
    NSLog(@"%ld", [muA count]);
}


-(void)removeDuWords:(NSMutableArray *)array
{
    //sort
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return obj1 < obj2 ? NSOrderedAscending : NSOrderedDescending;//从小到大
    }];
    
    NSInteger i = 1;
    while (i < [array count]) {
        while (array[i-1] == array[i]) {
            [array removeObjectAtIndex:i];//!!important
        }
        i++;
    }
}

- (void)removeDuplicate:(NSMutableArray *)array
{
    //sort
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue] ? NSOrderedAscending : NSOrderedDescending;//从小到大
    }];
    

    NSInteger i = 1;
    while (i < [array count]) {
        while (array[i-1] == array[i]) {
            [array removeObjectAtIndex:i];//!!important
        }
        i++;
    }
}

- (void)removeDuplicate2:(NSMutableArray *)array
{
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue]) {
            return NSOrderedAscending;
        }
        
        return NSOrderedDescending;
    }];
    
    for (NSInteger i=1; i<array.count; i++) {
        if (array[i] == array[i-1]) {
            [array removeObjectAtIndex:i];
            i--;
        }
    }
}


-(void)removeDu2:(NSMutableArray *)array
{
    NSMutableSet *set = [NSMutableSet new];
    for(int i=0; i<[array count]; i++)
    {
        if ([set containsObject:array[i]]) {
            [array removeObjectAtIndex:i];
            i--;
        }
        else
        {
            [set addObject:array[i]];
        }
    }
}

-(void)removeDu3:(NSMutableArray *)array
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for(int i=0; i<[array count]; i++)
    {
        if (dic[array[i]] != nil) {
            [array removeObjectAtIndex:i];
            i--;
        }
        else
        {
            dic[array[i]] = @(1);
        }
    }
}


#pragma mark - reverse words
-(void)testReversWords
{
    NSString *str = @"good is not god";
    NSLog(@"%@", [self reverseSentence:str]);
    NSLog(@"%@", [self reverseSentence2:str]);
}


- (NSString *)reverseSentence:(NSString *)words
{
    NSArray *list = [words componentsSeparatedByString:@" "]; //[lazy , brown , fox ]
    NSMutableString *newString = [NSMutableString new];
    
    for(NSInteger i = [list count]-1; i>=0; i--) //
    {
        [newString appendString: list[i]];
        if(i != 0 )
        {
            [newString appendString:@" "];
        }
    }
    return newString;
}


- (NSString *)reverseSentence2:(NSString *)words
{
    NSArray *list = [words componentsSeparatedByString:@" "];
    NSArray *reList = [[list reverseObjectEnumerator] allObjects];
    NSString *newString = [reList componentsJoinedByString:@" "];
    return newString;
}


@end
