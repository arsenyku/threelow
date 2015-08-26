//
//  Dice.m
//  Threelow
//
//  Created by asu on 2015-08-26.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "Dice.h"

@implementation Dice

-(instancetype)init{
    self = [super init];
    _name = @"";
    _currentValue = 1;
    _numberOfSides = 6;
    return self;
}

-(instancetype)initWithName:(NSString*)name{
    self = [super init];
    _name = name;
    _currentValue = 1;
    _numberOfSides = 6;
    return self;
}


-(instancetype)initWithName:(NSString*)name andNumberOfSides:(int)sides{
    self = [super init];
    _name = name;
    _currentValue = 1;
    _numberOfSides = sides;
    return self;
}

-(int)getRandomValueBetweenLow:(int)low andHigh:(int)high{
    int value = arc4random_uniform(high - low + 1);
    value += low;
    return value;
}

-(int)roll{
    _currentValue = [self getRandomValueBetweenLow:1 andHigh:6];
    return self.currentValue;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"Name=%@, Value=%d", _name, _currentValue];
}

@end
