//
//  EnemySlash.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/14/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EnemySlash.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "Animation.h"
#import "PackedSpriteSheet.h"
#import "Image.h"

@implementation EnemySlash

- (void)dealloc {
    
    if (slash) {
        [slash release];
    }
    [super dealloc];
}

- (id)initFromEnemy:(AbstractBattleEnemy *)aEnemy toCharacter :(AbstractBattleCharacter *)aCharacter
{
    self = [super init];
    if (self) {
        
        target1 = aCharacter;
        damage = [aEnemy calculateSlashDamageToCharacter:aCharacter];
        slash = [[Animation alloc] init];
		[slash addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash180x5.png"] delay:0.05];
		[slash addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash280x5.png"] delay:0.05];
		[slash addFrameWithImage:[sharedGameController.teorPSS imageForKey:@"Slash380x5.png"] delay:0.05];
		slash.state = kAnimationState_Running;
		slash.type = kAnimationType_Once;
		renderPoint = CGPointMake(aCharacter.renderPoint.x, aCharacter.renderPoint.y - 28);
		rotation = 135;
        stage = 10;
        duration = 0.3;
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
                    rotation = 45;
                    renderPoint = CGPointMake(target1.renderPoint.x - 28, target1.renderPoint.y - 28);
                    slash.state = kAnimationState_Stopped;
                    slash.state = kAnimationState_Running;
                    duration = 0.12;
                    break;
                case 1:
                    stage++;
                    [target1 flashColor:Red];
                    [target1 youTookDamage:damage];
                    duration = 1;
                    break;
                case 2:
                    stage++;
                    active = NO;
                    break;
                case 10:
                    stage = 0;
                    duration = 0.12;
                    break;
                default:
                    break;
            }
        }
        if (stage < 2) {
            [slash updateWithDelta:aDelta];
        }
    }
}

- (void)render {
    
    if (active && stage < 2) {
        [slash renderAtPoint:renderPoint scale:Scale2fMake(1, 1) rotation:rotation];
    }
}

@end
