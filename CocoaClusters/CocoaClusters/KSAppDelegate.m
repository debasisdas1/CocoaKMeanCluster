//
//  KSAppDelegate.m
//  CocoaClusters
//
//  Created by Debasis Das on 7/29/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import "KSAppDelegate.h"
#import "RandomDataView.h"
//#import "CentroidDataView.h"

@implementation KSAppDelegate
@synthesize dataArray;
- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
    [self setDataArray:[self getRandomData]];
    [self setCentroidArray:[self getCentroidDataArray]];

}

- (NSMutableArray *)getRandomData
{
        NSMutableArray *pointArray = [[NSMutableArray alloc] init];
        NSNumber *x;
        NSNumber *y;
//        NSNumber *val;
        NSNumber *cx;
        NSNumber *cy;
    
        for (int i=0; i<3000; i++)
        {
            x =[NSNumber numberWithFloat:arc4random()%340];
            y =[NSNumber numberWithFloat:arc4random()%350];
            cx =[NSNumber numberWithFloat:0.0];
            cy =[NSNumber numberWithFloat:0.0];
//            val = [NSNumber numberWithFloat:sqrtf(pow([x floatValue],2)+pow([y floatValue],2))];
            
            NSDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  x,@"x",
                                  y,@"y",
                                  cx,@"cx",
                                  cy,@"cy",
                                  nil];
            [pointArray addObject:dict];
        }
        return pointArray;
        
}

-(IBAction)loadRandomData:(id)sender
{
    RandomDataView *rdv = [[RandomDataView alloc] initWithFrame:[self.placeholderView1 bounds]];
    [rdv setPointsArray:self.dataArray];
    [self.placeholderView1 addSubview:rdv];
}

-(NSMutableArray *)getCentroidDataArray
{
    NSMutableArray *centroidPointsArray = [[NSMutableArray alloc] init];
    float width = [self.placeholderView1 frame].size.width;
    float height = [self.placeholderView1 frame].size.height;
    
//    NSDictionary *centroid1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [NSNumber numberWithFloat:0],@"x",
//                               [NSNumber numberWithFloat:0],@"y",
//                               nil];

    NSDictionary *centroid1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:arc4random()%300],@"x",
                               [NSNumber numberWithFloat:arc4random()%300],@"y",
                               nil];

    NSDictionary *centroid2 = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:arc4random()%300],@"x",
                               [NSNumber numberWithFloat:arc4random()%300],@"y",
                               nil];

//    NSDictionary *centroid2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [NSNumber numberWithFloat:3*(width/4)],@"x",
//                               [NSNumber numberWithFloat:height/4],@"y",
//                               nil];

    NSDictionary *centroid3 = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:width/4],@"x",
                               [NSNumber numberWithFloat:3*(height/4)],@"y",
                               nil];
    
    NSDictionary *centroid4 = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:(3* width/4)],@"x",
                               [NSNumber numberWithFloat:(3* height/4)],@"y",
                               nil];
    
    [centroidPointsArray addObject:centroid1];
    [centroidPointsArray addObject:centroid2];
    [centroidPointsArray addObject:centroid3];
    [centroidPointsArray addObject:centroid4];

    return centroidPointsArray;
}

-(IBAction)addCentroids:(id)sender
{
    
    CentroidDataView *rdv = [[CentroidDataView alloc] initWithFrame:[self.placeholderView2 bounds]];
    [rdv setPointsArray:self.dataArray];
    [rdv setCentroidsArray:[self centroidArray]];
    [self.placeholderView2 addSubview:rdv];


}

-(IBAction)addLinesToCentroids:(id)sender
{
    
    CentroidWithLinesDataView *rdv = [[CentroidWithLinesDataView alloc] initWithFrame:[self.placeholderView3 bounds]];
    [rdv setPointsArray:self.dataArray];
    [rdv setCentroidsArray:[self centroidArray]];
    [self.placeholderView3 addSubview:rdv];

}

-(IBAction)compressCluster:(id)sender
{
    float compressionFactor = [sender floatValue];
    NSLog(@"compressionFactor %2.2f",compressionFactor);
    NSMutableArray *dataArray = [self dataArray];
    NSMutableArray *centroidArray = [self centroidArray];
    
    for (NSDictionary *dict in dataArray)
    {
        float minimumDistance = 10000.0;
        NSPoint nearestCentroid;
        for (NSDictionary *centroidDict in centroidArray)
        {
            float newMinimumDistance = [KSAppDelegate distanceBetweenPointOne:NSMakePoint([[centroidDict objectForKey:@"x"] floatValue], [[centroidDict objectForKey:@"y"] floatValue]) AndPointTwo:NSMakePoint([[dict objectForKey:@"x"] floatValue], [[dict objectForKey:@"y"] floatValue])];
            if (newMinimumDistance < minimumDistance)
            {
                minimumDistance = newMinimumDistance;
                nearestCentroid = NSMakePoint([[centroidDict objectForKey:@"x"] floatValue], [[centroidDict objectForKey:@"y"] floatValue]);
                
            }
        }
        [dict setValue:[NSNumber numberWithFloat:nearestCentroid.x] forKey:@"cx"];
        [dict setValue:[NSNumber numberWithFloat:nearestCentroid.y] forKey:@"cy"];
    }
//    NSLog(@"dataArray %@",dataArray);
    for (NSMutableDictionary *mdict in dataArray)
    {
        float pointLengthFromOrigin = [KSAppDelegate distanceBetweenPointOne:
                                       NSMakePoint([[mdict objectForKey:@"x"] floatValue], [[mdict objectForKey:@"y"] floatValue])
                                                                 AndPointTwo:NSMakePoint(0, 0)];
        float length = [KSAppDelegate distanceBetweenPointOne:
                            NSMakePoint([[mdict objectForKey:@"x"] floatValue], [[mdict objectForKey:@"y"] floatValue])
                                                      AndPointTwo:NSMakePoint([[mdict objectForKey:@"cx"] floatValue], [[mdict objectForKey:@"cy"] floatValue])];
        float newLength = length * compressionFactor;
        float angle;

        float newX;
        float newY;

        
        if (([[mdict objectForKey:@"x"] floatValue] > [[mdict objectForKey:@"cx"] floatValue]) && ([[mdict objectForKey:@"y"] floatValue] > [[mdict objectForKey:@"cy"] floatValue]))
        {
            angle = atan2f(([[mdict objectForKey:@"y"] floatValue] - [[mdict objectForKey:@"cy"] floatValue]), ([[mdict objectForKey:@"x"] floatValue] - [[mdict objectForKey:@"cx"] floatValue]));
            newX = [[mdict objectForKey:@"cx"] floatValue] + cosf(angle) * newLength;
            newY = [[mdict objectForKey:@"cy"] floatValue] + sinf(angle) * newLength;

        }

        else if (([[mdict objectForKey:@"x"] floatValue] < [[mdict objectForKey:@"cx"] floatValue]) && ([[mdict objectForKey:@"y"] floatValue] < [[mdict objectForKey:@"cy"] floatValue]))
        {
            angle = atan2f(([[mdict objectForKey:@"cy"] floatValue] - [[mdict objectForKey:@"y"] floatValue]), ([[mdict objectForKey:@"cx"] floatValue] - [[mdict objectForKey:@"x"] floatValue]));
            newX = [[mdict objectForKey:@"cx"] floatValue] - cosf(angle) * newLength;
            newY = [[mdict objectForKey:@"cy"] floatValue] - sinf(angle) * newLength;
            
        }

        else if (([[mdict objectForKey:@"x"] floatValue] > [[mdict objectForKey:@"cx"] floatValue]) && ([[mdict objectForKey:@"y"] floatValue] < [[mdict objectForKey:@"cy"] floatValue]))
        {
            angle = atan2f(([[mdict objectForKey:@"cy"] floatValue] - [[mdict objectForKey:@"y"] floatValue]), ([[mdict objectForKey:@"x"] floatValue] - [[mdict objectForKey:@"cx"] floatValue]));
            newX = [[mdict objectForKey:@"cx"] floatValue] + cosf(angle) * newLength;
            newY = [[mdict objectForKey:@"cy"] floatValue] - sinf(angle) * newLength;
            
        }

        else if (([[mdict objectForKey:@"x"] floatValue] < [[mdict objectForKey:@"cx"] floatValue]) && ([[mdict objectForKey:@"y"] floatValue] > [[mdict objectForKey:@"cy"] floatValue]))
        {
            angle = atan2f(([[mdict objectForKey:@"y"] floatValue] - [[mdict objectForKey:@"cy"] floatValue]), ([[mdict objectForKey:@"cx"] floatValue] - [[mdict objectForKey:@"x"] floatValue]));
            newX = [[mdict objectForKey:@"cx"] floatValue] - cosf(angle) * newLength;
            newY = [[mdict objectForKey:@"cy"] floatValue] + sinf(angle) * newLength;
            
        }
    

        [mdict setValue:[NSNumber numberWithFloat:newX] forKey:@"x"];
        [mdict setValue:[NSNumber numberWithFloat:newY] forKey:@"y"];

    }
    
    CompressedClusterView *rdv = [[CompressedClusterView alloc] initWithFrame:[self.placeholderView4 bounds]];
    [rdv setPointsArray:self.dataArray];
    [rdv setCentroidsArray:[self centroidArray]];
    [self.placeholderView4 addSubview:rdv];


}

+(float)distanceBetweenPointOne:(NSPoint)pointOne AndPointTwo:(NSPoint )pointTwo
{
    float distance = sqrtf(pow((pointOne.x - pointTwo.x),2)+pow((pointOne.y - pointTwo.y),2));
    return distance;
}
@end
