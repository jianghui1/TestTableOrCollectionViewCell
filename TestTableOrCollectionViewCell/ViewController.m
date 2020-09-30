//
//  ViewController.m
//  TestTableOrCollectionViewCell
//
//  Created by jzh on 2020/9/29.
//

#import "ViewController.h"

#import "TestTableViewController.h"
#import "TestCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)toTableViewAction:(id)sender {
    [self.navigationController pushViewController:[TestTableViewController new] animated:YES];
}

- (IBAction)toCollectionViewAction:(id)sender {
    [self.navigationController pushViewController:[TestCollectionViewController new] animated:YES];
}


@end
