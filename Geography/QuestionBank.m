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
    NSArray *defaultArray = @[@"United States",
                              @"China",
                              @"Germany",
                              @"Russia",
                              @"Italy"];
    return [self initWithName:@"Default" array:defaultArray];
}

// Designated initializer
- (instancetype)initWithName:(NSString *)name
                       array:(NSArray *)array {
    self = [super init];
    if (self) {
        _privateQuestions = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
        _alreadyAsked = [[NSMutableArray alloc] init];
        _name = name;
    }
    return self;
}

- (NSString *)randomQuestion {
    if ([self.privateQuestions count] == 0) {
        [self.delegate questionBankEmpty];
        return @"";
    }
    /*
    if ([self.privateQuestions count] == 0) {
        self.privateQuestions = self.alreadyAsked;
        self.alreadyAsked = [[NSMutableArray alloc] init];
    } */
    int index = arc4random() % [self.privateQuestions count];
    NSString *location = self.privateQuestions[index];
    [self.alreadyAsked insertObject:location atIndex:0];
    [self.privateQuestions removeObjectAtIndex:index];
    return location;
}

- (NSArray *)questions {
    return [self.privateQuestions copy];
}

@end

