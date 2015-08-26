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

static NSString* const RollCommand = @"roll";
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
 	   	"%@ - Exit Application\n";
    
    prompt = [NSString stringWithFormat:prompt,
              RollCommand,
              QuitCommand];

    print(prompt);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSArray* dice = @[ 	[[Dice alloc] initWithName:@"1"],
                        	[[Dice alloc] initWithName:@"2"],
                            [[Dice alloc] initWithName:@"3"],
                            [[Dice alloc] initWithName:@"4"],
                            [[Dice alloc] initWithName:@"5"]
				        ];
     
        InputCollector* inputCollector = [[InputCollector alloc] init];
        
        BOOL stayInInputLoop = YES;
        
        while (stayInInputLoop){
            
            showMainMenu();
            NSString* input = [inputCollector inputForPrompt:@"> " andStoreInHistory:YES];
            input = [[input stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceAndNewlineCharacterSet]]
                    lowercaseString];
            
            
            if ([input hasPrefix:RollCommand]) {
                for (Dice* die in dice) {
                    printline([NSString stringWithFormat:@"Die %@ rolled a %d", die.name, [die roll]]);
                }
                
            } else if ([input hasPrefix:QuitCommand]) {
                print(@"Exiting. Thanks for playing.") ;
                stayInInputLoop = NO;
                break;
            }
            
        }
    }
    return 0;
}
