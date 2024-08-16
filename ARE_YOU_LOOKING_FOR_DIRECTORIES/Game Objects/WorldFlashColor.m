//
//  WorldFlashColor.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 6/16/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "WorldFlashColor.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "Image.h"

@implementation WorldFlashColor

- (void)dealloc {
    
    if (flashPixel) {
        [flashPixel release];
    }
    [super dealloc];
}

+ (void)worldFlashColor:(Color4f)aColor {
    
    WorldFlashColor *wfc = [[WorldFlashColor alloc] initColorFlashWithColor:aColor];
    [[GameController sharedGameController].currentScene addObjectToActiveObjects:wfc];
    [wfc release];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initColorFlashWithColor:(Color4f)aColor {
    
    if (self = [super init]) {
        
        flashPixel = [[Image alloc] initWithImageNamed:@"WhitePixel.png" filter:GL_NEAREST];
        flashPixel.color = aColor;
        flashPixel.scale = Scale2fMake(480, 320);
        duration = 0.1;
        stage = 0;
        active = YES;
    }
    return self;
}

- (void)updateWithDelta:(float)aDelta {
    
    duration -= aDelta;
    if (duration < 0) {
        switch (stage) {
            case 0:
                stage++;
                duration = 0.1;
                break;
            case 1:
                stage++;
                duration = 0.1;
                break;
            case 2:
                stage++;
                duration = 0.1;
                break;
            case 3:
                stage++;
                duration = 0.1;
                break;
            case 4:
                stage++;
                active = NO;
                break;
                
            default:
                break;
        }
    }
}

- (void)render {
    
    if (active && (stage == 0 || stage == 2 || stage == 4)) {
        [flashPixel renderCenteredAtPoint:CGPointMake(240, 160)];
    }
}

@end
