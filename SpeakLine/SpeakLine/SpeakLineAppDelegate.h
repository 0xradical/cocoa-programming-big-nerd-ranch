//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// From the big nerd ranch forums:
//3) In the case of this challenge, advertising that TodoController conforms to the protocol is unnecessary, but helpful. Unnecessary because Interface Builder doesn't presently check outlet protocol conformance when making connections, helpful because if you use it, you can autocomplete the protocol methods in the implementation. For example, in a class that advertises its conformance to NSTableViewDataSource, try typing "- t" and the autocomplete will include matching protocol methods in the list. A convenient (and safe) alternative to copying the method declaration by hand.
// http://forums.bignerdranch.com/viewtopic.php?f=178&t=3221&start=10
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
