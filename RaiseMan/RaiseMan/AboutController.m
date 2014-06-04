//
//  AboutController.m
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (instancetype)init
{
    self = [super initWithWindowNibName:@"About"];
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    NSLog(@"Nib file is loaded");
    
}

@end
