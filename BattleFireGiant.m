//
//  BattleFireGiant.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleFireGiant.h"
#import "GameController.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "OverMind.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"

@implementation BattleFireGiant

- (void)dealloc {
	
    if (defaultImage) {
        [defaultImage release];
    }
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_LINEAR] imageForKey:@"firegiant.png"] imageDuplicate] retain];
		whichEnemy = kSlime;
		battleLocation = aLocation;
		state = kEntityState_Alive;
		level = 1;
		hp = 80;
		maxHP = 80;
		essence = 10;
		maxEssence = 10;
        endurance = 10;
        maxEndurance = 10;
		strength = 12;
		agility = 8;
		stamina = 8;
		dexterity = 8;
		power = 8;
        affinity = 8;
		luck = 1;
        affinity = 8;
		battleTimer = 0.0;
		experience = 40;
        waterAffinity = 2;
        rageAffinity = 2;
        fireAffinity = 6;
        damageDealt = 120;
        ai[0] = EnemyAISet(kAIEndurancePercent, 80, kAICharacterWithHPBelowPercent, 20, kAIEnemySmash);
        ai[1] = EnemyAISet(kAIEndurancePercent, 80, kAIAnyCharacter, 0, kAIEnemySmash);
        ai[2] = EnemyAISet(kAIEssencePercent, 60, kAICharacterWithEssenceBelowPercent, 10, kAIEnemyFire);
        ai[3] = EnemyAISet(kAIEssencePercent, 60, kAICharacterWithLowestElementalAffinity, kFire, kAIEnemyFire);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    
    /*
    if (endurance / maxEndurance > 0.8) {
        if ([sharedOverMind characterWithHPBelowPercent:20] != nil) {
            //NSLog(@"Fire Giant: Character with hp less than 20 percent will be attacked.");
            endurance -= 50;
            return;
        } else {
            //NSLog(@"Fire Giant attacks %d", [sharedOverMind anyCharacter].whichCharacter);
            endurance -= 30;
            return;
        }
    } else if (essence / maxEssence > 0.6) {
        if ([sharedOverMind characterWithEssenceBelowPercent:10]) {
            //NSLog(@"Fire Giant Magically attack character with low essence.");
            essence -= 200;
            return;
        } else {
            //NSLog(@"Fire attack %d.", [sharedOverMind characterWithLowestElementalAffinity:kFire].whichCharacter);
            essence -= 50;
            return;
        }
    }*/
    for (int i = 0; i < 4; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            //NSLog(@"Fire Giant did something. %f, %f", endurance, essence);
            return;
        }
    }
    //NSLog(@"Fire Giant can't do anything %f, %f", endurance, essence);
}

@end
