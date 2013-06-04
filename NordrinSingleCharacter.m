//
//  NordrinSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "NordrinSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleCharacter.h"
#import "BattleRoderick.h"
#import "Image.h"
#import "PackedSpriteSheet.h"

@implementation NordrinSingleCharacter

- (void)dealloc {
    
    if (weapon) {
        [weapon release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter 
{
    self = [super init];
    if (self) {
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        weapon = [[[sharedGameController.teorPSS imageForKey:@"Scythe.png"] imageDuplicate] retain];
        weapon.renderPoint = CGPointMake(aCharacter.renderPoint.x + 30, aCharacter.renderPoint.y);
        weapon.rotationPoint = CGPointMake(10, 20);
        rotationAcceleration = 100;
        stage = 0;
        duration = 2;
        active = YES;
        [aCharacter gainDoubleAttack:(int)((roderick.level + roderick.levelModifier + roderick.waterAffinity) / 10)];
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
        switch (stage) {
            case 0:
                rotationSpeed += (rotationAcceleration * aDelta);
                rotation += rotationSpeed;
                if (rotation > 360) {
                    rotation -= 360;
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage == 0) {
        [weapon renderCenteredAtPoint:weapon.renderPoint scale:Scale2fMake(1, 1) rotation:rotation];
    }
}


@end
