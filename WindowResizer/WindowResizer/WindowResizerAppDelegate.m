//
//  WindowResizerAppDelegate.m
//  WindowResizer
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "WindowResizerAppDelegate.h"

@implementation WindowResizerAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (NSSize)windowWillResize:(NSWindow *)sender
                    toSize:(NSSize)frameSize
{
    NSSize mySize = NSMakeSize(frameSize.width, frameSize.width*2.0);
    
    NSLog(@"mySize is %f wide and %f tall", mySize.width, mySize.height);
    
    return mySize;
}

@end
