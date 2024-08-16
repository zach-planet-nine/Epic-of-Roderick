//
//  AbstractGameObject.h
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/17/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractGameObject : NSObject {
    
    float duration;
    BOOL active;
    int stage;
}

@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) float duration;

- (void)updateWithDelta:(float)aDelta;

- (void)render;

@end
