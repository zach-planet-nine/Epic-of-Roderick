//
//  GeboAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "GeboAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Animation.h"
#import "ParticleEmitter.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation GeboAllEnemies

- (void)dealloc {
    
    if (treasureChest) {
        [treasureChest release];
    }
    if (explosion) {
        [explosion release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                damages[enemyIndex] = [poet calculateGeboDamageTo:enemy];
                enemyIndex++;
            }
        }
        treasureChest = [[Animation alloc] init];
        [treasureChest addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"ChestClosed.png"] delay:0.3];
        [treasureChest addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"ChestOpen.png"] delay:1];
        treasureChest.renderPoint = CGPointMake(360, 160);
        treasureChest.state = kAnimationState_Running;
        treasureChest.type = kAnimationType_Once;
        dynamite = [[Image alloc] initWithImageNamed:@"Dynamite.png" filter:GL_NEAREST];
        dynamite.scale = Scale2fMake(0.3, 0.3);
        dynamite.renderPoint = CGPointMake(360, 170);
        explosion = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"DynamiteEmitter.pex"];
        stage = 0;
        duration = 0.35;
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
                    break;
                case 1:
                    stage++;
                    explosion.sourcePosition = Vector2fMake(dynamite.renderPoint.x, dynamite.renderPoint.y);
                    duration = 0.2;
                    break;
                case 2:
                    stage++;
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youTookDamage:damages[enemyIndex]];
                        }
                    }
                    duration = 0.3;
                    break;
                case 3:
                    stage++;
                    duration = 1;
                    break;
                case 4:
                    stage++;
                    treasureChest.currentFrameImage.color = Color4fMake(1, 1, 1, 1);
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [treasureChest updateWithDelta:aDelta];
                break;
            case 1:
                dynamite.scale = Scale2fMake(dynamite.scale.x * (aDelta * 50), dynamite.scale.y * (aDelta * 50));
                dynamite.renderPoint = CGPointMake(dynamite.renderPoint.x, dynamite.renderPoint.y + (aDelta * 30));
                break;
            case 2:
                [explosion updateWithDelta:aDelta];
                [treasureChest currentFrameImage].color = Color4fMake(1, 1, 1, [treasureChest currentFrameImage].color.alpha - (aDelta * 2));
                break;
            case 3:
                [explosion updateWithDelta:aDelta];
                [treasureChest currentFrameImage].color = Color4fMake(1, 1, 1, [treasureChest currentFrameImage].color.alpha - (aDelta * 2));
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
                [treasureChest renderCenteredAtPoint:treasureChest.renderPoint];
                break;
            case 1:
                [treasureChest renderCenteredAtPoint:treasureChest.renderPoint];
                [dynamite renderCenteredAtPoint:dynamite.renderPoint];
                break;
            case 2:
                [treasureChest renderCenteredAtPoint:treasureChest.renderPoint];
                [explosion renderParticles];
                break;
            case 3:
                [treasureChest renderCenteredAtPoint:treasureChest.renderPoint];
                [explosion renderParticles];
                break;
                
            default:
                break;
        }
    }
}

@end
