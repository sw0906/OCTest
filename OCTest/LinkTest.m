//
//  LinkTest.m
//  OCTest
//
//  Created by shou wei on 14/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LinkTest.h"

@implementation LinkTest

-(void)testLink
{
    [self testSwap];
}




#pragma mark - Swap Two Nodes in Linked List
-(void)testSwap
{
    LinkNode *head = [self getSampleNodeList];
    LinkNode *newlist = [self swapNodes:head withV1:2 withV2:4];
}

//Given a linked list and two values v1 and v2. Swap the two nodes in the linked list with values v1 and v2. It's guaranteed there is no duplicate values in the linked list. If v1 or v2 does not exist in the given linked list, do nothing.
//
//Notice
//
//You should swap the two nodes with values v1 and v2. Do not directly swap the values of the two nodes.
//
//Example
//Given 1->2->3->4->null and v1 = 2, v2 = 4.
//
//Return 1->4->3->2->null.

//ListNode* swapNodes(ListNode* head, int v1, int v2) {

-(LinkNode *)swapNodes:(LinkNode *)head withV1:(NSInteger)v1 withV2:(NSInteger)v2
{
    LinkNode *dummyNode = [LinkNode new];
    dummyNode.next = head;
    
    LinkNode *pre1 = [self findNodePre:dummyNode withV:v1];
    LinkNode *pre2 = [self findNodePre:dummyNode withV:v2];
    
    LinkNode *cur1 = pre1.next;
    LinkNode *cur2 = pre2.next;
    
    LinkNode *after1 = cur1.next;
    LinkNode *after2 = cur2.next;
    
    pre1.next = cur2;
    cur2.next = after1;
    
    pre2.next = cur1;
    cur1.next = after2;
    
    return dummyNode.next;
}

-(LinkNode *)findNodePre:(LinkNode *)head withV:(NSInteger)v
{
    LinkNode *dummyNode = head;
    while (dummyNode.next) {
        if (dummyNode.next.val == v) {
            return dummyNode;
        }
        dummyNode = dummyNode.next; // !!
    }
    return nil;
}

#pragma mark -
//reverse list
- (LinkNode *)reverseList:(LinkNode *)head
{
    LinkNode *preNode = [[LinkNode alloc] init:-1];
    LinkNode *nextNode = head;
    while (nextNode) {
        LinkNode *tmpNext = preNode.next; //nextNode.next;
        preNode.next = nextNode;
        nextNode = nextNode.next;
        preNode.next.next = tmpNext;
    }
    return preNode.next;
    
}

-(void)testReverseNode
{
    LinkNode *n1 = [LinkNode linkNodeWithVal:1];//[[LinkNode alloc] init:1];
    LinkNode *n2 = [LinkNode linkNodeWithVal:2];//[[LinkNode alloc] init:2];
    LinkNode *n3 = [LinkNode linkNodeWithVal:3];
    n1.next = n2;
    n2.next = n3;
    
    LinkNode *newHead = [self reverseList:n1];
    NSLog(@"re is %ld", newHead.val);
}



//removeDuplicate1
- (LinkNode *)removeDuplicate1:(LinkNode *)head//remove all
{
    LinkNode *preNode = [LinkNode linkNodeWithVal:-1];
    preNode.next = head;
    LinkNode *flagNode = preNode;
    
    while (preNode && preNode.next && preNode.next.next) {
        if(preNode && preNode.next && preNode.next.val == preNode.next.next.val)
        {
            NSInteger val = preNode.next.val;
            while (preNode && preNode.next && preNode.next.val == val) {
                preNode.next = preNode.next.next;
            }
        }
        preNode = preNode.next;
    }
    return flagNode.next;
}

//removeDuplicate2
- (LinkNode *)removeDuplicate2:(LinkNode *)head//remove all
{
    LinkNode *preNode = [LinkNode linkNodeWithVal:-1];
    preNode.next = head;
    LinkNode *flagNode = preNode;
    
    while (preNode && preNode.next ) {
        if(preNode.val == preNode.next.val )
        {
            NSInteger val = preNode.val;
            while (preNode && preNode.next && preNode.next.val == val) {
                preNode.next = preNode.next.next;
            }
        }
        preNode = preNode.next;
    }
    return flagNode.next;
}


-(void)testDuNode
{
    LinkNode *n0 = [LinkNode linkNodeWithVal:1];
    LinkNode *n1 = [LinkNode linkNodeWithVal:1];//[[LinkNode alloc] init:1];
    LinkNode *n2 = [LinkNode linkNodeWithVal:2];//[[LinkNode alloc] init:2];
    LinkNode *n3 = [LinkNode linkNodeWithVal:3];
    LinkNode *n4 = [LinkNode linkNodeWithVal:3];
    LinkNode *n5 = [LinkNode linkNodeWithVal:3];
    n0.next = n1;
    n1.next = n2;
    n2.next = n3;
    n3.next = n4;
    n4.next = n5;
    LinkNode *newHead = [self removeDuplicate2:n0];
    NSLog(@"re is %ld", newHead.val);
}

#pragma mark - 
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
