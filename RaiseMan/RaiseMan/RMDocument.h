//
//  RMDocument.h
//  RaiseMan
//
//  Created by thiago on 5/29/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Person;

@interface RMDocument : NSDocument

@property (nonatomic) NSMutableArray *employees;

- (void)insertObject:(Person *)employee
  inEmployeesAtIndex:(NSUInteger)index;

- (void)removeObjectFromEmployeesAtIndex:(NSUInteger)index;

@end
