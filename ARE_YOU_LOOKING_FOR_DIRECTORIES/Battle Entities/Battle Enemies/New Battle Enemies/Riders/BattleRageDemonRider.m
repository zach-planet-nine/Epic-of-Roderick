//
//  BattleRageDemonRider.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/3/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleRageDemonRider.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation BattleRageDemonRider

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
        
        defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_NEAREST] imageForKey:@"demon_shadow_rider copy.png"] imageDuplicate] retain];
        whichEnemy = kEnemyChampion;
        battleLocation = aLocation;
        state = kEntityState_Alive;
        level = 1;
        hp = 105;
        maxHP = 105;
        essence = 15;
        maxEssence = 15;
        endurance = 20;
        maxEndurance = 20;
        strength = 2;
        stamina = 3;
        agility = 2;
        dexterity = 1;
        power = 1;
        affinity = 1;
        luck = 2;
        battleTimer = 0;
        while (level < partyLevel + 1) {
            [self levelUp];
        }
        experience = 70 * level;
        rageAffinity = 12;
        damageDealt = 0;
        isAlive = YES;
        ai[0] = EnemyAISet(kAIEndurancePercent, 70, kAICharacterWithHPAbovePercent, 95, kAIEnemySlash);
        ai[1] = EnemyAISet(kAIEndurancePercent, 50, kAICharacterWithLowestEndurance, 0, kAIEnemySlash);
        ai[2] = EnemyAISet(kAIEssencePercent, 80, kAIEnemyHasBleeders, 0, kAIEnemyHealBleeder);
        ai[3] = EnemyAISet(kAIEssencePercent, 70, kAIAnyCharacter, 0, kAIEnemyRageAllCharacters);
    }
    
    return self;
}

- (void)decideWhatToDo {
    
    for (int i = 0; i < 4; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            //NSLog(@"Poison Demon Rider did something %f, %f.", endurance, essence);
            return;
        }
    }
    //NSLog(@"Poison Demon Rider can't do anything %f, %f.", endurance, essence);
}


@end
