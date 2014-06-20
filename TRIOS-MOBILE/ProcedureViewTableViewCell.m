//
//  ProcedureViewTableViewCell.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/19/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "ProcedureViewTableViewCell.h"

@implementation ProcedureViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
