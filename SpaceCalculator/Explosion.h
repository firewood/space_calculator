//
//  Explosion.h
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/24.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

#ifndef SpaceCalculator_Explosion_h
#define SpaceCalculator_Explosion_h

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

// alternative to SKEmitterNode:
@interface Explosion : NSObject

+(SKEmitterNode *)generate;

@end

#endif
