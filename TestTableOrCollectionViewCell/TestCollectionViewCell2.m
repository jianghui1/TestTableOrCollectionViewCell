//
//  TestCollectionViewCell2.m
//  TestTableOrCollectionViewCell
//
//  Created by jzh on 2020/9/29.
//

#import "TestCollectionViewCell2.h"

@implementation TestCollectionViewCell2

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}

@end
