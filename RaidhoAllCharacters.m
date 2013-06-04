//
//  RaidhoAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/28/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RaidhoAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "Textbox.h"
#import "BattleStringAnimation.h"

@implementation RaidhoAllCharacters

- (void)dealloc {
    
    if (tb) {
        [tb release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
    
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        if ((wizard.affinity + wizard.affinityModifier + wizard.rageAffinity) * (wizard.essence / wizard.maxEssence) > 5) {
            tb = [[Textbox alloc] initWithRect:CGRectMake(120, 120, 180, 60) color:Color4fMake(0.3, 0.3, 0.3, 0.8) duration:2 animating:NO text:@"Placeholder"];
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                    [BattleStringAnimation makeIneffectiveStringAt:character.renderPoint];
                    stage = 4;
                    active = NO;
                }
            }
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
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                            if (character.isSlothed) {
                                character.isSlothed = NO;
                                BattleStringAnimation *deSlothed = [[BattleStringAnimation alloc] initStatusString:@"DeSlothed!" from:character.renderPoint];
                                [sharedGameController.currentScene addObjectToActiveObjects:deSlothed];
                                [deSlothed release];
                            } else {
                                [BattleStringAnimation makeIneffectiveStringAt:character.renderPoint];
                            }
                        }
                    }
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
        [tb updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (active) {
        [tb render];
    }
}

@end
