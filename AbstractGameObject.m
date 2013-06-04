//
//  AbstractGameObject.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/17/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AbstractGameObject.h"

@implementation AbstractGameObject

@synthesize active;
@synthesize duration;

- (void)dealloc {
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        active = YES;
        duration = 0;
        stage = 0;
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {}

- (void)render {}

@end
