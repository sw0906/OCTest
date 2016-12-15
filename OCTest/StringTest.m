//
//  StringTest.m
//  OCTest
//
//  Created by shou wei on 11/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "StringTest.h"

@implementation StringTest

-(void)testString
{
//    [self testStr];
//    [self testRotate];
//    [self testPermu];
//    [self tesLongPali];
    [self testCompareStr];
}




#pragma mark -  Compare Strings
- (void)testCompareStr
{
//    BOOL value1 = [self compareStrings:@"AABCC" withB:@"ACBD"];
//    BOOL value2 = [self compareStrings:@"BCCCD" withB:@"ACBD"];
//    BOOL value3 = [self compareStrings:@"ACBDD" withB:@"DCB"];
    BOOL value4 = [self compareStrings:@"ACBDD" withB:@"ADBD"];
    NSString *v = value4 ? @"Yes" : @"No";
    NSLog(@"%@", v);
    
}


//Example
//For A = "ABCD", B = "ACD", return true.
//For A = "ABCD", B = "AABC", return false.
//bool compareStrings(string A, string B) {

-(BOOL) compareStrings:(NSString *)a withB:(NSString *)b
{
    if(a.length < b.length)
        return false;
    
    int flags[26];
    for(int i=0; i<26; i++)
    {
        flags[i] = 0;
    }
    
    for(NSInteger i=0; i<a.length; i++)
    {
        char curC = [a characterAtIndex:i];
        int i = curC - 'A';
        flags[i] += 1;
    }
    
    for(NSInteger i=0; i<b.length; i++)
    {
        char curC = [b characterAtIndex:i];
        int i = curC - 'A';
        flags[i] -= 1;
        if(flags[i] < 0)
        {
            return false;
        }
    }
    return true;
}



#pragma mark - Longest Common Prefix
-(void)testLongCommonPrefix
{
    NSArray *array = @[@"abssss", @"abssbbbb", @"absqefef", @"absqe"];
    NSString *re = [self longestCommonPrefix:array];
    NSLog(@"%@", re);
}

//Example
//For strings "ABCD", "ABEF" and "ACEF", the LCP is "A"
//For strings "ABCDEFG", "ABCEFG" and "ABCEFA", the LCP is "ABC"
//string longestCommonPrefix(vector<string> &strs) {
-(NSString *)longestCommonPrefix:(NSArray<NSString *> *)array
{
    if([array count] == 0)
        return nil;
    else if([array count] == 1)
        return array[0];
    
    
    NSInteger shortestLength = INT_MAX;
    for (NSString *s in array) {
        shortestLength = MIN(shortestLength, s.length);
    }
    
    NSString *tmpS = array[0];
    for(NSInteger j=0; j<shortestLength; j++)
    {
        char curC = [tmpS characterAtIndex:j];
        for (NSInteger i=1; i<array.count; i++)
        {
            NSString *compareS  = array[i];
            char compareC = [compareS characterAtIndex:j];
            if(curC != compareC)
                return [tmpS substringWithRange:NSMakeRange(0,j)];
        }
    }
    
    return nil;
}

#pragma mark -  Longest Palindromic Substring

- (void)tesLongPali
{
    NSString *s1 = @"abcdzdcab";
    [self longestPalindrome:s1];
}

//Example
//Given the string = "abcdzdcab", return "cdzdc".
//string longestPalindrome(string& s) {

-(NSString *)longestPalindrome:(NSString *)s
{
    NSInteger maxCount = 0;
    NSInteger po_start = 0, po_end = s.length-1;
    
    for (NSInteger i=0; i<s.length; i++) {
        NSInteger backIndex = 0;
        while ([s characterAtIndex:i] != [s characterAtIndex:s.length-1-backIndex]) {
            backIndex++;
        }
        po_start = i;
        po_end = s.length - 1 - backIndex;
        
        
        NSInteger start = i;
        while ([s characterAtIndex:start] == [s characterAtIndex:s.length-1-backIndex]) {
            start++;
            backIndex++;
        }
        if ( start >= s.length-1-backIndex ) {
            maxCount = po_end - po_start + 1;
            NSString *result = [s substringWithRange:NSMakeRange(po_start, maxCount)];
            return result;
        }
        
    }
    return [s substringToIndex:1];
}


#pragma mark -  String Permutation II

-(void)testPermu
{
    NSString *str = @"abb";
    NSArray *re = [self stringPermutation2:str];
    NSLog(@"%ld", re.count);
}

//Example
//Given "abb", return ["abb", "bab", "bba"].
//
//Given "aabb", return ["aabb", "abab", "baba", "bbaa", "abba", "baab"].
//vector<string> stringPermutation2(string& str) {
- (NSArray *)stringPermutation2:(NSString *)str
{
    NSMutableSet *result = [NSMutableSet new];
    NSMutableSet<NSNumber *> *hash = [NSMutableSet new];
    
    [self permuHleper:[NSMutableString new] withStr:str withHash:hash withResult:result];
    
    return [result allObjects];
}

-(void)permuHleper:(NSMutableString *)subStr withStr:(NSString *)str withHash:(NSMutableSet *)hash withResult:(NSMutableSet *)result
{
    if (subStr.length == str.length) {
        [result addObject:subStr];
        return;
    }
    
    for (int i = 0; i<str.length; i++) {
        if (![hash containsObject:@(i)]) {
            NSString *newStr = [subStr stringByAppendingFormat:@"%c", [str characterAtIndex:i]];
            [hash addObject:@(i)];
            [self permuHleper:[NSMutableString stringWithString:newStr] withStr:str withHash:hash withResult:result];
            [hash removeObject:@(i)];
        }
    }
}

#pragma mark -  Sort Letters by Case
-(void)testSort
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", @"abdddEESFsfBe"];
    [self sortLetters:str];
}


//For "abAcD", a reasonable answer is "acbAD"
- (void)sortLetters:(NSMutableString *)letters
{
    NSString *uppCase = [letters uppercaseString];
    
    for (int i=0; i<letters.length; i++) {
        char c = [letters characterAtIndex:i];
        char c_up = [uppCase characterAtIndex:i];
        if ( c != c_up ) {
            [letters deleteCharactersInRange:NSMakeRange(i, 1)];
            [letters insertString:[NSString stringWithFormat:@"%c", c] atIndex:0];
        }
    }
    NSLog(@"%@", letters);
}

#pragma mark - strStr

- (void)testStr
{
    NSString *s = @"source";
    NSString *t = @"target";
    NSString *s1 = @"adbsdfsfsffee";
    NSString *t1 = @"bsd";
    BOOL v1 = [self strStr:s withTarget:t];
    BOOL v2 = [self strStr:s1 withTarget:t1];
    BOOL v3 = [self strStr:s withTarget:t1];
    NSLog(@"test");
}

//Example
//If source = "source" and target = "target", return -1.
//If source = "abcdabcdefg" and target = "bcd", return 1.

- (BOOL)strStr:(NSString *)source withTarget:(NSString *)target
{
    if (target.length > source.length) {
        return false;
    }
    
    for(int i=0; i<= source.length - target.length; i++)
    {
        NSInteger endIndex = i + target.length - 1;
        if ([source characterAtIndex:i] == [target characterAtIndex:0] &&
            [source characterAtIndex:endIndex] == [target characterAtIndex:(target.length-1)])
        {
            int count =0;
            for (int j=i; j<=endIndex; j++) {
                if ([source characterAtIndex:j] == [target characterAtIndex:j-i]) {
                    count++;
                }
            }
            if (count == target.length) {
                return true;
            }
        }
    }
    return  false;
}

#pragma mark - Rotate String
-(void)testRotate
{
    NSString *str = @"abcdefg";
    [self rotateString:[NSMutableString stringWithString:str] withOffset:0];
    [self rotateString:[NSMutableString stringWithString:str] withOffset:2];
    [self rotateString:[NSMutableString stringWithString:str] withOffset:3];
    [self rotateString:[NSMutableString stringWithString:str] withOffset:4];
    [self rotateString:[NSMutableString stringWithString:str] withOffset:5];
    [self rotateString:[NSMutableString stringWithString:str] withOffset:9];
}

//Given "abcdefg".
//
//offset=0 => "abcdefg"
//offset=1 => "gabcdef"
//offset=2 => "fgabcde"
//offset=3 => "efgabcd"
// void rotateString(string &A,int offset){

- (void)rotateString:(NSMutableString *)A withOffset:(NSInteger)offset
{
    offset = offset % A.length;
    NSString *subStr = [A substringFromIndex:(A.length - offset)];
    [A deleteCharactersInRange:NSMakeRange(A.length-offset, offset)];
    [A insertString:subStr atIndex:0];
    NSLog(@"%@", A);
}

@end
