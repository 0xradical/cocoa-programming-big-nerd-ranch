//
//  AppController.h
//  RaiseMan
//
//  Created by thiago on 6/3/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PreferenceController;
@class AboutController;

@interface AppController : NSObject

@property (nonatomic) AboutController *aboutController;
@property (nonatomic) PreferenceController *preferenceController;

- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)showAboutPanel:(id)sender;

@end
