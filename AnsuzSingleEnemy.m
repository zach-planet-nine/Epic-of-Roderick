//
//  AnsuzSingleEnemy.m
//  TEORBattleTest
//
//  Created by Zach Babb on 5/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AnsuzSingleEnemy.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "BattleRanger.h"
#import "GameController.h"
#import "AbstractScene.h"


@implementation AnsuzSingleEnemy

+ (void)youWerePlacedOnEnemy:(AbstractBattleEnemy *)aEnemy {
	
	for (AbstractBattleEntity *entity in [GameController sharedGameController].currentScene.activeEntities) {
		if ([entity isKindOfClass:[AbstractBattleCharacter class]]) {
			if ([entity isMemberOfClass:[BattleRanger class]]) {
                BattleRanger *ranger = entity;
				[ranger setTargetPoint:CGPointMake(aEnemy.renderPoint.x, aEnemy.renderPoint.y)];
			}
			if ([entity isMemberOfClass:[BattleWizard class]]) {
				BattleWizard *wizard = entity;
                [wizard makeWizardBallPower:2.5];
			}
            [entity enduranceDoesNotDeplete];
			[entity youAttackedEnemy:aEnemy];
            [entity enduranceDoesDeplete];
		}
	}
}
	

@end
