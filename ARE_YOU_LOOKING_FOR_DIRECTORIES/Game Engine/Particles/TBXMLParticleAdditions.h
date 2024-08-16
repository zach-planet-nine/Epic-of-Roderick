//
//  TBXMLParticleAdditions.h
//  TEORBattleTest
//
//  Created by Zach Babb on 5/21/11.
//  Copyright 2011 InstantLazer. All rights reserved.
//

#import "TBXML.h"
#import "Global.h"


@interface TBXML (TBXMLParticleAdditions)

- (int)intValueFromChildElementNamed:(NSString *)aName parentElement:(TBXMLElement *)aParentXMLElement;

- (float)floatValueFromChildElementNamed:(NSString *)aName parentElement:(TBXMLElement *)aParentXMLElement;

- (BOOL)boolValueFromChildElementNamed:(NSString *)aName parentElement:(TBXMLElement *)aParentXMLElement;

- (Vector2f)vector2fFromChildElementNamed:(NSString *)aName parentElement:(TBXMLElement *)aParentXMLElement;

- (Color4f)color4fFromChildElementNamed:(NSString *)aName parentElement:(TBXMLElement *)aParentXMLElement;

@end
