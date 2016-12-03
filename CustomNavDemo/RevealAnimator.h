//
//  RevealAnimator.h
//  CustomNavDemo
//
//  Created by slpay on 03/12/2016.
//  Copyright © 2016 slpay. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RevealAnimator : UIPercentDrivenInteractiveTransition<UIViewControllerAnimatedTransitioning>



/**  */
@property (assign ,nonatomic) UINavigationControllerOperation operation;



//@property(nonatomic, assign) BOOL interactive;

- (void)handlePan:(UIPanGestureRecognizer *)pan;



@end
