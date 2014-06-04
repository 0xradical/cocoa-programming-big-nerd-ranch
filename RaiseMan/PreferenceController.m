//
//  PreferenceController.m
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "PreferenceController.h"

@interface PreferenceController ()

@end

@implementation PreferenceController


- (instancetype)init
{
    // super is still self
    // but starts the method search in super class
    // initWithWindowNibName: sets the File's Owner
    // to the receiver, which is preferenceController
    self = [super initWithWindowNibName:@"Preferences"];
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    NSLog(@"Nib file is loaded");
}

- (IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [[self colorWell] color];
    NSLog(@"Color changed: %@", color);
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [[self checkBox] state];
    NSLog(@"Checkbox changed: %ld", state);
}

@end
