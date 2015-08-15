//
//  SpotLight.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//
/** Degrees to Radian **/
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

/** Radians to Degrees **/
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

#import "SpotLight.h"
#import "GameScene.h"

@implementation SpotLight

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setName:@"spotlight"];

        [self setSize:CGSizeMake(self.size.width, WIDTH/2)];
        [self setScale:SCALER];
        light = [[SKLightNode alloc] init];
        light.categoryBitMask = 1;
        light.falloff = 1;
        light.ambientColor = [UIColor whiteColor];
        light.lightColor = [[UIColor alloc] initWithRed:1.0 green:1.0 blue:0.1 alpha:1];
        light.shadowColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.1 alpha:0.3];
        //[self addChild:light];
        
        [self setAnchorPoint:CGPointMake(0.55, 0)];
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:self.size center:CGPointMake(self.size.width*(self.anchorPoint.x-0.5f), self.size.height*(0.5f-self.anchorPoint.y))]];
        [self.physicsBody setAffectedByGravity:NO];
        [self.physicsBody setDynamic:NO];
        [self.physicsBody setUsesPreciseCollisionDetection:YES];
        
        [self.physicsBody setCategoryBitMask:SPOT_LIGHT]; // This is a spotlight
        [self.physicsBody setCollisionBitMask:0];
        [self.physicsBody setContactTestBitMask:SHIP];    //we test for contact with ships
        [self setZPosition:1];
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction scaleYTo:1.5 duration:2],[SKAction waitForDuration:1],[SKAction scaleYTo:0.1 duration:2]]]]];
        
    }
    return self;
}

- (void)rotateToAngle:(float)angle {
    angle = degreesToRadians(angle);
    
    [self runAction:[SKAction rotateToAngle:angle duration:0.1f]];
}

@end
