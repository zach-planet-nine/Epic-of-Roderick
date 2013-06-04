//
//  EkwazAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/30/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EkwazAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "AbstractBattleCharacter.h"
#import "BattleWizard.h"
#import "Image.h"

@implementation EkwazAllEnemies

- (void)dealloc {
    
    if (stone) {
        [stone release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        totalDamage = [wizard calculateEkwazTotalDamage];
        stone = [[Image alloc] initWithImageNamed:@"Stone.png" filter:GL_NEAREST];
        stone.scale = Scale2fMake(5, 5);
        stone.renderPoint = CGPointMake(360, 560);
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
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            float tempDamage = totalDamage * (0.7 - (enemy.stoneAffinity / 100));
                            [enemy flashColor:Color4fMake(0.4, 0.1, 0, 1)];
                            [enemy youTookDamage:(int)tempDamage];
                        }
                    }
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
        if (stage == 0) {
            stone.renderPoint = CGPointMake(360, stone.renderPoint.y - (aDelta * 400));
        }
        if (stage == 1) {
            stone.color = Color4fMake(1, 1, 1, stone.color.alpha - (aDelta * 2));
        }
    }
}

- (void)render {
    
    if (active) {
        [stone renderCenteredAtPoint:stone.renderPoint];
    }
}

@end
