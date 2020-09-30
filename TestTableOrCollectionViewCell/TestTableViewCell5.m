//
//  TestTableViewCell5.m
//  TestTableOrCollectionViewCell
//
//  Created by jzh on 2020/9/29.
//

#import "TestTableViewCell5.h"

@implementation TestTableViewCell5

// self.contentView add self add
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 20)];
        label1.backgroundColor = [UIColor greenColor];
        [self addSubview:label1];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
