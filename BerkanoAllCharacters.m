//
//  BerkanoAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/25/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "BerkanoAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"

@implementation BerkanoAllCharacters

- (void)dealloc {
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        berkanoDuration = [valk calculateBerkanoDuration];
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]]) {
                [character gainProtectionFromDying];
            }
        }
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
                    duration = berkanoDuration;
                    break;
                case 1:
                    stage++;
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        [character loseProtectionFromDying];
                    }
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    
                default:
                    break;
            }
        }
    }
}

@end
