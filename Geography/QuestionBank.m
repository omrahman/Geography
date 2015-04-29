//
//  QuestionBank.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "QuestionBank.h"
#import "QuizMapViewController.h"

@interface QuestionBank ()

@property (nonatomic, strong) NSMutableArray *privateQuestions;
@property (nonatomic, strong) NSMutableArray *alreadyAsked;

@end

@implementation QuestionBank

- (instancetype)init {
    return [self initWithName:@"Default" array:@[] bankType:kCountryBank];
}

// Designated initializer
- (instancetype)initWithName:(NSString *)name
                       array:(NSArray *)array
                    bankType:(BankType)bankType
{
    self = [super init];
    if (self) {
        _privateQuestions = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
        _alreadyAsked = [[NSMutableArray alloc] init];
        _bankType = bankType;
        _name = name;
    }
    return self;
}

- (NSString *)randomQuestion {
    if ([self.privateQuestions count] == 0) {
        return nil;
    }
    int index = arc4random() % [self.privateQuestions count];
    NSString *location = self.privateQuestions[index];
    [self.alreadyAsked insertObject:location atIndex:0];
    [self.privateQuestions removeObjectAtIndex:index];
    return location;
}

- (NSArray *)questions {
    return [self.privateQuestions copy];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    QuestionBank *qb = [[[self class] allocWithZone:zone] initWithName:self.name
                                                                 array:self.privateQuestions
                                                              bankType:self.bankType];
    return qb;
}

@end

