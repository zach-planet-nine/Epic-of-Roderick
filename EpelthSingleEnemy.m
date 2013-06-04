//
//  EpelthSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EpelthSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Image.h"
#import "BattleStringAnimation.h"

@implementation EpelthSingleEnemy

- (void)dealloc {
    
    if (tombstone) {
        [tombstone release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        float deathRoll = 100 * RANDOM_0_TO_1();
        if (deathRoll < ((poet.level + poet.levelModifier + poet.deathAffinity - aEnemy.level - aEnemy.levelModifier - aEnemy.deathAffinity) * (poet.essence / poet.maxEssence))) {
            tombstone = [[Image alloc] initWithImageNamed:@"Tombstone.png" filter:GL_NEAREST];
            tombstone.renderPoint = CGPointMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 300);
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            [BattleStringAnimation makeIneffectiveStringAt:aEnemy.renderPoint];
            stage = 2;
            active = NO;
        }
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
                    [target1 youHaveDied];
                    duration = 1;
                    break;
                case 1:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                tombstone.renderPoint = CGPointMake(tombstone.renderPoint.x, tombstone.renderPoint.y - (aDelta * 300)  );
                break;
            case 1:
                tombstone.color = Color4fMake(1, 1, 1, tombstone.color.alpha - aDelta);
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [tombstone renderCenteredAtPoint:tombstone.renderPoint];
    }
}

@end
