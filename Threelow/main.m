//
//  main.m
//  Threelow
//
//  Created by asu on 2015-08-26.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "InputCollector.h"
#import "GameController.h"

static NSString* const RollCommand = @"roll";
static NSString* const HoldCommand = @"holdDie";
static NSString* const ResetCommand = @"resetDice";
static NSString* const ShowStateCommand = @"showState";
static NSString* const QuitCommand = @"quit";

void print(NSString* text){
    [InputCollector showText:text];
}

void printline(NSString* text){
    [InputCollector showLineWithText:text];
}


NSNumber* stringToNumber(NSString *inputString){
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    return [numberFormatter numberFromString:inputString];
    
}

NSString* getStringParameterFromInput(NSString* input){
    
    NSArray *components = [input componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *result = nil;
    
    if ( [components count] >= 2 ){
        result = components[1];
    }
    
    return result;
    
}


NSNumber* getNumericParameterFromInput(NSString* input){
    
    NSString* stringResult = getStringParameterFromInput(input);
    NSNumber *result = nil;
    
    if ( stringResult != nil ){
        result = stringToNumber(stringResult);
    }
    
    return result;
    
}

void showMainMenu(){
    NSString *prompt = @"\n\n" \
    	"THREELOW - What would you like do next?\n" \
	    "%@ - roll 5 dice\n" \
	    "%@ <n> - toggle a die with <id> to be HELD or ROLLABLE\n" \
	    "%@ - makes all the dice ROLLABLE\n"
    	"%@ <n> - show the current dice values\n" \
 	   	"%@ - Exit Application\n";
    
    prompt = [NSString stringWithFormat:prompt,
              RollCommand,
              HoldCommand,
              ResetCommand,
              ShowStateCommand,
              QuitCommand];

    print(prompt);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
     
        InputCollector* inputCollector = [[InputCollector alloc] init];
        GameController* gameController = [[GameController alloc] init];

        [gameController rollDice];
        [gameController showDiceStates];
        
        BOOL stayInInputLoop = YES;
        
        while (stayInInputLoop){
            
            showMainMenu();
            NSString* input = [inputCollector inputForPrompt:@"> " andStoreInHistory:YES];
            input = [input stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            
            if ([input hasPrefix:RollCommand]) {
                [gameController rollDice];
                [gameController showDiceStates];
                
            } else if ([input hasPrefix:HoldCommand]) {
                NSString *dieName = getStringParameterFromInput(input);
                [gameController holdDie:dieName];
                [gameController showDiceStates];
                
            } else if ([input hasPrefix:ResetCommand]) {
                [gameController resetDice];
                [gameController showDiceStates];
                
            } else if ([input hasPrefix:ShowStateCommand]) {
                [gameController showDiceStates];
                
            } else if ([input hasPrefix:QuitCommand]) {
                printline(@"Exiting. Thanks for playing.") ;
                stayInInputLoop = NO;
                break;
            }
        
        }
    }
    return 0;
}
