//
//  OGMHypnosisView.m
//  Hypnosister
//
//  Created by Omri Meshulam on 2/17/15.
//  Copyright (c) 2015 OmriMeshulam. All rights reserved.
//

#import "OGMHypnosisView.h"

@implementation OGMHypnosisView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        // All the OGMHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    
    // Figuring out the center bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    
    // Instances of this class define and draw lines and curves
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)]; // lifting the paths pencil
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:2.0*M_PI clockwise:YES]; // drawing the next circle
    }
    
    // Configure line width to 10 points
    path.lineWidth = 10;
    
    // Configure the drawing color to light gray
    // Need UIColor as UIBezierPath can't set by itself, they are linked
    [[UIColor lightGrayColor] setStroke];
    
    // Drawing the line
    [path stroke];
    
    UIImage *logoImage = [UIImage imageNamed:@"matrix.png"];
    [logoImage drawInRect:rect];
    
}


@end
