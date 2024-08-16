//
//  Hawk.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Hawk.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BattleRanger.h"
#import "Image.h"
#import "HawkSingleEnemy.h"
#import "HawkAllEnemies.h"
#import "HawkSingleCharacter.h"
#import "HawkAllCharacters.h"



@implementation Hawk

@synthesize defaultImage;
@synthesize defenseMode;

- (id)init
{
    self = [super init];
    if (self) {
        
        defaultImage = [[Image alloc] initWithImageNamed:@"Hawk.png" filter:GL_LINEAR];
		agility = 4;
		essence = 20;
        ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    }
    
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    if (velocity.y != 0) {
        Vector2f temp = Vector2fMake(velocity.x * aDelta, velocity.y * aDelta);
        renderPoint = CGPointMake(renderPoint.x + temp.x, renderPoint.y + temp.y);
        if (fabsf(renderPoint.y - ranger.renderPoint.y - 35) < 3) {
            renderPoint = CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y + 35);
            velocity = Vector2fMake(0, 0);
        }
        return;
    }
    [super updateWithDelta:aDelta];
}

- (void)render {
    
    [defaultImage renderCenteredAtPoint:renderPoint];
}

- (void)timerFired {
    
    if (!allEnemies && !allCharacters) {
        if (target == nil) {
            return;
        }
        if ([target isKindOfClass:[AbstractBattleEnemy class]] && target.isAlive) {
            HawkSingleEnemy *hse = [[HawkSingleEnemy alloc] initToEnemy:target fromHawk:self];
            [[GameController sharedGameController].currentScene addObjectToActiveObjects:hse];
            [hse release];
            return;
        } else if ([target isKindOfClass:[AbstractBattleCharacter class]] && target.isAlive) {
            HawkSingleCharacter *hsc = [[HawkSingleCharacter alloc] initToEntity:target fromHawk:self];
            [sharedGameController.currentScene addObjectToActiveObjects:hsc];
            [hsc release];
            return;
        }
    } else {
        if (allEnemies) {
            HawkAllEnemies *hae = [[HawkAllEnemies alloc] initFromHawk:self];
            [sharedGameController.currentScene addObjectToActiveObjects:hae];
            [hae release];
            return;
        } else if (allCharacters) {
            HawkAllCharacters *hac = [[HawkAllCharacters alloc] initFromHawk:self];
            [sharedGameController.currentScene addObjectToActiveObjects:hac];
            [hac release];
            return;
        }
    }
    target = nil;
    allEnemies = NO;
    allCharacters = NO;
}

- (void)beSummoned {
    
    defaultImage.renderPoint = CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y - 30);
}

- (void)flyBackToRanger {
    
    velocity = Vector2fMake((ranger.renderPoint.x - renderPoint.x) * 2, (ranger.renderPoint.y + 35 - renderPoint.y) * 2);
}

- (void)joinBattle {
    ranger = [[GameController sharedGameController].battleCharacters objectForKey:@"BattleRanger"];
    renderPoint = CGPointMake(ranger.renderPoint.x, ranger.renderPoint.y + 35);
    attackPower = ranger.stamina + ranger.level + (RANDOM_0_TO_1() * ranger.luck);
    helpPower = attackPower + (RANDOM_0_TO_1() * ranger.luck);
    [super joinBattle];
}

- (int)calculateHawkDropDamageTo:(AbstractBattleEntity *)aEntity { 
    float dropDamage = attackPower * 3 - aEntity.stamina - aEntity.staminaModifier;
    dropDamage += RANDOM_0_TO_1() * (10 + ranger.level + ranger.levelModifier);
    return (int)dropDamage;
}

- (int)calculateHawkDamage { 
    float hawkDamage = attackPower + RANDOM_0_TO_1() * (10 + ranger.level + ranger.levelModifier);
    return (int)hawkDamage;
}

- (float)calculateMotivationDurationTo:(AbstractBattleEntity *)aEntity { 
    float motivationDuration = 1 + (helpPower * 0.1);
    motivationDuration += RANDOM_0_TO_1() * 3;
    return (int)motivationDuration;
}


@end
