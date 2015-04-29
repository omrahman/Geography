//
//  QuestionBankTableViewCell.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "QuestionBankTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation QuestionBankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.questionBankLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.questionBankLabel.textColor = [UIColor whiteColor];
        self.questionBankLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
        [self addSubview:self.questionBankLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
