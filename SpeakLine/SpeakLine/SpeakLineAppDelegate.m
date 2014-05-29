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

#pragma mark - Initializer

- (id)init
{
    self = [super init];
    
    if (self) {
        NSLog(@"init");
        
        _speechSynthesizer = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
        [_speechSynthesizer setDelegate:self];
        
        _voices = [NSSpeechSynthesizer availableVoices];
    }
    
    return self;
}


#pragma mark - Data Source Informal Protocol

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    return (NSInteger)[_voices count];
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    NSString *v = [_voices objectAtIndex:row];
    NSDictionary *dict = [NSSpeechSynthesizer attributesForVoice:v];
    return dict[NSVoiceName];
}

#pragma mark - Delegation methods from TableView

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger row = [_tableView selectedRow];
    
    if (row == -1) {
        return;
    }
    
    NSString *selectedVoice = _voices[row];
    
    [_speechSynthesizer setVoice:selectedVoice];
    
    NSLog(@"new voice = %@", selectedVoice);
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
    
    [_stopButton setEnabled:YES];
    [_speakButton setEnabled:NO];
    [_tableView setEnabled:NO];
}

#pragma mark - Speech Synthesizer delegated methods

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
        didFinishSpeaking:(BOOL)finishedSpeaking
{
    NSLog(@"finishedSpeaking = %d", finishedSpeaking);
    
    [_stopButton setEnabled:NO];
    [_speakButton setEnabled:YES];
    [_tableView setEnabled:YES];
}

#pragma mark - Awake from NIB

- (void)awakeFromNib
{
    NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
    NSInteger defaultRow = [_voices indexOfObject:defaultVoice];
    NSIndexSet *indices = [NSIndexSet indexSetWithIndex:defaultRow];
    
    [_tableView selectRowIndexes:indices
          byExtendingSelection:NO];
    
    [_tableView scrollRowToVisible:defaultRow];
}
@end
