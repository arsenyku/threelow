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
static NSString* const ResetCommand = @"reset";
static NSString* const ShowStateCommand = @"showState";
static NSString* const KonamiCommand = @"UUDDLRLRBA";
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

void showMainMenu(BOOL allowRoll){
    NSString *rollAllowedDescription = [NSString stringWithFormat:@"%@ - roll the dice\n", RollCommand];
	NSString *rollNotAllowedDesription = @" --- Select a die to HOLD for this turn or RESET all dice ---\n";

    NSString *rollLine = rollAllowedDescription;
    
    NSString *prompt = @"\n\n" \
    	"THREELOW - What would you like do next?\n\n" \
    	"%@" \
	    "%@ <n> - toggle a die with <id> to be HELD or ROLLABLE\n" \
	    "%@ - makes all the dice ROLLABLE\n"
    	"%@ <n> - show the current dice values\n" \
 	   	"%@ - Exit Application\n";
    
    if (!allowRoll){
        rollLine = rollNotAllowedDesription;
    }
    
    prompt = [NSString stringWithFormat:prompt,
              rollLine,
              HoldCommand,
              ResetCommand,
              ShowStateCommand,
              QuitCommand];

    print(prompt);
    
}

@interface Cheat:NSObject
-(void)winNow;
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
     
        InputCollector* inputCollector = [InputCollector new];
        GameController* gameController = [GameController new];
        GameController* previousGameController = nil;

        [gameController showGameState];
        
        BOOL stayInInputLoop = YES;

        while (stayInInputLoop){
            
            showMainMenu(gameController.rollAllowed);
            
            NSString* input = [inputCollector inputForPrompt:@"> " andStoreInHistory:YES];
            input = [input stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            
            if ([input hasPrefix:RollCommand]) {

                if ([gameController rollAllowed]){
                    [gameController rollDice];
                } else {
                    
                    if ([gameController rollCountSinceReset] > 4)
                        printline(@"You have reached the roll limit.  You must reset all dice.");
  					else if ([gameController mustSelectDieToHold])
	                    printline(@"\nRolling is not allowed at this time.  You MUST choose at least 1 die to hold or reset all dice.");
                
                
                }
                [gameController showGameState];

                
            } else if ([input hasPrefix:HoldCommand]) {
                NSString *dieName = getStringParameterFromInput(input);
                [gameController holdDie:dieName];
                [gameController showGameState];
                
            } else if ([input hasPrefix:ResetCommand]) {
                [gameController resetDice];
                [gameController showGameState];
                
            } else if ([input hasPrefix:ShowStateCommand]) {
                [gameController showGameState];
                
            } else if ([input hasPrefix:QuitCommand]) {
                printline(@"Exiting. Thanks for playing.") ;
                stayInInputLoop = NO;
                break;
            
            } else if ([input hasPrefix:KonamiCommand]){
                Cheat *backdoor = (Cheat*)gameController;
                [backdoor winNow];
                // The Cheat can also be called through:
                // [gameController performSelector:@selector(winNow)];
                
            }
            
            if ( [gameController gameIsOver]){
                printline( [NSString stringWithFormat:@"GAME OVER!  Your score is: %d", gameController.score] );
                previousGameController = gameController;
                gameController = [GameController new];
            }
        
        }
    }
    return 0;
}
