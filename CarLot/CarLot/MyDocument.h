//
//  MyDocument.h
//  CarLot
//
//  Created by thiago on 6/2/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSPersistentDocument

@property (weak) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *CarArrayController;

- (IBAction)createCar:(id)sender;

@end
