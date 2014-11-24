//
//  Explosion.m
//  SpaceCalculator
//
//  Created by Kenichi Aramaki on 2014/11/24.
//  Copyright (c) 2014年 Pepsilover. All rights reserved.
//

#import "Explosion.h"

@implementation Explosion

+(SKEmitterNode *)generate {
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"Explosion" ofType:@"sks"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
}

@end
