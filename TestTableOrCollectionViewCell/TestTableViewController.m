//
//  TestTableViewController.m
//  TestTableOrCollectionViewCell
//
//  Created by jzh on 2020/9/29.
//

#import "TestTableViewController.h"

#import "TestTableViewCell1.h"
#import "TestTableViewCell2.h"
#import "TestTableViewCell3.h"
#import "TestTableViewCell4.h"
#import "TestTableViewCell5.h"
#import "XibTableViewCell.h"

@interface TestTableViewController ()<UITableViewDataSource>

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     1. no xib + no register
     1.1 UITableViewCell
     1.2 UITableViewCell [self addSubview:]
     1.3 UITableViewCell [self.contentView addSubview:]
     1.4 UITableViewCell [self addSubview:] [self.contentView addSubview:]
     1.5 UITableViewCell [self.contentView addSubview:] [self addSubview:]
     2. no xib + register
     2.1 UITableViewCell
     2.2 UITableViewCell [self addSubview:]
     2.3 UITableViewCell [self.contentView addSubview:]
     2.4 UITableViewCell [self addSubview:] [self.contentView addSubview:]
     2.5 UITableViewCell [self.contentView addSubview:] [self addSubview:]
     3. xib
     3.1 xib中只能在 contentView 中添加视图
     */
    
    /*
     结果: iOS14
     1
     Cell - contentView
     Cell - red - contentView
     Cell - contentView - red
     Cell - red - contentView - green
     Cell - contentView - red/green

     2
     Cell - contentView
     Cell - red - contentView
     Cell - contentView - red
     Cell - red - contentView - green
     Cell - contentView - red/green

     3
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
     Cell - contentView
     Cell - contentView - red
     Cell - contentView - red
     Cell - contentView - red/green
     Cell - contentView - red/green

     3
     Cell - contentView - red
     */
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    [self.view addSubview:tableView];
    
    NSArray *cellClasses = @[
        [TestTableViewCell1 class],
        [TestTableViewCell2 class],
        [TestTableViewCell3 class],
        [TestTableViewCell4 class],
        [TestTableViewCell5 class]
    ];
    for (int i = 0; i < cellClasses.count; i++) {
        Class cellClass = cellClasses[i];
        [tableView registerClass:cellClass forCellReuseIdentifier:[@(i) stringValue]];
    }
    
    NSString *xibS = NSStringFromClass([XibTableViewCell class]);
    [tableView registerNib:[UINib nibWithNibName:xibS bundle:nil] forCellReuseIdentifier:xibS];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NSString *cellId = [@"cellId" stringByAppendingString:[@(indexPath.row) stringValue]];
            Class cellClass = [UITableViewCell class];
            switch (indexPath.row) {
                case 0:
                    // no add subview
                    cellClass = [TestTableViewCell1 class];
                    break;
                case 1:
                    // self add subview
                    cellClass = [TestTableViewCell2 class];
                    break;
                case 2:
                    // self.contentView add subview
                    cellClass = [TestTableViewCell3 class];
                    break;
                case 3:
                    // self add self.contentView add
                    cellClass = [TestTableViewCell4 class];
                    break;
                case 4:
                    // self.contentView add self add
                    cellClass = [TestTableViewCell5 class];
                    break;
                    
                default:
                    break;
            }
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            return cell;
        }
            break;
        case 1:
        {
            NSString *cellId = [@(indexPath.row) stringValue];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            return cell;
        }
            break;
        case 2:
        {
            NSString *xibS = NSStringFromClass([XibTableViewCell class]);
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:xibS];
            return cell;
        }
        default:
            break;
    }
    return nil;
}

@end
