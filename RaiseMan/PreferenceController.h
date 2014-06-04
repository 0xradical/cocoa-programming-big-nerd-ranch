//
//  PreferenceController.h
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Defaults for this App
extern NSString* const BNRTableBgColorKey;
extern NSString* const BNREmptyDocKey;

// Notification types
extern NSString* const BNRColorChangedNotification;

@interface PreferenceController : NSWindowController

@property (nonatomic) IBOutlet NSColorWell *colorWell;
@property (nonatomic) IBOutlet NSButton *checkBox;

- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (IBAction)resetPreferences:(id)sender;


+ (NSColor*)preferenceTableBgColor;
+ (void)setPreferenceTableBgColor:(NSColor*)color;
+ (BOOL)preferenceEmptyDoc;
+ (void)setPreferenceEmptyDoc:(BOOL)emptyDoc;

@end
