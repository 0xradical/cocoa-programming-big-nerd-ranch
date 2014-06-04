//
//  PreferenceController.m
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "PreferenceController.h"

NSString* const BNRTableBgColorKey = @"BNRTableBackgroundColor";
NSString* const BNREmptyDocKey = @"BNREmptyDocumentFlag";

@implementation PreferenceController

#pragma mark - PreferenceController initializer
+ (void)initialize
{
    // Create a dictionary
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    // NSColor objects do not know how to write
    // themselves out as XML
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
    
    [defaultValues setObject:colorAsData
                      forKey:BNRTableBgColorKey];
    
    [defaultValues setObject:[NSNumber numberWithBool:YES]
                      forKey:BNREmptyDocKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
    NSLog(@"Registered defaults: %@", defaultValues);
}

#pragma mark - Designated initializer
- (instancetype)init
{
    // super is still self
    // but starts the method search in super class
    // initWithWindowNibName: sets the File's Owner
    // to the receiver, which is preferenceController
    self = [super initWithWindowNibName:@"Preferences"];
    
    return self;
}

#pragma mark - Delegated methods from the window
- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [[self colorWell] setColor:[PreferenceController preferenceTableBgColor]];
    [[self checkBox] setState:[PreferenceController preferenceEmptyDoc]];
}

#pragma mark - IBActions

- (IBAction)changeBackgroundColor:(id)sender
{
    NSColor *color = [[self colorWell] color];
    [PreferenceController setPreferenceTableBgColor:color];
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
    NSInteger state = [[self checkBox] state];
    [PreferenceController setPreferenceEmptyDoc:state];
}

- (IBAction)resetPreferences:(id)sender
{
    [PreferenceController setPreferenceTableBgColor:[NSColor blueColor]];
    [PreferenceController setPreferenceEmptyDoc:YES];

    [[self colorWell] setColor:[PreferenceController preferenceTableBgColor]];
    [[self checkBox] setState:[PreferenceController preferenceEmptyDoc]];
}

#pragma mark - User defaults methods

+ (NSColor*)preferenceTableBgColor
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *colorAsData = [defaults objectForKey:BNRTableBgColorKey];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

+ (void)setPreferenceTableBgColor:(NSColor *)color
{
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
    
    [[NSUserDefaults standardUserDefaults] setObject:colorAsData
                                              forKey:BNRTableBgColorKey];
}

+ (BOOL)preferenceEmptyDoc
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults boolForKey:BNREmptyDocKey];
}

+ (void)setPreferenceEmptyDoc:(BOOL)emptyDoc
{
    [[NSUserDefaults standardUserDefaults] setBool:emptyDoc
                                            forKey:BNREmptyDocKey];
}

@end
