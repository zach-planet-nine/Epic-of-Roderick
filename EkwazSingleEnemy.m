//
//  Ekwaz.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EkwazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "Image.h"

@implementation EkwazSingleEnemy

- (void)dealloc {
    
    if (stone) {
        [stone release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        target1 = aEnemy;
        damage = [wizard calculateEkwazDamageTo:aEnemy];
        fatigueRoll = 0;
        if (RANDOM_0_TO_1() > 0.5 - ((wizard.level + wizard.levelModifier - aEnemy.level - aEnemy.levelModifier) / 10)) {
            fatigueRoll = (wizard.stoneAffinity - aEnemy.stoneAffinity) * 5 * (wizard.essence / wizard.maxEssence);
        }
        stone = [[Image alloc] initWithImageNamed:@"Stone.png" filter:GL_NEAREST];
        stone.scale = Scale2fMake(3, 3);
        stone.renderPoint = CGPointMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y + 400);
        stage = 0;
        duration = 1;
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
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Color4fMake(0.4, 0.1, 0, 1)];
                    [target1 youWereFatigued:(int)fatigueRoll];
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
        if (stage == 0) {
            stone.renderPoint = CGPointMake(stone.renderPoint.x, stone.renderPoint.y - (aDelta * 400));
        }
        if (stage == 1) {
            stone.color = Color4fMake(1, 1, 1, stone.color.alpha - (aDelta * 2));
        }
    }
}

- (void)render {
    
    if (active) {
        [stone renderCenteredAtPoint:stone.renderPoint];
    }
}

@end
