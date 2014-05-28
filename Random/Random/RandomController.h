//
//  RandomController.h
//  Random
//
//  Created by thiago on 5/28/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomController : NSObject

@property (nonatomic) IBOutlet NSTextField *textField;

- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;

@end
