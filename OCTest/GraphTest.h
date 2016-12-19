//
//  GraphTest.h
//  OCTest
//
//  Created by admin on 19/12/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UndirectedGraphNode : NSObject

@property (nonatomic, strong) NSNumber *val;
@property (nonatomic, strong) NSArray<UndirectedGraphNode *> *neighbours;

+(id)nodeWithVal:(NSNumber *)val;

@end




//* struct UndirectedGraphNode {
//    *     int label;
//    *     vector<UndirectedGraphNode *> neighbors;
//    *     UndirectedGraphNode(int x) : label(x) {};
//    * };


@interface GraphTest : NSObject
-(void)testGraph;
@end
