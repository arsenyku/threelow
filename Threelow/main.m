//
//  main.m
//  Threelow
//
//  Created by asu on 2015-08-26.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSArray* dice = @[ 	[[Dice alloc] init],
                        	[[Dice alloc] init],
					        [[Dice alloc] init],
					        [[Dice alloc] init],
					        [[Dice alloc] init]
				        ];
     
        for (int i=0; i<[dice count]; i++) {
            Dice* die = dice[i];
            die.name = [NSString stringWithFormat:@"%d", i+1];
            NSLog(@"Die %@ rolled a %d", die.name, [die roll]);
        }
        
    }
    return 0;
}
