//
//  FancyTableCell.m
//  FancyTableView
//
//  Created by Mike Keller on 1/30/12.
//  Copyright (c) 2012 Meek Apps. All rights reserved.
//
//  A UITableViewCell subclass that removes/restores textLabel and detailTextLabel shadows while cell is selected/highlighted.

#import "FancyTableCell.h"

@implementation FancyTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)applyLabelDropShadow:(BOOL)applyDropShadow {
    self.textLabel.shadowColor = applyDropShadow ? [UIColor whiteColor] : nil;
	self.detailTextLabel.shadowColor = applyDropShadow ? [UIColor whiteColor] : nil;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self applyLabelDropShadow:!self.highlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self applyLabelDropShadow:!self.selected];
}

@end
