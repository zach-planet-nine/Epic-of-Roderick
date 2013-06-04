//
//  HolgethSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "HolgethSingleCharacter.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleValkyrie.h"
#import "Image.h"
#import "PackedSpriteSheet.h"

@implementation HolgethSingleCharacter

- (void)dealloc {
    
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
    
    if (self = [super init]) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        target1 = aCharacter;
        int healBleeders = [valk calculateHolgethHealers];
        while (healBleeders > 0) {
            [aCharacter removeBleeder];
            healBleeders--;
        }
        bandage = [sharedGameController.teorPSS imageForKey:@"Bandage30x30.png"];
        bandage.color = Color4fMake(0, 0, 0, 0);
        bandage.renderPoint = CGPointMake(aCharacter.renderPoint.x + 30, aCharacter.renderPoint.y + 20);
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
                    duration = 0.3;
                    [target1 flashColor:Color4fMake(1, 1, 0, 1)];
                    break;
                case 1:
                    stage++;
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                bandage.color = Color4fMake(1, 1, 1, bandage.color.alpha + aDelta);
                break;
            case 1:
                if (bandage.color.alpha == 0) {
                    bandage.color = Color4fMake(1, 1, 1, 1);
                } else {
                    bandage.color = Color4fMake(1, 1, 1, 0);
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [bandage renderCenteredAtPoint:bandage.renderPoint];
    }
}
    
@end
