//
//  KSAppDelegate.h
//  CocoaClusters
//
//  Created by Debasis Das on 7/29/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *centroidArray;

@property (assign) IBOutlet NSView *placeholderView1;
@property (assign) IBOutlet NSView *placeholderView2;
@property (assign) IBOutlet NSView *placeholderView3;
@property (assign) IBOutlet NSView *placeholderView4;




+(float)distanceBetweenPointOne:(NSPoint)pointOne AndPointTwo:(NSPoint )pointTwo;
@end
