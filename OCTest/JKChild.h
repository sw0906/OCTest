//
//  JKChild.h
//  OCTest
//
//  Created by shou wei on 06/02/17.
//  Copyright © 2017年 admin. All rights reserved.
//

//  JKChild.h

#import <Foundation/Foundation.h>

@interface JKChild : NSObject

@property(nonatomic, assign) NSInteger happyVal;

@end





#import <Foundation/Foundation.h>
@interface JKNurse : NSObject

@property(nonatomic, retain) JKChild *child;

- (id)initWithChild:(JKChild *)child;

@end
