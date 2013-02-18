//
//  PayPalVC.h
//  PayPalDemo
//
//  Created by Romeo Flauta on 2/15/13.
//  Copyright (c) 2013 CodeMagnus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPal.h"

@interface PayPalVC : UIViewController <PayPalPaymentDelegate>
{
    @private
    CGFloat y;
}
@property (weak, nonatomic) IBOutlet UITextField *preApprovalTF;

@end
