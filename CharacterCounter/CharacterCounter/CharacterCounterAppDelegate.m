//
//  CharacterCounterAppDelegate.m
//  CharacterCounter
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "CharacterCounterAppDelegate.h"

@implementation CharacterCounterAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)countCharacters:(id)sender
{
    NSString *string = [self.textField stringValue];
    NSString *formattedString = [NSString stringWithFormat:@"'%@' has %lu characters!", string, (unsigned long)[string length]];

    [self.label setStringValue:formattedString];
}
@end
