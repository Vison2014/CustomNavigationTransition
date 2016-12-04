//
//  DetailViewController.m
//  CustomNavDemo
//
//  Created by slpay on 03/12/2016.
//  Copyright © 2016 slpay. All rights reserved.
//

#import "DetailViewController.h"
#import "SLTransitionAnimator.h"
#import "MainViewController.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, weak) SLTransitionAnimator *transition;

/** xxx */
@property (weak ,nonatomic) UITableView *tableView;


@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 200, 60)];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"回去" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    MainViewController *masterVc = self.navigationController.viewControllers.firstObject;
    if (masterVc) {
        self.transition = masterVc.transition;
    }
}

- (void)handleButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)didPan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.transition.interactive = true;
            [self handleButtonTapped];
            break;
        default:
            [self.transition handlePan:pan];
            break;
    }
}



#pragma mark - tableView的数据源和代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"😁😀😀哈哈%zd",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -64) {
        
    }
}


//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    NSLog(@"DetailViewController的viewDidAppear:%@,他的父视图:%@",NSStringFromCGRect(self.view.frame),self.view.superview);
//    
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
//    NSLog(@"DetailViewController的viewDidDisappear:%@，他的父亲视图:%@",NSStringFromCGRect(self.view.frame),self.view.superview);
//    
//}


@end
