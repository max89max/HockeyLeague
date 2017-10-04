//
//  CustomCellTableViewCell.m
//  HockeyLeague
//
//  Created by Larivière, Maxime on 17-10-04.
//  Copyright © 2017 Larivière, Maxime, Croteau, Samue;. All rights reserved.
//

#import "CustomCellTableViewCell.h"

@implementation CustomCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.textLabel.frame = frame;
}

@end
