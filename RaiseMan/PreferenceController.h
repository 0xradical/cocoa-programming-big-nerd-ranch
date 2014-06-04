//
//  PreferenceController.h
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController

@property (nonatomic) IBOutlet NSColorWell *colorWell;
@property (nonatomic) IBOutlet NSButton *checkBox;

- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;

@end
