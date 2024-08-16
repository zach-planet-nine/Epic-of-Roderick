//
//  Bats.m
//  TEORWorldMapTest
//
//  Created by Zach Babb on 8/1/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "Bats.h"
#import "GameController.h"
#import "AbstractScene.h"
#import "AbstractBattleCharacter.h"
#import "Image.h"
#import "OverMind.h"
#import "Character.h"
#import "BattleStringAnimation.h"


@implementation Bats

- (void)dealloc {
    
    if (batImage) {
        [batImage release];
    }
    [super dealloc];
}

- (id)init
{
    self = [super initWithBattleLocation:1];
    if (self) {
        
        int index = 0;
        batImage = [[Image alloc] initWithImageNamed:@"Bat.png" filter:GL_NEAREST];
        while (index < 20) {
            Bat aBat;
            aBat.renderPoint = CGPointMake(380 + (RANDOM_MINUS_1_TO_1() * 50), 160 + (RANDOM_MINUS_1_TO_1() * 50));
            aBat.color = Color4fMake(1, 1, 1, 1);
            aBat.rotation = 10 * RANDOM_MINUS_1_TO_1();
            bats[index] = aBat;
            index++;
        }
        state = kEntityState_Alive;
        level = 1;
        hp = 60;
        maxHP = 60;
        essence = 10;
        maxEssence = 10;
        endurance = 15;
        maxEndurance = 15;
        strength = 2;
        stamina = 1;
        agility = 3;
        dexterity = 2;
        power = 1;
        affinity = 1;
        luck = 1;
        batIndex = 0;
        battleTimer = 0.0;
        while (level < partyLevel) {
            [self levelUp];
        }
        hp *= 2;
        maxHP = hp;
        damageThreshold = (int)(maxHP * 0.05);
        experience = 55 * level;
        waterAffinity = skyAffinity = 1;
        damageDealt = 0;
        isAlive = YES;
        ai = EnemyAISet(kAIEnduranceAmount, 5, kAIAnyCharacter, 0, kAIEnemyBite);
        renderPoint = CGPointMake(380, 160);
        defaultImage = batImage;
        defaultImage.color = Color4fMake(1, 1, 1, 1);
    }
    
    return self;
    
}

- (void)updateWithDelta:(float)aDelta {
    
    for (int i = 0; i < 20; i++) {
        if (bats[i].color.alpha < 1 && bats[i].color.alpha != 0) {
            bats[i].color = Color4fMake(1, 1, 1, bats[i].color.alpha - aDelta);
            if (bats[i].color.alpha < 0) {
                bats[i].color = Color4fMake(1, 1, 1, 0);
            }
        }
        if (bats[i].color.alpha > 0) {
            [super updateWithDelta:aDelta];
        }
    }
    [super updateWithDelta:aDelta];
}

- (void)render {
    
    Color4f tempColor = defaultImage.color;
    for (int i = 0; i < 20; i++) {
        if (!isAlive && bats[i].color.alpha != 0) {
            [batImage renderCenteredAtPoint:bats[i].renderPoint scale:Scale2fMake(1, 1) rotation:bats[i].rotation];
        } else if (isAlive) {
            batImage.color = bats[i].color;
            [batImage renderCenteredAtPoint:bats[i].renderPoint scale:Scale2fMake(1, 1) rotation:bats[i].rotation];
        }
    }
    batImage.color = tempColor;
    [super render];
}

- (void)decideWhatToDo {
    
    if ([super canIDoThis:ai]) {
        [self doThis:ai decider:self];
    }
}

- (void)doThis:(EnemyAI)aDecision decider:(AbstractBattleEnemy *)aEnemy {
    
    AbstractBattleCharacter *character = [sharedOverMind anyCharacter];
    [sharedOverMind enemy:self bites:character];
}

- (int)calculateBiteDamageToCharacter:(AbstractBattleCharacter *)aCharacter {
    float biteDamage = ((((strength + strengthModifier + agility + agilityModifier) / 1.8) * 3 - aCharacter.dexterity - aCharacter.dexterityModifier - aCharacter.agility - aCharacter.agilityModifier) * (endurance / maxEndurance));
    biteDamage += arc4random() % (int)(level + levelModifier + 10);
    endurance -= 5 + (level * 0.2);
    biteDamage *= 0.1;
    return (int)biteDamage;
}

- (void)youTookDamage:(int)aDamage {

    int tempDamage = aDamage;
    if (aDamage > hp) {
        NSLog(@"Bats have been killed.");
        [super youTookDamage:aDamage];
        return;
    }
    NSLog(@"This has been called.");
    while (aDamage > 0) {
        if (aDamage > damageThreshold) {
            NSLog(@"Damage is > damageThreshold");
            damageThreshold = (int)(maxHP * 0.05);
            bats[batIndex].color = Color4fMake(1, 1, 1, 0.99);
            batIndex++;
            aDamage -= damageThreshold;
        } else {
            NSLog(@"Damage < damageThreshold");
            damageThreshold -= aDamage;
            aDamage = 0;
        }
    }
    [super youTookDamage:tempDamage];

}

- (CGRect)getRect {
    
    return CGRectMake(350, 50, 100, 160);
}

@end
