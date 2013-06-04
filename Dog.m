//
//  Dog.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/6/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Dog.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleRanger.h"
#import "Image.h"

@implementation Dog

@synthesize defaultImage;

- (id)init
{
    self = [super init];
    if (self) {
    
        defaultImage = [[Image alloc] initWithImageNamed:@"Dog.png" filter:GL_LINEAR];
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
