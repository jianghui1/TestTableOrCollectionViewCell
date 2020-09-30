//
//  TestCollectionViewController.m
//  TestTableOrCollectionViewCell
//
//  Created by jzh on 2020/9/29.
//

#import "TestCollectionViewController.h"

#import "TestCollectionViewCell1.h"
#import "TestCollectionViewCell2.h"
#import "TestCollectionViewCell3.h"
#import "TestCollectionViewCell4.h"
#import "TestCollectionViewCell5.h"
#import "XibCollectionViewCell.h"

@interface TestCollectionViewController ()<UICollectionViewDataSource>

@end

@implementation TestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     - no xib + no register
     1. no xib + register
     1.1 UITableViewCell
     1.2 UITableViewCell [self addSubview:]
     1.3 UITableViewCell [self.contentView addSubview:]
     1.4 UITableViewCell [self addSubview:] [self.contentView addSubview:]
     1.5 UITableViewCell [self.contentView addSubview:] [self addSubview:]
     2. xib
     2.1 xib中没有 contentView
     */
    
    /*
     结果: iOS14
     1
     Cell
     Cell - red
     Cell - contentView - red
     Cell - red - contentView - green
     Cell - contentView - red/green

     2
     Cell - contentView - red
     */
    
    /*
     结果: iOS13
     1
     Cell - contentView
     Cell - contentView - red
     Cell - contentView - red
     Cell - contentView - red/green
     Cell - contentView - red/green
     
     2
     Cell - contentView - red
     */
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 44);
    flowLayout.minimumLineSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    NSArray *cellClasses = @[
        [TestCollectionViewCell1 class],
        [TestCollectionViewCell2 class],
        [TestCollectionViewCell3 class],
        [TestCollectionViewCell4 class],
        [TestCollectionViewCell5 class]
    ];
    for (int i = 0; i < cellClasses.count; i++) {
        Class cellClass = cellClasses[i];
        [collectionView registerClass:cellClass forCellWithReuseIdentifier:[@(i) stringValue]];
    }
    
    NSString *xibS = NSStringFromClass([XibCollectionViewCell class]);
    [collectionView registerNib:[UINib nibWithNibName:xibS bundle:nil] forCellWithReuseIdentifier:xibS];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NSString *cellId = [@(indexPath.row) stringValue];
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            NSString *xibS = NSStringFromClass([XibCollectionViewCell class]);
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:xibS forIndexPath:indexPath];
            return cell;
        }
        default:
            break;
    }
    return nil;
}


@end
