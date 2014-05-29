//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpeakLineAppDelegate : NSObject <NSApplicationDelegate,NSSpeechSynthesizerDelegate>
{
    NSSpeechSynthesizer *_speechSynthesizer;
    NSArray *_voices;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSButton *speakButton;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)stopIt:(id)sender;
- (IBAction)sayIt:(id)sender;



@end
