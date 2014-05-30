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
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

- (IBAction)createEmployee:(id)sender
{
    NSWindow *w = [_tableView window];
    
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
    
    Person *employee = [_employeeController newObject];
    
    [_employeeController addObject:employee];
    
    [_employeeController rearrangeObjects];
    
    NSArray *a = [_employeeController arrangedObjects];
    
    NSUInteger row = [a indexOfObjectIdenticalTo:employee];
    
    NSLog(@"Starting edit of %@ in row %lu", employee, row);
    
    [_tableView editColumn:0
                       row:row
                 withEvent:nil
                    select:YES];
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

@end
