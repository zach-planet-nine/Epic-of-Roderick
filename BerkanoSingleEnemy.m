//
//  BerkanoSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BerkanoSingleEnemy.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Image.h"
#import "BattleStringAnimation.h"

@implementation BerkanoSingleEnemy

- (void)dealloc {
    
    if (berkano) {
        [berkano release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
       
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        target1 = aEnemy;
        if ((valk.affinity + valk.affinityModifier + valk.deathAffinity) * (valk.essence / valk.maxEssence) > aEnemy.affinity + aEnemy.affinityModifier + aEnemy.deathAffinity) {
            berkano = [[Image alloc] initWithImageNamed:@"Ghost.png" filter:GL_LINEAR];
            berkano.renderPoint = CGPointMake(240, 160);
            stage = 0;
            duration = 1.5;
            active = YES;
        } else {
            BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:aEnemy.renderPoint];
            [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
            [ineffective release];
            stage = 4;
            duration = 1;
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
                    [target1 youWereBerkanoed];
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
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [berkano renderCenteredAtPoint:berkano.renderPoint];
    }
}

@end
