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

#pragma mark - Application Delegate protocol

// As always, delegates defined in XIBs are not required
// to mark a protocol conformance but I still do it
// to make Xcode do the autocomplete magic :)
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    NSLog(@"applicationShouldOpenUntitledFile:");
    
    return [PreferenceController preferenceEmptyDoc];
}


#pragma mark - Application Notifications

// When some object is a delegate, it also receives notifications
// for NotificationCenter, because the delegator automatically
// adds the delegate as an observer
// These methods makes part of the Application Delegate protocol as well
- (void)applicationDidResignActive:(NSNotification *)notification
{
    NSLog(@"Application resigned its active state");
    NSBeep();
}

@end
