//
//  MyDocument.m
//  CarLot
//
//  Created by thiago on 6/2/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (IBAction)createCar:(id)sender
{
    NSWindow *w = [[self tableView] window];
    
    BOOL editingEnded = [w makeFirstResponder:w];
    
    if (!editingEnded) {
        NSLog(@"Unable to end editing");
        return;
    }
    
    NSUndoManager *undo = [self undoManager];
    
    if ([undo groupingLevel] > 0) {
        [undo endUndoGrouping];
        [undo beginUndoGrouping];
    }
    
    id car = [[self CarArrayController] newObject];
    
    [[self CarArrayController] addObject:car];
    
    [[self CarArrayController] rearrangeObjects];
    
    NSArray *a = [[self CarArrayController] arrangedObjects];
    
    NSUInteger row = [a indexOfObjectIdenticalTo:car];
    
    NSLog(@"Starting edit of %@ in row %lu", car, row);
    
   [[self tableView] editColumn:0
                            row:row
                      withEvent:nil
                         select:YES];
    
}
@end
