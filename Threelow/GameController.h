//
//  GameController.h
//  Threelow
//
//  Created by asu on 2015-08-26.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InputCollector.h"

@interface GameController : NSObject

@property (nonatomic, strong) NSMutableDictionary *heldDice;
@property (nonatomic, strong) NSMutableDictionary *rollableDice;

-(void)rollDice;
-(void)showDiceStates;
-(void)holdDie:(NSString*)dieName;
-(void)resetDice;
@end
