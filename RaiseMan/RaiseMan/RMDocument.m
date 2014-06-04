//
//  RMDocument.m
//  RaiseMan
//
//  Created by thiago on 5/29/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "RMDocument.h"
#import "Person.h"

// KVO Context for this class
static void *RMDocumentKVOContext;

@implementation RMDocument

- (id)init
{
    self = [super init];
    if (self) {
        _employees = [[NSMutableArray alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(handleColorChange:)
                   name:BNRColorChangedNotification
                 object:nil];
        
        NSLog(@"Registered with notification center");
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"RMDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    
    [[self tableView] setBackgroundColor:[PreferenceController preferenceTableBgColor]];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName
                 error:(NSError **)outError
{
    [[[self tableView] window] endEditingFor:nil];
    
    return [NSKeyedArchiver archivedDataWithRootObject:[self employees]];
}

- (BOOL)readFromData:(NSData *)data
              ofType:(NSString *)typeName
               error:(NSError **)outError
{
    NSLog(@"About to read data of type %@", typeName);
    
    NSMutableArray *newArray = nil;
    
    @try {
        newArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        NSLog(@"exception = %@", exception);
        if (outError) {
            NSDictionary *d = [NSDictionary dictionaryWithObject:@"The data is corrupted"
                                                          forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain
                                            code:unimpErr
                                        userInfo:d];
        }
        
        return NO;
    }
    
    [self setEmployees:newArray];
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)createEmployee:(id)sender
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
    
    Person *employee = [[self employeeController] newObject];
    
    [[self employeeController] addObject:employee];
    
    [[self employeeController] rearrangeObjects];
    
    NSArray *a = [[self employeeController] arrangedObjects];
    
    NSUInteger row = [a indexOfObjectIdenticalTo:employee];
    
    NSLog(@"Starting edit of %@ in row %lu", employee, row);
    
    [[self tableView] editColumn:0
                             row:row
                       withEvent:nil
                          select:YES];
}

 - (IBAction)removeEmployee:(id)sender
{
    NSArray *selectedPeople = [[self employeeController] selectedObjects];
    
    NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"REMOVE_MSG", @"Remove")
                                     defaultButton:NSLocalizedString(@"REMOVE", @"Remove")
                                   alternateButton:NSLocalizedString(@"CANCEL", @"Cancel")
                                       otherButton:NSLocalizedString(@"KEEP_NO_RAISE", @"Keep, but no raise")
                         informativeTextWithFormat:NSLocalizedString(@"REMOVE_INF",@"%lu people will be removed"), (unsigned long)[selectedPeople count]];
    
    // An alert sheet is an alert window
    // That appears atop of the current window
    // Within the window
    NSLog(@"Starting alert sheet");
    
    [alert beginSheetModalForWindow:[[self tableView] window]
                      modalDelegate:self
                     didEndSelector:@selector(alertEnded:code:context:)
                        contextInfo:NULL];
}

- (void)alertEnded:(NSAlert *)alert
              code:(NSInteger)choice
           context:(void *)v
{
    NSLog(@"Alert sheet ended");
    
    if (choice == NSAlertDefaultReturn) {
        [[self employeeController] remove:nil];
    }

    if (choice == NSAlertOtherReturn) {
        for (Person *employee in [[self employeeController] selectedObjects]) {
            [employee setValue:@0.0 forKey:@"expectedRaise"];
        }
    }
}


#pragma mark - KVC for employees

- (void)insertObject:(Person *)employee inEmployeesAtIndex:(NSUInteger)index
{
    NSLog(@"Adding %@ to %@", employee, _employees);
    
    NSUndoManager *undo = [self undoManager];
    
    [[undo prepareWithInvocationTarget:self] removeObjectFromEmployeesAtIndex:index];
    
    if (![undo isUndoing]) {
        [undo setActionName:@"Add Person"];
    }
    
    [self startObservingPerson:employee];
    [_employees insertObject:employee atIndex:index];
}

- (void)removeObjectFromEmployeesAtIndex:(NSUInteger)index
{
    Person *employee = [_employees objectAtIndex:index];
    
    NSLog(@"Removing %@ from %@", employee, _employees);
    
    NSUndoManager *undo = [self undoManager];
    
    [[undo prepareWithInvocationTarget:self] insertObject:employee
                                       inEmployeesAtIndex:index];
    
    if (![undo isUndoing]) {
        [undo setActionName:@"Remove Person"];
    }
    
    [self stopObservingPerson:employee];
    [_employees removeObjectAtIndex:index];
}

- (void)changeKeyPath:(NSString *)keyPath
             ofObject:(id)object
              toValue:(id)newValue
{
    [object setValue:newValue forKeyPath:keyPath];
}


#pragma mark - KVO

- (void)startObservingPerson:(Person *)person
{
    [person addObserver:self
             forKeyPath:@"personName"
                options:NSKeyValueObservingOptionOld
                context:&RMDocumentKVOContext];
    
    [person addObserver:self
             forKeyPath:@"expectedRaise"
                options:NSKeyValueObservingOptionOld
                context:&RMDocumentKVOContext];
}

- (void)stopObservingPerson:(Person *)person
{
    [person removeObserver:self
                forKeyPath:@"personName"
                   context:&RMDocumentKVOContext   ];

    [person removeObserver:self
                forKeyPath:@"expectedRaise"
                   context:&RMDocumentKVOContext   ];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != &RMDocumentKVOContext) {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
        
        return;
    }
    
    NSUndoManager *undo = [self undoManager];
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    
    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    
    NSLog(@"oldValue = %@", oldValue);
    
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath
                                                  ofObject:object
                                                   toValue:oldValue];
    
    [undo setActionName:@"Edit"];
}

#pragma mark - Setter

- (void)setEmployees:(NSMutableArray *)employees
{
    for (Person *person in _employees) {
        [self stopObservingPerson:person];
    }
    
    _employees = employees;
    
    for (Person *person in _employees) {
        [self startObservingPerson:person];
    }
}

#pragma mark - Notification methods

- (void)handleColorChange:(NSNotification *)notification
{
    NSLog(@"Received notification: %@", notification);
    NSColor *color = [[notification userInfo] valueForKey:@"color"];    
    [[self tableView] setBackgroundColor:color];
}

#pragma mark - Dealloc

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
