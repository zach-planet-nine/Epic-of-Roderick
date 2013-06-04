//
//  Boobytrap.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/11/11.
//  Copyright (c) 2011 InstantLazer. All rights reserved.
//

#import "Boobytrap.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Projectile.h"
#import "Animation.h"
#import "BattleDwarf.h"
#import "Image.h"
#import "AbstractBattleEnemy.h"

@implementation Boobytrap

@synthesize enemy;

- (void)dealloc {
    
    if (trap) {
        [trap release];
    }
    if (clawTrap) {
        [clawTrap release];
    }
    [super dealloc];
}

+ (void)triggerTrap:(AbstractBattleEnemy *)aEnemy {

    for (Boobytrap *bt in [GameController sharedGameController].currentScene.activeObjects) {
        if ([bt isMemberOfClass:[Boobytrap class]]) {
            if (bt.enemy == aEnemy) {
                [bt trigger];
            }
        }
    }
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy {
    
    self = [super init];
    if (self) {
        enemy = aEnemy;
        BattleDwarf *dwarf = [sharedGameController.battleCharacters objectForKey:@"BattleDwarf"];
        damage = [dwarf calculateTrapDamageTo:enemy];
        trap = [[Projectile alloc] initProjectileFrom:Vector2fMake(dwarf.renderPoint.x + 10, dwarf.renderPoint.y + 15) to:Vector2fMake(enemy.renderPoint.x, enemy.renderPoint.y - 50) withImage:@"ClawTrapOpen.png" lasting:0.5 withStartAngle:25 withStartSize:Scale2fMake(0.2, 0.2) toFinishSize:Scale2fMake(1, 1)];
        Image *trapImage = [[Image alloc] initWithImageNamed:@"ClawTrapOpen.png" filter:GL_NEAREST];
        Image *trapImageClosing = [[Image alloc] initWithImageNamed:@"ClawTrapClosing.png" filter:GL_NEAREST];
        Image *trapImageClosed = [[Image alloc] initWithImageNamed:@"ClawTrapClosed.png" filter:GL_NEAREST];

        clawTrap = [[Animation alloc] init];
        [clawTrap addFrameWithImage:trapImage delay:0.2];
        [clawTrap addFrameWithImage:trapImageClosing delay:0.2];
        [clawTrap addFrameWithImage:trapImageClosed delay:0.2];
        clawTrap.state = kAnimationState_Stopped;
        clawTrap.type = kAnimationType_Once;
        clawTrap.renderPoint = CGPointMake(enemy.renderPoint.x, enemy.renderPoint.y - 50);
        stage = 0;
        duration = 0.5;
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
                    enemy.boobytrapped = YES;
                    duration = 10;
                    break;
                case 1:
                    stage = stage;
                    duration = 10;
                    break;
                case 2:
                    stage++;
                    clawTrap.state = kAnimationState_Running;
                    duration = 0.6;
                    break;
                case 3:
                    stage++;
                    [enemy youTookDamage:damage];
                    duration = 0.5;
                    break;
                case 4:
                    stage++;
                    active = NO;
                    break;
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                [trap updateWithDelta:aDelta];
                break;
            case 3:
                [clawTrap updateWithDelta:aDelta];
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
                [trap renderProjectiles];
                break;
            case 1:
                [clawTrap renderCenteredAtPoint:clawTrap.renderPoint];
                break;
            case 2:
                [clawTrap renderCenteredAtPoint:clawTrap.renderPoint];
                break;
            case 3:
                [clawTrap renderCenteredAtPoint:clawTrap.renderPoint];
                break;
            default:
                break;
        }
    }
}

- (void)trigger {
    stage = 2;
    duration = 0.05;
}

@end
