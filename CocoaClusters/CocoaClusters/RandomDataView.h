//
//  RandomDataView.h
//  CocoaClusters
//
//  Created by Debasis Das on 7/29/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RandomDataView : NSView
{

}

@property (nonatomic,retain) NSMutableArray *pointsArray;
@end




@interface CentroidDataView : NSView
{
    
}

@property (nonatomic,retain) NSMutableArray *pointsArray;
@property (nonatomic,retain) NSMutableArray *centroidsArray;
@end


@interface CentroidWithLinesDataView : NSView
{
    
}

@property (nonatomic,retain) NSMutableArray *pointsArray;
@property (nonatomic,retain) NSMutableArray *centroidsArray;
@end


@interface CompressedClusterView : NSView
{
    
}

@property (nonatomic,retain) NSMutableArray *pointsArray;
@property (nonatomic,retain) NSMutableArray *centroidsArray;
@end
