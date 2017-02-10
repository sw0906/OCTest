//
//  GraphTest.m
//  OCTest
//
//  Created by admin on 19/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "GraphTest.h"

@implementation UndirectedGraphNode

+(id)nodeWithVal:(NSNumber *)val
{
    return [[self alloc] initWithVal:val];
}

-(id)initWithVal:(NSNumber *)val
{
    if (self = [super init]) {
        self.val = val;
    }
    return self;
}
@end



@implementation GraphTest
-(void)testGraph
{
    [self testConnect];
}




#pragma mark -  Find the Connected Component in the Undirected Graph
- (void)testConnect
{
    //    1 - 2,3,7
    //    3 - 7
    //    4 - 5
    UndirectedGraphNode *n1, *n2, *n3, *n4, *n5, *n6, *n7;
    n1 = [UndirectedGraphNode nodeWithVal:@(1)];
    n2 = [UndirectedGraphNode nodeWithVal:@(2)];
    n3 = [UndirectedGraphNode nodeWithVal:@(3)];
    n4 = [UndirectedGraphNode nodeWithVal:@(4)];
    n5 = [UndirectedGraphNode nodeWithVal:@(5)];
    n6 = [UndirectedGraphNode nodeWithVal:@(6)];
    n7 = [UndirectedGraphNode nodeWithVal:@(7)];
    
    n1.neighbours = @[n2, n3];
    n2.neighbours = @[n1];
    n3.neighbours = @[n1,n7];
    n7.neighbours = @[n3];
    
    n4.neighbours = @[n5];
    n5.neighbours = @[n4];
    
    
    
    NSArray *array = @[n1,n2,n4,n3,n5, n6];
    
    NSMutableArray *result = [self connectedSet:array];
}


//Find the number connected component in the undirected graph. Each node in the graph contains a label and a list of its neighbors. (a connected component (or just component) of an undirected graph is a subgraph in which any two vertices are connected to each other by paths, and which is connected to no additional vertices in the supergraph.)
//vector<vector<int>> connectedSet(vector<UndirectedGraphNode*>& nodes) {






- (NSMutableArray *)connectedSet:(NSArray<UndirectedGraphNode *> *) nodes
{
    NSMutableArray *result = [NSMutableArray new];
    NSMutableSet *set = [NSMutableSet new];
    for (UndirectedGraphNode *node in nodes) {
        if ([set containsObject:node]) {
            continue;
        }
        
        NSMutableSet *sub = [NSMutableSet new];
        [self getAllConnectedNodes:node subList:sub];
        [result addObject:[sub allObjects]];
        [set addObjectsFromArray:[sub allObjects]];
    }
    return result;
}

-(void)getAllConnectedNodes:(UndirectedGraphNode *)node subList:(NSMutableSet *)list
{
    if ([list containsObject:node]) {
        return;
    }
    
    [list addObject:node];
    
    for (UndirectedGraphNode *n in node.neighbours) {
        [self getAllConnectedNodes:n subList:list];
    }
}

@end
