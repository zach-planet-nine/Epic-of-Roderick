//
//  RaidhoSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RaidhoSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "Image.h"
#import "PackedSpriteSheet.h"
#import "Projectile.h"
#import "BattleStringAnimation.h"

@implementation RaidhoSingleEnemy

- (void)dealloc {
    
    if (shieldBreaker) {
        [shieldBreaker release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        if (wizard.essence > 0 && wizard.rageAffinity > aEnemy.rageAffinity) {
            target1 = aEnemy;
            shield = [sharedGameController.teorPSS imageForKey:@"EquipmentIcon28x28.png"];
            brokenShield = [sharedGameController.teorPSS imageForKey:@"EquipmentIconSelected28x28.png"];
            shield.renderPoint = brokenShield.renderPoint = CGPointMake(aEnemy.renderPoint.x - 30, aEnemy.renderPoint.y + 20);
            brokenShield.color = Color4fMake(1, 1, 1, 0);
            shieldBreaker = [[Projectile alloc] initProjectileFrom:Vector2fMake(aEnemy.renderPoint.x - 30, aEnemy.renderPoint.y + 500) to:Vector2fMake(aEnemy.renderPoint.x - 30, aEnemy.renderPoint.y + 20) withImage:@"ShieldBreaker.png" lasting:1 withStartAngle:0 withStartSize:Scale2fMake(1, 1) toFinishSize:Scale2fMake(1, 1)];
            stage = 0;
            duration = 1;
            active = YES;
        } else {
            
            [BattleStringAnimation makeIneffectiveStringAt:aEnemy.renderPoint];
            stage = 4;
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
                    shield.color = Color4fMake(1, 1, 1, 0);
                    brokenShield.color = Color4fMake(1, 1, 1, 1);
                    [target1 youWillTakeDoubleDamage];
                    duration = 0.5;
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
                [shieldBreaker updateWithDelta:aDelta];
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
                [shield renderCenteredAtPoint:shield.renderPoint];
                [shieldBreaker renderProjectiles];
                break;
            case 1:
                [brokenShield renderCenteredAtPoint:brokenShield.renderPoint];
                break;
                
            default:
                break;
        }
    }
}

@end
