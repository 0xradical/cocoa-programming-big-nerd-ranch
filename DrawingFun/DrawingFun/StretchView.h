//
//  StretchView.h
//  DrawingFun
//
//  Created by thiago on 6/11/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StretchView : NSView

@property (nonatomic) NSBezierPath *path;

- (NSPoint)randomPoint;

@end
