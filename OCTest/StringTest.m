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
    [self testPermu];
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
