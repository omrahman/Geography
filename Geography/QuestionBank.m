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
    self = [super init];
    if (self) {
        // TODO: Create a designated initializer to handle initting with array
        NSArray *HARDCODED_ARRAY = @[@"United States",
                                     @"China",
                                     @"Germany",
                                     @"Russia",
                                     @"Italy"];
        _privateQuestions = [[NSMutableArray alloc] initWithArray:HARDCODED_ARRAY];
        _alreadyAsked = [[NSMutableArray alloc] init];
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

