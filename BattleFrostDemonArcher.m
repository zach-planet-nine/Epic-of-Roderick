//
//  BattleFrostDemonArcher.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleFrostDemonArcher.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "OverMind.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"

@implementation BattleFrostDemonArcher

- (void)dealloc {
    
    if (defaultImage) {
        [defaultImage release];
    }
    [super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation
{
    self = [super initWithBattleLocation:aLocation];
    if (self) {
        
        defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_NEAREST] imageForKey:@"frost_demon_archer.png"] imageDuplicate] retain];
        NSLog(@"You should have archer");
        defaultImage.scale = Scale2fMake(0.7, 0.7);
        whichEnemy = kSlime;
        battleLocation = aLocation;
        state = kEntityState_Alive;
        level = 1;
        hp = 60;
        maxHP = 60;
        essence = 10;
        maxEssence = 10;
        endurance = 15;
        maxEndurance = 15;
        strength = 2;
        stamina = 1;
        agility = 3;
        dexterity = 2;
        power = 1;
        affinity = 1;
        luck = 1;
        battleTimer = 0.0;
        while (level < partyLevel) {
            [self levelUp];
        }
        experience = 55 * level;
        waterAffinity = skyAffinity = 1;
        damageDealt = 0;
        ai[0] = EnemyAISet(kAIEssenceAmount, 5, kAIEnemyWithHPBelowPercent, 25, kAIEnemyHeal);
        ai[1] = EnemyAISet(kAIEssenceAmount, 5, kAIEnemyHasNegativeStatus, 0, kAIEnemyHealNegativeStatus);
        ai[2] = EnemyAISet(kAIEndurancePercent, 80, kAICharacterWithHPBelowPercent, 50, kAIEnemyArrow);
        ai[3] = EnemyAISet(kAIEndurancePercent, 70, kAIAnyCharacter, 0, kAIEnemyArrow);
        isAlive = YES;
    }
    
    return self;
}

- (void)decideWhatToDo {
    
    for (int i = 0; i < 4; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            //NSLog(@"Frost demon archer did something. %d, %f, %f", i, endurance, essence);
            return;
        }
    }
    //NSLog(@"Frost demon can't do anything.");
}

- (int)calculateArrowDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    
    float tempDamage = [super calculateArrowDamageToCharacter:aCharacter];
    tempDamage *= waterAffinity / aCharacter.waterAffinity;
    return (int)tempDamage;
    
}

@end
