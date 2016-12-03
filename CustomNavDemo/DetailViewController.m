//
//  DetailViewController.m
//  CustomNavDemo
//
//  Created by slpay on 03/12/2016.
//  Copyright © 2016 slpay. All rights reserved.
//

#import "DetailViewController.h"
#import "RevealAnimator.h"
#import "MainViewController.h"

@interface DetailViewController ()
@property(nonatomic, weak) RevealAnimator *transition;
@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.view.backgroundColor = [UIColor purpleColor];
    
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
