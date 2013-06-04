//
//  EhwazSingleEnemy.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 7/8/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "EhwazSingleEnemy.h"
#import "GameController.h"
#import "AbstractBattleEnemy.h"
#import "BattlePriest.h"
#import "Image.h"

@implementation EhwazSingleEnemy 

- (void)dealloc {
    
    if (sleipnir) {
        [sleipnir release];
    }
    [super dealloc];
}

- (id)initToEnemy:(AbstractBattleEnemy *)aEnemy
{
    self = [super init];
    if (self) {
        
        BattlePriest *poet = [sharedGameController.battleCharacters objectForKey:@"BattlePriest"];
        target1 = aEnemy;
        damage = [poet calculateEhwazDamageTo:aEnemy];
        sleipnir = [[Image alloc] initWithImageNamed:@"Sleipnir.png" filter:GL_NEAREST];
        sleipnir.renderPoint = CGPointMake(aEnemy.renderPoint.x - 50, aEnemy.renderPoint.y);
        sleipnir.rotationPoint = CGPointMake(sleipnir.imageSize.width / 2, sleipnir.imageSize.height / 2);
        sleipnir.color = Color4fMake(0, 0, 0, 1);
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
                    break;
                case 1:
                    stage++;
                    duration = 0.3;
                    break;
                case 2:
                    stage++;
                    [target1 youTookDamage:damage];
                    [target1 flashColor:Color4fMake(1, 0.4, 0.4, 1)];
                    duration = 1;
                    break;
                case 3:
                    stage++;
                    active = NO;
                    break;
                    
                default:
                    break;
            }
        }
        switch (stage) {
            case 0:
                sleipnir.color = Color4fMake(sleipnir.color.red + aDelta, sleipnir.color.green + aDelta, sleipnir.color.blue + aDelta, 1);
                break;
            case 1:
                sleipnir.rotation += aDelta * 100;
                break;
            case 2:
                sleipnir.rotation -= aDelta * 100;
                break;
            case 3:
                sleipnir.color = Color4fMake(sleipnir.color.red - aDelta, sleipnir.color.green - aDelta, sleipnir.color.blue - aDelta, sleipnir.color.alpha - aDelta);
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active) {
        [sleipnir renderCenteredAtPoint:sleipnir.renderPoint];
    }
}

@end
