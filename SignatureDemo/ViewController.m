//
//  ViewController.m
//  SignatureDemo
//
//  Created by GuoWei Li on 2019/6/9.
//  Copyright © 2019 gw. All rights reserved.
//

#import "ViewController.h"
#import "SignaturePopView.h"
#import "SignatureViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.dataSource = @[@"Present Signature Portrait", @"Push Signature Landscape", @"Pop Signature Landscape"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self present];
            break;
        case 1:
            [self push];
            break;
        case 2:
            [self popSignatureView];
            break;
            
        default:
            break;
    }
}

#pragma mark - Action

- (void)present {
    SignatureViewController *signatureVC = [[SignatureViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:signatureVC];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)push {
    SignatureViewController *signatureVC = [[SignatureViewController alloc] init];
    [self.navigationController pushViewController:signatureVC animated:YES];
}

- (void)popSignatureView {
    SignaturePopView *popView = [[SignaturePopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
}



@end
