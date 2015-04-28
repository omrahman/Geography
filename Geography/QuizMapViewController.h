//
//  QuizMapViewController.h
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionBank.h"

@protocol QuestionBankDelegate <NSObject>

@required
- (void)questionBankEmpty;

@end


@interface QuizMapViewController : UIViewController <QuestionBankDelegate>

@property (nonatomic, strong) QuestionBank *questionBank;

@end
