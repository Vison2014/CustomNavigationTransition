//
//  ViewController.h
//  CustomNavDemo
//
//  Created by slpay on 03/12/2016.
//  Copyright © 2016 slpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealAnimator.h"

@interface MainViewController : UIViewController

/** transition */
@property (strong ,nonatomic) RevealAnimator *transition;
@end

