//
//  RaidhoAllEnemies.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/27/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RaidhoAllEnemies.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleEnemy.h"
#import "BattleWizard.h"
#import "Image.h"
#import "WorldFlashColor.h"

@implementation RaidhoAllEnemies 

- (void)dealloc {
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        BattleWizard *wizard = [sharedGameController.battleCharacters objectForKey:@"BattleWizard"];
        int enemyIndex = 0;
        for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
            if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                slothRolls[enemyIndex] = [wizard calculateRaidhoSlothRollTo:enemy];
                enemyIndex++;
            }
        }
        sloth = [[Image alloc] initWithImageNamed:@"Sloth.png" filter:GL_LINEAR];
        sloth.renderPoint = CGPointMake(240, 420);
        sloth.scale = Scale2fMake(0.5, 0.5);
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
                    WorldFlashColor *wfc = [[WorldFlashColor alloc] initColorFlashWithColor:Color4fMake(1, 1, 0, 0.4)];
                    [sharedGameController.currentScene addObjectToActiveObjects:wfc];
                    [wfc release];
                    int enemyIndex = 0;
                    for (AbstractBattleEnemy *enemy in sharedGameController.currentScene.activeEntities) {
                        if ([enemy isKindOfClass:[AbstractBattleEnemy class]]) {
                            [enemy youWereSlothed:slothRolls[enemyIndex]];
                            enemyIndex++;
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
        switch (stage) {
            case 0:
                sloth.renderPoint = CGPointMake(240, sloth.renderPoint.y - (aDelta * 360));
                sloth.scale = Scale2fMake(sloth.scale.x + aDelta, sloth.scale.y + aDelta);
                break;
            case 1:
                sloth.color = Color4fMake(1, 1, 1, sloth.color.alpha - aDelta);
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [sloth renderCenteredAtPoint:sloth.renderPoint];
    }
}

@end
