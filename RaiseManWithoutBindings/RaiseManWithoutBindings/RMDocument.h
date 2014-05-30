//
//  RMDocument.h
//  RaiseManWithoutBindings
//
//  Created by thiago on 5/29/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RMDocument : NSDocument <NSTableViewDataSource>

@property (nonatomic, copy) NSMutableArray *employees;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)createEmployee:(id)sender;
- (IBAction)deleteSelectedEmployees:(id)sender;

@end
