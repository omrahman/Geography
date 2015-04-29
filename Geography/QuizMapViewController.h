//
//  QuizMapViewController.h
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionBank.h"

@interface QuizMapViewController : UIViewController

@property (nonatomic, strong) QuestionBank *questionBank;

- (instancetype)initWithQuestionBank:(QuestionBank *)questionBank;

@end
