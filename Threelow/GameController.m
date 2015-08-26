//
//  GameController.m
//  Threelow
//
//  Created by asu on 2015-08-26.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "GameController.h"
#import "InputCollector.h"
#import "Dice.h"

@implementation GameController

-(instancetype)init{
    self = [super init];
    _heldDice = [[NSMutableDictionary alloc] init];
    _rollableDice = [ @{ 	@"1":[[Dice alloc] initWithName:@"1"],
                    		@"2":[[Dice alloc] initWithName:@"2"],
                    		@"3":[[Dice alloc] initWithName:@"3"],
                    		@"4":[[Dice alloc] initWithName:@"4"],
                    		@"5":[[Dice alloc] initWithName:@"5"]
                       } mutableCopy ];
    return self;
}

-(void)rollDice{
    for (NSString* dieName in self.rollableDice) {
        Dice* die = self.rollableDice[ dieName ];
        [die roll];
    }
}

-(void)showDiceStates{
    [InputCollector showLineWithText:@"\nCurrent Game State"];
    if ([self.rollableDice count] < 1){
        [InputCollector showLineWithText:@"All dice are being HELD."];
    } else {
	    for (NSString* dieName in [self.rollableDice.allKeys sortedArrayUsingSelector:(@selector(isGreaterThan:))] ) {
    	    Dice* die = self.rollableDice[ dieName ];
        	[InputCollector showLineWithText:[NSString stringWithFormat:@"Die %@ shows a %d", die.name, die.currentValue]];
        }
    }

    [InputCollector showLineWithText:@"\n--------"];

    if ([self.heldDice count] < 1){
        [InputCollector showLineWithText:@"No HELD dice"];
    } else {
        for (NSString* dieName in [self.heldDice.allKeys sortedArrayUsingSelector:(@selector(isGreaterThan:))] ) {
            Dice* die = self.heldDice[ dieName ];
            [InputCollector showLineWithText:[NSString stringWithFormat:@"Die %@ shows a %d [HELD]", die.name, die.currentValue] ];
        }
    }

}

-(void)holdDie:(NSString*)dieName{
    Dice* die = self.rollableDice[ dieName ];
    
    if ([dieName isEqualToString:@""]){
        [InputCollector showLineWithText:[NSString stringWithFormat:
                                          @"Please provide the ID of the die to hold."]];
    }
    if (die == nil){
        die = self.heldDice[ dieName ];
        
        if (die == nil){
            [InputCollector showLineWithText:[NSString stringWithFormat:
                                              @"There is no die with ID %@.  No change to game state.", dieName]];
        }else{
            [InputCollector showLineWithText:[NSString stringWithFormat:
                                              @"Die %@ is already held.  No change to game state.", dieName]];            
        }
        
        
    } else {
        [self.rollableDice removeObjectForKey:dieName];
        [self.heldDice setValue:die forKey:die.name];
        [InputCollector showLineWithText:
         	[NSString stringWithFormat:@"Now holding die %@ with value %d",
             						  die.name, die.currentValue]];
    }
}




@end
