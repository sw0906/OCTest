//
//  FBTest.m
//  OCTest
//
//  Created by shou wei on 25/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "FBTest.h"
#import "TreeNode.h"

@implementation FBTest

- (void)testFb
{
//    [self testDu];
    [self testAnagram];
//    [self testPhonePad];
//    [self testArray];
//    [self testDu];
//    [self testCombinationPadString];
    
    [self testing];
}



- (void)testing
{
    NSArray *strArray = @[@"lint", @"intl", @"tl", @"code", @"itnl", @"deco", @"decc"];
    
    //nums
    NSArray *nums = @[@2, @1, @0, @2, @0, @0, @3, @4];
    
    
    //tree
    TreeNode *root = [self getSampleTree];
    
    //like node
    LinkNode *node = [self getSampleNodeList];
    
    //number pad
    NSString *str4 = @"926";
    
    
    
    
}



- (BOOL)isOverlap:(NSRange)range1 otherRange:(NSRange )range2
{
    if(range1.length == 0 || range2.length == 0)
    {
        return false;
    }
    
    NSInteger begin1 = range1.location;
    NSInteger end1 = beigin1+range1.length;
    
    NSInteger begin2 = range2.location;
    NSInteger end2 = beigin2+range1.length;
    
    if(begin2 >= begin1 && begen2 <= end1 )
    {
        return true;
    }
    else if(end2 >= begin1 && end2 <= end1)
    {
        return true;
    }
    
    return false;
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
    
    //set value
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
//    NSMutableArray *re = [NSMutableArray new];
    NSMutableDictionary<NSString*, NSMutableArray<NSString *>*> *dic = [NSMutableDictionary new];
    
    for (NSString *s in array) {
        NSString *newS = [self getKey:s];
        if (dic[newS] == nil)
        {
            dic[newS] = [NSMutableArray new];
        }
        
        [dic[newS] addObject:s];

    }
//    dic.allValues
//    for (NSMutableArray *list in [dic allValues]) //!! allValues
//    {
//        [re addObject:list];
//    }
    return [[dic allValues] mutableCopy];
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


-(void)setupPhonePad:(NSMutableDictionary *)dicNum charDic:(NSMutableDictionary *)dicChar
{
    
    NSArray *counts = @[@0,@3,@3,@3,@3,@3,@4,@3,@4];
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
    
}



//- (NSMutableArray *)getCharacterArraysWithStr:(NSString *)str dicNum:(NSMutableDictionary *)dicNum charDic:(NSMutableDictionary *)dicChar
//{
//    NSMutableArray *result = [NSMutableArray new];
//    for (NSInteger i=0; i<str.length; i++) {
//        char curC = [str characterAtIndex:i];
//        NSString *curS = [NSString stringWithFormat:@"%c", curC];
//        NSString *curN = dicChar[curS];
//        NSArray *curA = dicNum[curN];
//        [result addObject:curA];
//    }
//    return result;
//}
//



//method 1
-(NSArray *)getArraysWithInputs:(NSString *)str
{
    NSMutableDictionary *dicNum = [NSMutableDictionary new];//dicNum[1] = @"1,a,b,c"
    NSMutableDictionary *dicChar = [NSMutableDictionary new];//dicChar[a] = 1
   
    [self setupPhonePad:dicNum charDic:dicChar];
    
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



#pragma mark - number question 2
/*
 
  Given a number e.g. 234, print all combinations of their   dial pad letters e.g. &#034;adg&#034;, &#034;adh&#034;, &#034;adi&#034;, &#034;aeg&#034;, &#034;aeh&#034;, &#034;aei&#034;..
 
 */


- (void)testCombinationPadString
{
    NSString *str = @"1";
    NSString *str2 =  @"12";
    NSString *str3 =  @"123";
    NSString *str4 = @"926";
    
    NSArray *arr1 = [NSMutableArray new];
//    arr1 = [self getArraysWithInputs2:str];
//    arr1 = [self getArraysWithInputs2:str2];
//    arr1 = [self getArraysWithInputs2:str3];
//    arr1 = [self getArraysWithInputs2:str4];
    
    arr1 = [self getArraysWithInputs3:str4];
    
}


-(NSArray *)getArraysWithInputs2:(NSString *)str
{
    NSMutableArray *result = [NSMutableArray new];
    NSArray *padArray = [self getPhonePadArray];
    result = [self combinationString:str index:0 subArray:result padArr:padArray];
    return [result copy];
}


- (NSMutableArray *)combinationString:(NSString *)str index:(NSInteger)index subArray:(NSMutableArray *)arr padArr:(NSArray *)pad
{
    if (index >= str.length) {
        return arr;
    }
    
    NSInteger n = [str characterAtIndex:index] - '0';
    NSArray *padChars = [pad objectAtIndex:n];
    
    if (!arr.count) {
        arr = [NSMutableArray arrayWithArray:padChars];
    }
    else
    {
        NSMutableArray *tempArr = [arr mutableCopy];
        [arr removeAllObjects];
        for (NSInteger i=0; i<padChars.count; i++) {
            NSString *strN = [padChars objectAtIndex:i];
            for (NSMutableString *strT in tempArr) {
                NSMutableString *tempS = [NSMutableString stringWithFormat:@"%@%@",strT,strN];
                [arr addObject:tempS];
            }
        }
    }
    return [self combinationString:str index:index+1 subArray:arr padArr:pad];
}




-(NSArray *)getPhonePadArray
{
    NSArray *numPadCharsLookup = @[@[],
                                   @[],
                                   @[@"a", @"b", @"c"],
                                   @[@"d", @"e", @"f"],
                                   @[@"g", @"h", @"i"],
                                   @[@"j", @"k", @"l"],
                                   @[@"m", @"n", @"o"],
                                   @[@"p", @"q", @"r", @"s"],
                                   @[@"t", @"u", @"v"],
                                   @[@"w", @"x", @"y", @"z"]];
    return numPadCharsLookup;
}


//more solution  - string
-(NSArray *)getArraysWithInputs3:(NSString *)str
{
    NSMutableArray *result = [NSMutableArray new];
    NSArray *padArray = [self getPhonePadString];
    result = [self combinationString2:str index:0 subArray:result padArr:padArray];
    return [result copy];
}

- (NSMutableArray *)stringToList:(NSString *)str
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSInteger i=0; i<str.length; i++) {
        NSString *t = [NSString stringWithFormat:@"%c", [str characterAtIndex:i]];
        [arr addObject:t];
    }
    return arr;
}

- (NSMutableArray *)combinationString2:(NSString *)str index:(NSInteger)index subArray:(NSMutableArray *)arr padArr:(NSArray *)pad
{
    if (index >= str.length) {
        return arr;
    }
    
    NSInteger currentN = [str characterAtIndex:index] - '0';
    NSString *currentNumber = [pad objectAtIndex:currentN];
    if (!arr.count) {
        arr = [self stringToList:currentNumber];//[[currentNumber componentsSeparatedByString:@""] mutableCopy];
    }
    else
    {
        NSMutableArray *tempArr = [arr mutableCopy];
        [arr removeAllObjects];
        for (NSString *str in tempArr) {
            for(NSInteger i = 0; i<currentNumber.length; i++)
            {
                NSString *cStr = [NSString stringWithFormat:@"%@%c",str, [currentNumber characterAtIndex:i]];
                [arr addObject:cStr];
            }
        }
    }
    return [self combinationString2:str index:index+1 subArray:arr padArr:pad];
}

//-(NSArray *)stringToA
- (NSArray *)getPhonePadString
{
    NSArray *arr = @[@"", @"", @"abc", @"def", @"ghi", @"jkl", @"mno", @"pqrs", @"tuv", @"wxyz"];
    
    return arr;
}



#pragma mark - array
-(void)testArray
{
    NSArray *array = @[ @1, @0, @2, @0, @0, @3, @4];
    NSInteger number = [self getNonZeroNumbers:array];
    NSMutableArray *mutArray = [array mutableCopy];
    [self moveZeroToEnd:mutArray];
    
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
        
        while ([array[j] integerValue] == 0 ) {
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
    
    NSString *words = @"abb abbd abb bdsf bbs dd bbs abb";
    NSArray *ws = [words componentsSeparatedByString:@" "];
    NSMutableArray *re = [ws mutableCopy];
    [self removeDuWords2:re];
    
    NSLog(@"%ld", [muA count]);
}


-(void)removeDuWords2:(NSMutableArray *)array
{
    NSMutableSet *newArray = [NSMutableSet new];
    for (NSInteger i = 0; i<array.count; i++) {
        if ([newArray containsObject:array[i]]) {
            [array removeObjectAtIndex:i];
            i--;
        }
        [newArray addObject:array[i]];
    }
}


//words 1
-(void)removeDuWords:(NSMutableArray *)array
{
    //sort
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return obj1 < obj2 ? NSOrderedAscending : NSOrderedDescending;//从小到大
    }];
    
    
    for (NSInteger i=1; i<array.count; i++) {
        if([array[i] isEqualToString:array[i-1]])
        {
            [array removeObjectAtIndex:i-1];
            i--;
        }
    }
}


//remove duplicata numbers
- (void)removeDuplicate:(NSMutableArray *)array
{
    //sort
//    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue] ? NSOrderedAscending : NSOrderedDescending;//从小到大
//    }];
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

- (void)removeDuplicate2:(NSMutableArray *)array
{
//    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        if ([(NSNumber *)obj1 integerValue] < [(NSNumber *)obj2 integerValue]) {
//            return NSOrderedAscending;
//        }
//        
//        return NSOrderedDescending;
//    }];
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return obj1 < obj2 ? NSOrderedAscending : NSOrderedDescending;//从小到大
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








// 2 5 1 2 3 - 1 2 3 - re: 3

-(NSUInteger) longestSubsequence:(NSArray *)input{
    NSUInteger maxValue = 0;
    NSInteger lengthI = input.count;
    NSInteger dp[lengthI];
    dp[0] = 0;
    for(NSInteger i=1; i<input.count; i++)
    {
        if([input[i] integerValue] -[input[i-1] integerValue]== 1)
        {
            dp[i] = dp[i-1]+1;
            maxValue = MAX(dp[i], maxValue);
        }
        else
        {
            dp[i] = 0;
        }
    }
    return maxValue;//dp[lengthI-1];
}

-(void)testlong222
{
    NSArray *array = @[@(1), @(2), @(3), @(5), @(7)];
    NSInteger re =[self longestSubsequence2:array];
}

-(NSUInteger) longestSubsequence2:(NSArray *)input{
    NSUInteger maxValue = 0;
//    NSInteger lengthI = input.count;
    // NSInteger dp[lengthI];
    NSInteger startPoint = 0;
//    dp[0] = 0;
    for(NSInteger i=1; i<input.count; i++)
    {
        if([input[i] integerValue] - [input[i-1] integerValue] == 1)
        {
            // dp[i] = dp[i-1]+1;
            NSInteger currentLength = i - startPoint + 1;
            maxValue = MAX(currentLength, maxValue);
        }
        else
        {
            // dp[i] = 0;
            startPoint = i;
        }
    }
    return maxValue;
}






#pragma mark - helper
-(TreeNode *)getSampleTree
{
    TreeNode *root = [[TreeNode alloc] init:5];
    TreeNode *left = [[TreeNode alloc] init:3];
    TreeNode *right = [[TreeNode alloc] init:7];
    TreeNode *leftl = [[TreeNode alloc] init:2];
    TreeNode *leftr = [[TreeNode alloc] init:4];
    TreeNode *leftll = [[TreeNode alloc] init:1];
    root.left = left;
    root.right = right;
    left.left = leftl;
    left.right = leftr;
    leftl.left = leftll;
    return root;
}



-(LinkNode *)getSampleNodeList
{
    LinkNode *n1 = [LinkNode linkNodeWithVal:1];//[[LinkNode alloc] init:1];
    LinkNode *n2 = [LinkNode linkNodeWithVal:2];//[[LinkNode alloc] init:2];
    LinkNode *n3 = [LinkNode linkNodeWithVal:3];
    LinkNode *n4 = [LinkNode linkNodeWithVal:4];
    LinkNode *n5 = [LinkNode linkNodeWithVal:5];
    n1.next = n2;
    n2.next = n3;
    n3.next = n4;
    n4.next = n5;
    return n1;
}



@end
