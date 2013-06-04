//
//  AkathSingleCharacter.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AkathSingleCharacter.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "BattleValkyrie.h"
#import "ParticleEmitter.h"
#import "Image.h"
#import "BattleStringAnimation.h"

@implementation AkathSingleCharacter

- (void)dealloc {
    
    if (hammer) {
        [hammer release];
    }
    [super dealloc];
}

- (id)initToCharacter:(AbstractBattleCharacter *)aCharacter {
    
    if (self = [super init]) {
        
        BattleValkyrie *valk = [sharedGameController.battleCharacters objectForKey:@"BattleValkyrie"];
        if (valk.essence > 0 && aCharacter.isDisoriented) {
            aCharacter.isDisoriented = NO;
            target1 = aCharacter;
            hammer = [[Image alloc] initWithImageNamed:@"Hammer.png" filter:GL_LINEAR];
            hammer.rotationPoint = CGPointMake(10, 15);
            hammer.renderPoint = CGPointMake(aCharacter.renderPoint.x + 25, aCharacter.renderPoint.y + 30);
            gotHit = [[Image alloc] initWithImageNamed:@"GotHit.png" filter:GL_NEAREST];
            gotHit.renderPoint = CGPointMake(aCharacter.renderPoint.x + 5, aCharacter.renderPoint.y + 15);
            gotHit.scale = Scale2fMake(0.5, 0.5);
            stage = 0;
            duration = 0.3;
            active = YES;
        } else {
            BattleStringAnimation *ineffective = [[BattleStringAnimation alloc] initIneffectiveStringFrom:CGPointMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y)];
            [sharedGameController.currentScene addObjectToActiveObjects:ineffective];
            [ineffective release];
            stage = 3;
            active = NO;
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
                    BattleStringAnimation *deDisorientated = [[BattleStringAnimation alloc] initStatusString:@"DeDisoriented!" from:CGPointMake(target1.renderPoint.x, target1.renderPoint.y)];
                    [sharedGameController.currentScene addObjectToActiveObjects:deDisorientated];
                    [deDisorientated release];
                    duration = 0.3;
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
                hammer.rotation += ((90 / 0.3) * aDelta);
                break;
            case 1:
                gotHit.scale = Scale2fMake(gotHit.scale.x + (aDelta * 3.3333), gotHit.scale.y + (aDelta * 3.3333));
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        switch (stage) {
            case 0:
                [hammer renderCenteredAtPoint:hammer.renderPoint];
                break;
            case 1:
                [gotHit renderCenteredAtPoint:gotHit.renderPoint];
                break;
                
            default:
                break;
        }
    }
}

@end
