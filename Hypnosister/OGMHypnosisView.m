//
//  OGMHypnosisView.m
//  Hypnosister
//
//  Created by Omri Meshulam on 2/17/15.
//  Copyright (c) 2015 OmriMeshulam. All rights reserved.
//

#import "OGMHypnosisView.h"

@interface OGMHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation OGMHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        // All the OGMHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;

    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Figuring out the center bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    
    // Instances of this class define and draw lines and curves
    UIBezierPath *circlePath = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        
        [circlePath moveToPoint:CGPointMake(center.x + currentRadius, center.y)]; // lifting the paths pencil
        [circlePath addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:2.0*M_PI clockwise:YES]; // drawing the next circle
    }
    
    // Configure line width to 10 points
    circlePath.lineWidth = 10;
    
    // Configure the drawing color to light gray
    [self.circleColor setStroke];
    
    // Drawing the circles line
    [circlePath stroke];
    
    // Outlining a triangle
    CGRect triangleRect = CGRectMake(bounds.size.width / 4.0, bounds.size.height / 3.0, bounds.size.width / 2.0, bounds.size.height / 3.0);
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    [trianglePath moveToPoint:CGPointMake(center.x, triangleRect.origin.y)];
    [trianglePath addLineToPoint:CGPointMake(triangleRect.origin.x, triangleRect.origin.y + triangleRect.size.height)];
    [trianglePath addLineToPoint:CGPointMake(triangleRect.origin.x + triangleRect.size.width, triangleRect.origin.y + triangleRect.size.height)];
    [trianglePath closePath];
    
    CGContextSaveGState(currentContext); // no function to clear the clip path, restore when done with triangle
    [trianglePath addClip]; // Defining what we want painted in the gradiant
    
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0, 0.0, 1.0, // Star color, R G B values, 1 being 100%, 4th value opacity
                            1.0, 1.0, 0.0, 1.0}; // End color
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    
    CGPoint startPoint = CGPointMake(center.x, triangleRect.origin.y);
    CGPoint endPoint = CGPointMake(center.x, triangleRect.origin.y + triangleRect.size.height);
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    CGContextRestoreGState(currentContext);
    
    // Saving the current state in a pointer to/of the current view
    CGContextSaveGState(currentContext);
    
    // Anything drawn after this will have a shadow, must restore state to turn off shadow
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    
    UIImage *logoImage = [UIImage imageNamed:@"matrix.png"];
    [logoImage drawInRect:rect];
    
    //anything after this will not have a shadow
    CGContextRestoreGState(currentContext);
    
}

// When the finger touches the screen
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    // Getting 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100;
    float green = (arc4random() % 100) / 100;
    float blue = (arc4random() % 100) / 100;
    
    UIColor *randomColor = [UIColor colorWithRed:(red)
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    self.circleColor = randomColor;
    
    
}

// custom setter to set setNeedsDisplay to get on the list of dirty views to rerender
- (void) setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}


@end
