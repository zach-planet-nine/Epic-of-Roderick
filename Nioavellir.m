//
//  Nioavellir.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/7/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Nioavellir.h"
#import "GameController.h"
#import "InputManager.h"
#import "SoundManager.h"
#import "FontManager.h"
#import "ScriptReader.h"
#import "TiledMap.h"
#import "Image.h"
#import "PackedSpriteSheet.h"
#import "SpriteSheet.h"
#import "FadeInOrOut.h"
#import "AbstractEntity.h"

@implementation Nioavellir

- (id)init
{
    self = [super init];
    if (self) {
        
        battleImage = [[Image alloc] initWithImageNamed:@"AlfheimBackground.png" filter:GL_NEAREST];
        battleFont = [sharedFontManager getFontWithKey:@"battleFont"];
        sceneMap = [[TiledMap alloc] initWithFileName:@"Nioavellir" fileExtension:@"tmx"];
        cutScene = YES;
        cutSceneTimer = 0.5;
        [sharedInputManager setState:kNoTouchesAllowed];
        //[FadeInOrOut fadeInWithDuration:2];
        sharedGameController.gameState = kGameState_World;
        sharedGameController.realm = kRealm_Alfheim;
        [self addEntityToActiveEntities:sharedGameController.player];
        [self createCollisionMapArray];
        [self createPortalsArray];
        allowBattles = NO;
        stage = 0;

    }
    
    return self;
}

- (void)updateSceneWithDelta:(float)aDelta {
    [super updateSceneWithDelta:aDelta];
}

- (void)moveToNextStageInScene {
    switch (stage) {
        case 0:
            stage++;
            NSLog(@"Should be getting here.");
            sharedGameController.player.currentLocation = CGPointMake(140, 94.5 * 40);
            sharedGameController.player.currentTile = CGPointMake(3, 94);
            //[FadeInOrOut fadeInWithDuration:2];
            cutSceneTimer = 2;
            [sharedInputManager setState:kNoTouchesAllowed];
            break;
        case 1:
            stage++;
            cutSceneTimer = NO;
            [sharedInputManager setState:kWalkingAround_NoTouches];
            break;
        case 2:
            stage++;
            cutScene = YES;
            cutSceneTimer = 0.5;
            break;
        case 3:
            stage++;
            cutScene = NO;
            [sharedScriptReader createCutScene:19];
            break;
        case 4:
            [sharedScriptReader advanceCutScene];
            break;
            
            
        default:
            break;
    }
}

- (void)createPortalsArray {
    
    portals[8][96] = CGPointMake(99, 2);
    portals[8][95] = CGPointMake(99, 2);
    portals[8][94] = CGPointMake(99, 2);
    portals[8][93] = CGPointMake(99, 2);
    portals[8][92] = CGPointMake(99, 2);

}

- (void)createCollisionMapArray {
    
    int collisionLayerIndex = [sceneMap layerIndexWithName:@"Collisions"];
    Layer *collisionLayer = [[sceneMap layers] objectAtIndex:collisionLayerIndex];
    for (int yy = 0; yy < 100; yy++) {
        for (int xx = 0; xx < 100; xx++) {
            int globalTileId = [collisionLayer globalTileIDAtTile:CGPointMake(xx, yy)];
            if (globalTileId != -1) {
                blocked[xx][yy] = YES;
            }
        }
    }
}




@end
