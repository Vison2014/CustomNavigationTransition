//
//  ViewController.m
//  CustomNavDemo
//
//  Created by slpay on 03/12/2016.
//  Copyright © 2016 slpay. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "TestViewController.h"

@interface MainViewController ()<UINavigationControllerDelegate>

@end

@implementation MainViewController

- (SLTransitionAnimator *)transition {
    
    if (_transition == nil) {
        _transition = [[SLTransitionAnimator alloc] init];
    }
    
    return _transition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 200, 60)];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"点我" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 200, 60)];
    [button2 setBackgroundColor:[UIColor greenColor]];
    [button2 setTitle:@"另外一个控制器" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(pushTestVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)pushTestVC {
    
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)handleButtonTapped {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
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

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    
    if ([toVC isKindOfClass:[DetailViewController class]] || [fromVC isKindOfClass:[DetailViewController class]]) {
        self.transition.operation = operation;
        return self.transition;
    }
    self.navigationController.delegate = nil;
    return nil;
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if (!self.transition.interactive) {
        return nil;
    }
    return self.transition;
}





@end
