//
//  AppController.m
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"
#import "AboutController.h"

@implementation AppController

- (IBAction)showPreferencePanel:(id)sender
{
    if (![self preferenceController] ) {
        [self setPreferenceController:[[PreferenceController alloc] init]];
    }
    
    NSLog(@"Showing %@", [self preferenceController]);
    
    [[self preferenceController] showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
    if (![self aboutController]) {
        [self setAboutController:[[AboutController alloc] init]];
    }
    
    NSLog(@"Showing %@", [self aboutController]);
    
    [[self aboutController] showWindow:self];
}

@end
