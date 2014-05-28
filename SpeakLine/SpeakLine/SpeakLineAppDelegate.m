//
//  SpeakLineAppDelegate.m
//  SpeakLine
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "SpeakLineAppDelegate.h"

@implementation SpeakLineAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (id)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"init");
        
        _speechSynthesizer = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
    }
    
    return self;
}


- (IBAction)stopIt:(id)sender
{
    NSLog(@"stopping");
    
    [_speechSynthesizer stopSpeaking];
}

- (IBAction)sayIt:(id)sender
{
    NSString *string = [self.textField stringValue];
    
    if ([string length] == 0) {
        NSLog(@"string %@ is of zero length", self.textField);
    }
    
    [_speechSynthesizer startSpeakingString:string];
    
    NSLog(@"Have started to say: %@", string);
}
@end
