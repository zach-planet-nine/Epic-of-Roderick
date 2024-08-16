//
//  Squirrel.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Squirrel.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "BattleRanger.h"
#import "Image.h"

@implementation Squirrel

- (id)init
{
    self = [super init];
    if (self) {
        
        defaultImage = [[Image alloc] initWithImageNamed:@"Squirrel.png" filter:GL_LINEAR];
		agility = 4;
		essence = 20;
        ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    [super updateWithDelta:aDelta];
}

- (void)render {
    
    [defaultImage renderCenteredAtPoint:defaultImage.renderPoint];
}

- (void)beSummoned {
    
    defaultImage.renderPoint = CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y - 30);
}

@end
