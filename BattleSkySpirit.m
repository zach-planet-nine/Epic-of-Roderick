//
//  BattleSkySpirit.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BattleSkySpirit.h"
#import "PackedSpriteSheet.h"
#import "Image.h"
#import "OverMind.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"

@implementation BattleSkySpirit

- (void)dealloc {
	
    if (defaultImage) {
        [defaultImage release];
    }
	[super dealloc];
}

- (id)initWithBattleLocation:(int)aLocation {
	
	if (self = [super initWithBattleLocation:aLocation]) {
		
		defaultImage = [[[[PackedSpriteSheet packedSpriteSheetForImageNamed:@"TEOREnemies.png" controlFile:@"TEOREnemies" imageFilter:GL_LINEAR] imageForKey:@"spirit_lightening_70x97.png"] imageDuplicate] retain];
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
		strength = 8;
		agility = 8;
		stamina = 8;
		dexterity = 8;
		power = 12;
        affinity = 12;
		luck = 1;
        affinity = 8;
		battleTimer = 0.0;
		experience = 40;
        waterAffinity = 4;
        skyAffinity = 8;
        damageDealt = 400;
        ai[0] = EnemyAISet(kAIEssencePercent, 80, kAICharacterWithLowestElementalAffinity, kSky, kAIEnemyEnergyBall);
        ai[1] = EnemyAISet(kAIEssenceAmount, 10, kAIFatiguedEnemy, 0, kAIEnemyFatigueCure);
        ai[2] = EnemyAISet(kAIEndurancePercent, 70, kAICharacterWithLowestEssence, 0, kAIEnemySmash);
	}
	selectorImage.renderPoint = CGPointMake(renderPoint.x, renderPoint.y - 40);
	selectorImage.color = Color4fMake(1.0, 0.0, 0.0, 1.0);
	isAlive = YES;
	return self;
}

- (void)decideWhatToDo {
    
    /*
    if (essence / maxEssence > 0.8) {
        //NSLog(@"Sky attack %d!", [sharedOverMind characterWithLowestElementalAffinity:kSky].whichCharacter);
        essence -= 50;
        return;
    } else if ([sharedOverMind fatiguedEnemy] && essence > 10) {
        //NSLog(@"Would cure enemy's fatigue");
        essence -= 100;
        return;
    } else if (endurance / maxEndurance > 0.7) {
        //NSLog(@"Sky spirit would attack %d", [sharedOverMind characterWithLowestEssence].whichCharacter);
        endurance -= 100;
        return;
    }*/
    
    for (int i = 0; i < 3; i++) {
        if ([super canIDoThis:ai[i]]) {
            [super doThis:ai[i] decider:self];
            //NSLog(@"Sky Spirit did something. %f, %f", endurance, essence);
            return;
        }
    }
    //NSLog(@"Sky Spirit Can't do anything %f, %f", endurance, essence);
}

- (int)calculateEnergyBallDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    
    float energyDamage = ((power + powerModifier + skyAffinity - aCharacter.affinity - aCharacter.affinityModifier) * 3 * (essence / maxEssence));
    essence -= 20;
    endurance -= 5;
    return (int)energyDamage;
}

@end
