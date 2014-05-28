//
//  RandomController.m
//  Random
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "RandomController.h"

@implementation RandomController

#pragma mark - Actions

- (IBAction)generate:(id)sender
{
    int generated = (int)(random() % 100) + 1;
    
    NSLog(@"generated = %d", generated);
    
    [self.textField setIntValue:generated];
}

- (IBAction)seed:(id)sender
{
    srandom((unsigned)time(NULL));
    
    [self.textField setStringValue:@"Generator seeded!"];
}

#pragma mark - Callbacks

- (void)awakeFromNib
{
    NSDate *now = [NSDate date];
    
    [self.textField setObjectValue:now];
}

@end
