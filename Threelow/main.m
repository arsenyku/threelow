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
static NSString* const QuitCommand = @"quit";

void print(NSString* text){
    [InputCollector showText:text];
}

void printline(NSString* text){
    [InputCollector showLineWithText:text];
}

void showMainMenu(){
    NSString *prompt = @"\n\n" \
    	"THREELOW - What would you like do next?\n" \
	    "%@ - roll 5 dice\n" \
    	"%@ <n> - hold die with id <n>\n" \
 	   	"%@ - Exit Application\n";
    
    prompt = [NSString stringWithFormat:prompt,
              RollCommand,
              HoldCommand,
              QuitCommand];

    print(prompt);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
     
        InputCollector* inputCollector = [[InputCollector alloc] init];
        GameController* gameController = [[GameController alloc] init];
        
        BOOL stayInInputLoop = YES;
        
        while (stayInInputLoop){
            
            showMainMenu();
            NSString* input = [inputCollector inputForPrompt:@"> " andStoreInHistory:YES];
            input = [[input stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]]
                    lowercaseString];
            
            
            if ([input hasPrefix:RollCommand]) {
                [gameController rollDice];
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
