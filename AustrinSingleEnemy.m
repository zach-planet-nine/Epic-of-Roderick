//
//  AustrinSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/22/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "AustrinSingleEnemy.h"
#import "GameController.h"
#import "BattleRoderick.h"
#import "AbstractBattleEnemy.h"
#import "Image.h"

@implementation AustrinSingleEnemy

- (void)dealloc {
    
    if (darkCloud) {
        [darkCloud release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy 
{
    self = [super init];
    if (self) {
       
        darkCloud = [[Image alloc] initWithImageNamed:@"DarkCloud.png" filter:GL_NEAREST];
        darkCloud.renderPoint = CGPointMake(-20, aEnemy.renderPoint.y + 80);
        target1 = aEnemy;
        BattleRoderick *roderick = [sharedGameController.battleCharacters objectForKey:@"BattleRoderick"];
        timer = [roderick calculateAustrinDurationTo:aEnemy];
        velocity = Vector2fMake((aEnemy.renderPoint.x + 20) / 2, 0);
        stage = 0;
        duration = 2;
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
                    target1.cannotBeHealed = YES;
                    duration = timer;
                    break;
                case 1:
                    stage++;
                    target1.cannotBeHealed = NO;
                    AbstractBattleEnemy *enemy = target1;
                    enemy.defaultImage.color = Color4fMake(1, 1, 1, 1);
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
                darkCloud.renderPoint = CGPointMake(darkCloud.renderPoint.x + (velocity.x * aDelta), (darkCloud.renderPoint.y) + (5 * sinf(darkCloud.renderPoint.x * 0.2)));
                break;
            case 1:
                stage = stage;
                AbstractBattleEnemy *enemy = target1;
                if (enemy.defaultImage.color.red != 0.3) {
                    enemy.defaultImage.color = Color4fMake(enemy.defaultImage.color.red - aDelta, enemy.defaultImage.color.green - aDelta, enemy.defaultImage.color.blue - aDelta, enemy.defaultImage.color.alpha); 
                    if (enemy.defaultImage.color.red < 0.3) {
                        enemy.defaultImage.color = Color4fMake(0.3, 0.3, 0.3, 1);
                    }
                }
                
            default:
                break;
        }
    }
}

- (void) render {
    
    if (active) {
        [darkCloud renderCenteredAtPoint:darkCloud.renderPoint];
    }
}

@end
