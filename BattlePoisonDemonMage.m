//
//  BattlePoisonDemonMage.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/26/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattlePoisonDemonMage.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation BattlePoisonDemonMage

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
        
        defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_NEAREST] imageForKey:@"demon_poison_mage.png"] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 3;
		hp = 125;
		maxHP = 125;
		essence = 13;
		maxEssence = 13;
        endurance = 14;
        maxEndurance = 14;
		strength = 3;
		agility = 3;
		stamina = 3;
		dexterity = 3;
		power = 5;
        affinity = 5;
		luck = 1;
		battleTimer = 0.0;
        fireAffinity = 3;
        while (level < partyLevel) {
            [self levelUp];
        }
		experience = 55 * level;
        damageDealt = 0;
        ai[0] = EnemyAISet(kAIEssencePercent, 80, kAIAnyCharacter, 0, kAIEnemyPoisonAllCharacters);
        ai[1] = EnemyAISet(kAIEndurancePercent, 80, kAICharacterWithLowestHP, 0, kAIEnemySmash);
        ai[2] = EnemyAISet(kAIEssencePercent, 60, kAIAnyCharacter, 0, kAIEnemyPoison);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    
    for (int i = 0; i < 3; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            return;
        }
    }
}


@end
