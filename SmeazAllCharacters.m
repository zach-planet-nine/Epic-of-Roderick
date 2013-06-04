//
//  SmeazAllCharacters.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/10/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "SmeazAllCharacters.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattlePriest.h"
#import "Image.h"

@implementation SmeazAllCharacters

- (void)dealloc {
    
    if (bloodDrop) {
        [bloodDrop release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        smeazDuration = [poet calculateSmeazDuration];
        bloodDrop = [[Image alloc] initWithImageNamed:@"SmeazBloodDrop.png" filter:GL_NEAREST];
        rotationVelocity = 1;
        bloodDrop.rotationPoint = CGPointMake(16, 16);
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
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                            [character gainDrainAttack];
                        }
                    }
                    duration = smeazDuration;
                    break;
                case 1:
                    stage++;
                    for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
                        if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                            [character loseDrainAttack];
                        }
                    }
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        if (stage == 0) {
            rotationVelocity += (aDelta * 10);
            bloodDrop.rotation += (rotationVelocity * aDelta);
            if (bloodDrop.rotation > 360) {
                bloodDrop.rotation -= 360;
            }
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        for (AbstractBattleCharacter *character in sharedGameController.currentScene.activeEntities) {
            if ([character isKindOfClass:[AbstractBattleCharacter class]] && character.isAlive) {
                [bloodDrop renderCenteredAtPoint:CGPointMake(character.renderPoint.x + 30, character.renderPoint.y + 30)];
            }
        }
    }
}

@end
