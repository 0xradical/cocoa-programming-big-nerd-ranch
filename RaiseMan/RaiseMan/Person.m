//
//  Person.m
//  RaiseMan
//
//  Created by thiago on 5/29/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark - Designated initializer

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setExpectedRaise:0.05];
        [self setPersonName:@"New Person"];
    }
    
    return self;
}

#pragma mark - KVC

- (void)setNilValueForKey:(NSString *)key
{
    if ([key isEqualToString:@"expectedRaise"]) {
        [self setExpectedRaise:0.0];
    } else {
        [super setNilValueForKey:key];
    }
}


#pragma mark - NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self personName]
                  forKey:@"personName"];
    
    [aCoder encodeFloat:[self expectedRaise]
                 forKey:@"expectedRaise"];
}

// initWithCoder is an exception to the rule
// which states that every non-designated initializer
// should call designated initializer in its code
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        [self setPersonName:[aDecoder decodeObjectForKey:@"personName"]];
        
        [self setExpectedRaise:[aDecoder decodeFloatForKey:@"expectedRaise"]];
    }
    
    return self;
}

@end
