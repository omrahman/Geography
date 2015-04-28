//
//  QuestionBank.h
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBank : NSObject

@property (nonatomic, readonly, copy) NSArray *questions;
@property (nonatomic) id delegate;

- (NSString *)randomQuestion;
- (void)setDelegate:(id)delegate;

@end
