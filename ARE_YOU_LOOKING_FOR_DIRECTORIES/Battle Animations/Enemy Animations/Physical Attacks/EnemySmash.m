//
//  EnemySmash.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/13/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemySmash.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "Image.h"

@implementation EnemySmash

- (void)dealloc {
    
    if (fist) {
        [fist release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter:(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        target1 = aCharacter;
        fist = [[Image alloc] initWithImageNamed:@"Fist.png" filter:GL_NEAREST];
        fist.renderPoint = CGPointMake(aCharacter.renderPoint.x + 60, aCharacter.renderPoint.y + 20);
        damage = [aEnemy calculateSmashDamageToCharacter:aCharacter];
        stage = 10;
        duration = 0.3;
        active = YES;
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    if (active) {
        duration -= aDelta;
        if (duration < 0) {
            switch (stage) {
                case 0:
                    stage++;
                    [target1 flashColor:Red];
                    [target1 youTookDamage:damage];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                case 10:
                    stage = 0;
                    duration = 0.5;
                    break;
                default:
                    break;
            }
        }
        if (stage == 0) {
            fist.rotation += aDelta * 300;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [fist renderCenteredAtPoint:fist.renderPoint];
    }
}

@end
