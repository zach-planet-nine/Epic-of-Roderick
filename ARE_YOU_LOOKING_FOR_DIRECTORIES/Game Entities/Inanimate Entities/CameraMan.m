//
//  CameraMan.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "CameraMan.h"

@implementation CameraMan

- (id)initAtLocation:(CGPoint)aLocation 
{
    self = [super init];
    if (self) {
        currentLocation = aLocation;
        moving = kNotMoving;
        stage = 6;
        active = YES;
    }
    
    return self;
}

- (void)render {
}


@end
