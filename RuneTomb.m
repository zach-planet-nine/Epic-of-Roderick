//
//  RuneTomb.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/2/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "RuneTomb.h"
#import "GameController.h"
#import "Image.h"
#import "ParticleEmitter.h"
#import "Character.h"
#import "Textbox.h"
#import "InputManager.h"

@implementation RuneTomb

- (void)dealloc {
    
    if (runeTombEmitter) {
        [runeTombEmitter release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initAtLocation:(CGPoint)aLocation withRune:(AbstractRuneDrawingAnimation *)aRune withRuneKey:(NSString *)aKey forCharacter:(Character *)aCharacter withTriggerNextStage:(BOOL)aTrigger {
    
    self = [super init];
    if (self) {
        
        runeTomb = [[Image alloc] initWithImageNamed:@"RuneTomb.png" filter:GL_NEAREST];
        runeTomb.renderPoint = aLocation;
        rune = aRune;
        key = aKey;
        character = aCharacter;
        triggerNextStage = aTrigger;
        runeTombEmitter = [[ParticleEmitter alloc] initParticleEmitterWithFile:@"RuneTombEmitter.pex"];
        runeTombEmitter.sourcePosition = Vector2fMake(aLocation.x, aLocation.y);
        hasGivenRune = NO;
        currentLocation = aLocation;
        currentTile = CGPointMake((int)(aLocation.x / 40), (int)(aLocation.y / 40));
    }
    return self;
}

- (id)initAtTile:(CGPoint)aTile withRune:(AbstractRuneDrawingAnimation *)aRune withRuneKey:(NSString *)aKey forCharacter:(Character *)aCharacter withTriggerNextStage:(BOOL)aTrigger {
    
    return [self initAtLocation:CGPointMake((aTile.x + 0.5) * 40, (aTile.y + 0.5) * 40 + 10) withRune:aRune withRuneKey:aKey forCharacter:aCharacter withTriggerNextStage:aTrigger];
}

- (void)updateWithDelta:(float)aDelta {
    if (fabsf(sharedGameController.player.currentLocation.x - currentLocation.x) < 300 && fabsf(sharedGameController.player.currentLocation.y - currentLocation.y) < 300 && !hasGivenRune) {
        [runeTombEmitter updateWithDelta:aDelta];
    }
}

- (void)render {
    
    if (fabsf(sharedGameController.player.currentLocation.x - currentLocation.x) < 300 && fabsf(sharedGameController.player.currentLocation.y - currentLocation.y) < 300 && !hasGivenRune) {
        [runeTomb renderCenteredAtPoint:runeTomb.renderPoint];
        [runeTombEmitter renderParticles];
    } else {
        [runeTomb renderCenteredAtPoint:runeTomb.renderPoint];
    }
}

- (void)youWereTapped {
    
    if (hasGivenRune) {
        return;
    }
    [character learnRune:rune withKey:key];
    NSString *characterName = [character getNameForCharacter:character.whichCharacter];
    NSString *middle = @" has learned the rune ";
    NSString *tbString = [characterName stringByAppendingString:[[middle stringByAppendingString:key] stringByAppendingString:@"."]];
    [tbString retain];
    NSLog(@"%@", tbString);
    [Textbox centerTextboxWithText:tbString];
    if (triggerNextStage) {
        [sharedInputManager setState:kCutScene_TextboxOnScreen];
        triggerNextStage = NO;
    } else {
        [sharedInputManager setState:kWalkingAround_TextboxOnScreen];
    }
}

@end
