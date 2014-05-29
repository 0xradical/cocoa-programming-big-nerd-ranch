//
//  KvcFunAppDelegate.m
//  KvcFun
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "KvcFunAppDelegate.h"

@implementation KvcFunAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

#pragma mark - Designated initializer

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setValue:[NSNumber numberWithInt:5]
                forKey:@"fido"];
        
        NSNumber *n = [self valueForKey:@"fido"];
        NSLog(@"fido = %@", n);
    }
    
    return self;
}

- (IBAction)incrementFido:(id)sender
{
    [self setFido:[self fido] + 1];
    NSLog(@"fido is now %d", [self fido]);
}

@end
