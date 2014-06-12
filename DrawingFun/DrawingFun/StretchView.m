//
//  StretchView.m
//  DrawingFun
//
//  Created by thiago on 6/11/14.
//  Copyright (c) 2014 bignerdranch. All rights reserved.
//

// Bezier curves: http://pomax.github.io/bezierinfo/

#import "StretchView.h"

@implementation StretchView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        srandom((unsigned)time(NULL));
       
        [self setPath:[NSBezierPath bezierPath]];
        
        [[self path] setLineWidth:3.0];
        
        NSPoint pc1, pc2, p;
        
        p = [self randomPoint];
        
        [[self path] moveToPoint:p];
        
        for (int i = 0; i < 15; i++) {
            p = [self randomPoint];
            pc1 = [self randomPoint];
            pc2 = [self randomPoint];
            
            [[self path] curveToPoint:p
                        controlPoint1:pc1
                        controlPoint2:pc2];
        }
        
        [[self path] closePath];
        
    }
    return self;
}

- (NSPoint)randomPoint
{
    NSPoint result;
    
    NSRect r = [self bounds];
    
    result.x = r.origin.x + random() % (int)r.size.width;
    result.y = r.origin.y + random() % (int)r.size.height;
    
    return result;
}


- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    
    [[NSColor greenColor] set];
    
    [NSBezierPath fillRect:bounds];
    
    [[NSColor whiteColor] set];
    
    [[self path] stroke];
}


@end
