//
//  CharacterCounterAppDelegate.h
//  CharacterCounter
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CharacterCounterAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *label;
@property (weak) IBOutlet NSTextField *textField;

- (IBAction)countCharacters:(id)sender;

@end
