//
//  RandomDataView.m
//  CocoaClusters
//
//  Created by Debasis Das on 7/29/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import "RandomDataView.h"
#import "KSAppDelegate.h"

@implementation RandomDataView


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];

    for (NSDictionary *dict in self.pointsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor yellowColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 4, 4);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];

}

@end


@implementation CentroidDataView


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    
    for (NSDictionary *dict in self.pointsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor yellowColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 4, 4);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];
    
    
    //Draw the Centroid Points
    gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    
    for (NSDictionary *dict in self.centroidsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor redColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 20, 20);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];
    
    
    
    }
    

@end

@implementation CentroidWithLinesDataView


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    
    for (NSDictionary *dict in self.pointsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor greenColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 4, 4);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];
    
    
    //Draw the Centroid Points
    gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    
    for (NSDictionary *dict in self.centroidsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor redColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 20, 20);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];
    
    
    //Draw the lines to centroid based on proximity
    
    for (NSDictionary *dict in self.pointsArray)
    {
        float minimumDistance = 10000.0;
        NSPoint nearestCentroid;
        for (NSDictionary *centroidDict in self.centroidsArray)
        {
            float newMinimumDistance = [KSAppDelegate distanceBetweenPointOne:NSMakePoint([[centroidDict objectForKey:@"x"] floatValue], [[centroidDict objectForKey:@"y"] floatValue]) AndPointTwo:NSMakePoint([[dict objectForKey:@"x"] floatValue], [[dict objectForKey:@"y"] floatValue])];
            if (newMinimumDistance < minimumDistance)
            {
                minimumDistance = newMinimumDistance;
                nearestCentroid = NSMakePoint([[centroidDict objectForKey:@"x"] floatValue], [[centroidDict objectForKey:@"y"] floatValue]);
            }
        }
        NSBezierPath *bPath = [NSBezierPath bezierPath];
        [bPath moveToPoint:NSMakePoint([[dict objectForKey:@"x"] floatValue], [[dict objectForKey:@"y"] floatValue])];
        [bPath lineToPoint:nearestCentroid];
        [bPath setLineWidth:0.50];
        [bPath stroke];
        //        NSLog(@"%2.2f",minimumDistance);
        NSLog(@"%@",NSStringFromPoint(nearestCentroid));
        
    }
    
}

@end

@implementation CompressedClusterView


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSGraphicsContext* gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    
    for (NSDictionary *dict in self.pointsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor greenColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 4, 4);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];
    
    
    //Draw the Centroid Points
    gc = [NSGraphicsContext currentContext];
    [gc saveGraphicsState];
    
    for (NSDictionary *dict in self.centroidsArray)
    {
        [[NSColor blackColor] setStroke];
        [[NSColor redColor] setFill];
        NSRect rect = NSMakeRect([[dict objectForKey:@"x"] intValue], [[dict objectForKey:@"y"] intValue], 20, 20);
        NSBezierPath* circlePath = [NSBezierPath bezierPath];
        [circlePath appendBezierPathWithOvalInRect: rect];
        [circlePath stroke];
        [circlePath fill];
    }
    [gc restoreGraphicsState];    
}

@end