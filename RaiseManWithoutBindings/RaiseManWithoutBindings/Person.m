//
//  Person.m
//  RaiseManWithoutBindings
//
//  Created by thiago on 5/29/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setExpectedRaise:0.05];
        [self setPersonName:@"New Person"];
    }
    
    return self;
}

- (void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"expectedRaise"]) {
        [self setExpectedRaise:0.0];
    } else {
        [super setNilValueForKey:key];
    }
}


@end
