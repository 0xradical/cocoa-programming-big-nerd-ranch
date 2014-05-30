//
//  RMDocument.m
//  RaiseManWithoutBindings
//
//  Created by thiago on 5/29/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import "RMDocument.h"
#import "Person.h"

@implementation RMDocument

- (id)init
{
    self = [super init];
    if (self) {
        _employees = [NSMutableArray array];
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

#pragma mark - Action methods

- (IBAction)createEmployee:(id)sender
{
    Person *newEmployee = [[Person alloc] init];
    
    [_employees addObject:newEmployee];
    [_tableView reloadData];
}

- (IBAction)deleteSelectedEmployees:(id)sender
{
    NSIndexSet *rows = [_tableView selectedRowIndexes];
    
    if ([rows count] == 0) {
        NSBeep();
        return;
    }
    
    [_employees removeObjectsAtIndexes:rows];
    [_tableView reloadData];
}

#pragma mark - Table View DataSource protocol methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [_employees count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *identifier = [tableColumn identifier];
    
    Person *employee = [_employees objectAtIndex:row];
    
    return [employee valueForKey:identifier];
    
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *identifier = [tableColumn identifier];
    
    Person *employee = [_employees objectAtIndex:row];
    
    return [employee setValue:object forKey:identifier];
}

- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors
{
    NSArray *newDescriptors = [tableView sortDescriptors];
    [_employees sortUsingDescriptors:newDescriptors];
    [_tableView reloadData];
}

#pragma mark - Awake from NIB

- (void)awakeFromNib
{
    NSTableColumn *tableColumn;
    
    tableColumn = [_tableView tableColumnWithIdentifier:@"personName"];
    
    NSSortDescriptor *personNameSortDescriptor
    = [NSSortDescriptor sortDescriptorWithKey:@"personName"
                                    ascending:YES
                                     selector:@selector(caseInsensitiveCompare:)];
    
    [tableColumn setSortDescriptorPrototype:personNameSortDescriptor];
    
    tableColumn = [_tableView tableColumnWithIdentifier:@"expectedRaise"];
    
    NSSortDescriptor *expectedRaiseSortDescriptor
    = [NSSortDescriptor sortDescriptorWithKey:@"expectedRaise"
                                    ascending:YES
                                     selector:@selector(compare:)];
    
    [tableColumn setSortDescriptorPrototype:expectedRaiseSortDescriptor];

}

@end
