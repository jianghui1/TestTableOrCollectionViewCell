//
//  TestCollectionViewCell4.m
//  TestTableOrCollectionViewCell
//
//  Created by jzh on 2020/9/29.
//

#import "TestCollectionViewCell4.h"

@implementation TestCollectionViewCell4

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 20)];
        label1.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:label1];
    }
    return self;
}


@end
