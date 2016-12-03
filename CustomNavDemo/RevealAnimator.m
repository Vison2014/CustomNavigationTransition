//
//  RevealAnimator.m
//  CustomNavDemo
//
//  Created by slpay on 03/12/2016.
//  Copyright © 2016 slpay. All rights reserved.
//

#import "RevealAnimator.h"


@interface RevealAnimator()

@end

@implementation RevealAnimator

- (instancetype)init {
    if (self = [super init]) {
        self.operation = UINavigationControllerOperationPush;
    }
    return self;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)ctx {
    
    UIViewController *fromController = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromController.view;
    UIView *toView = toController.view;
    UIView *containerView = ctx.containerView;

    CGRect fromFrame = containerView.frame;
    CGRect toFrame = containerView.frame;
    
    if (self.operation == UINavigationControllerOperationPush) {
        toFrame.origin.y = containerView.bounds.size.height;
        fromFrame.origin.y = -containerView.bounds.size.height;
    }
    else {
        toFrame.origin.y = - containerView.bounds.size.height;
        fromFrame.origin.y = containerView.bounds.size.height;
    }
    
    toView.frame = toFrame;
    [containerView addSubview:toView];
    
    fromView.alpha = 1.0;
    
    NSTimeInterval duration = [self transitionDuration:ctx];
    [UIView animateWithDuration:duration animations:^{
        toView.center = CGPointMake(CGRectGetWidth(containerView.bounds)/2, CGRectGetHeight(containerView.bounds)/2);
        fromView.frame = fromFrame;
        
        fromView.alpha = 0.0;

        
    }completion:^(BOOL finished){
        fromView.alpha = 1.0;
        [ctx completeTransition:!ctx.transitionWasCancelled];
    }];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view.superview];

    CGFloat progress = point.y/200.0;
    
    if ((self.operation == UINavigationControllerOperationPush && progress > 0) ||
        (self.operation == UINavigationControllerOperationPop && progress < 0 )) {
        progress = 0;
    } else {
        progress = MIN(MAX(fabs(progress), 0.01), 0.99);
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (progress < 0.5) {
                [self cancelInteractiveTransition];
            }else{
                [self finishInteractiveTransition];
            }
//            self.interactive = false;
        }
            
            break;
        default:
            break;
    }
    
}


@end
