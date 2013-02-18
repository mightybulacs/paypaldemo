//
//  PayPalVC.m
//  PayPalDemo
//
//  Created by Romeo Flauta on 2/15/13.
//  Copyright (c) 2013 CodeMagnus. All rights reserved.
//

#import "PayPalVC.h"
#import "PayPal.h"
#import "PayPalPayment.h"
#import "PayPalInvoiceItem.h"
#define SPACING 3.

@interface PayPalVC ()
- (IBAction)retryInit:(id)sender;

@end

@implementation PayPalVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"PayPal Demo";
    y = 2.;
    
    [self addLabelWithText:@"Simple Payment" andButtonWithType:BUTTON_294x43 withAction:@selector(simplePayment)];
    [self addLabelWithText:@"Parallel Payment" andButtonWithType:BUTTON_294x43 withAction:@selector(simplePayment)];
    [self addLabelWithText:@"Chained Payment" andButtonWithType:BUTTON_294x43 withAction:@selector(simplePayment)];
    [self addLabelWithText:@"Preapproval Payment" andButtonWithType:BUTTON_294x43 withAction:@selector(simplePayment)];
    
    self.preApprovalTF = [[UITextField alloc] init];
    self.preApprovalTF.placeholder = @"Preapproval Key";
}



- (void) addLabelWithText:(NSString *)text andButtonWithType:(PayPalButtonType)type withAction:(SEL)action
{
    UIFont *font = [UIFont boldSystemFontOfSize:14.];
    CGSize size = [text sizeWithFont:font];
    
    UIButton *button = [[PayPal getPayPalInst] getPayButtonWithTarget:self andAction:action andButtonType:BUTTON_294x43];
    CGRect frame = button.frame;
    frame.origin.x = round((self.view.frame.size.width - button.frame.size.width) / 2.);
    frame.origin.y = round(y + size.height);
    button.frame = frame;
    [self.view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x, y, size.width, size.height)];
    label.font = font;
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    y+= size.height + frame.size.height + SPACING;
}



- (void)paymentSuccessWithKey:(NSString *)payKey andStatus:(PayPalPaymentStatus)paymentStatus {
    NSString *severity = [[PayPal getPayPalInst].responseMessage objectForKey:@"severity"];
	NSLog(@"severity: %@", severity);
	NSString *category = [[PayPal getPayPalInst].responseMessage objectForKey:@"category"];
	NSLog(@"category: %@", category);
	NSString *errorId = [[PayPal getPayPalInst].responseMessage objectForKey:@"errorId"];
	NSLog(@"errorId: %@", errorId);
	NSString *message = [[PayPal getPayPalInst].responseMessage objectForKey:@"message"];
	NSLog(@"message: %@", message);
}



- (void)paymentFailedWithCorrelationID:(NSString *)correlationID {
    NSString *severity = [[PayPal getPayPalInst].responseMessage objectForKey:@"severity"];
	NSLog(@"severity: %@", severity);
	NSString *category = [[PayPal getPayPalInst].responseMessage objectForKey:@"category"];
	NSLog(@"category: %@", category);
	NSString *errorId = [[PayPal getPayPalInst].responseMessage objectForKey:@"errorId"];
	NSLog(@"errorId: %@", errorId);
	NSString *message = [[PayPal getPayPalInst].responseMessage objectForKey:@"message"];
	NSLog(@"message: %@", message);
}



- (void) simplePayment
{
    [self.preApprovalTF resignFirstResponder];
    [PayPal getPayPalInst].shippingEnabled = TRUE;
    [PayPal getPayPalInst].dynamicAmountUpdateEnabled = TRUE;
    [PayPal getPayPalInst].feePayer = FEEPAYER_EACHRECEIVER;
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.recipient = @"seller_1360898547_biz@gmail.com";
    payment.paymentCurrency = @"USD";
    payment.description = @"Teddy Bear";
    payment.merchantName = @"Joe's Bear Emporium";
    payment.subTotal = [NSDecimalNumber decimalNumberWithString:@"10"];
    
    payment.invoiceData = [[PayPalInvoiceData alloc] init];
    payment.invoiceData.totalShipping = [NSDecimalNumber decimalNumberWithString:@"2"];
    payment.invoiceData.totalTax = [NSDecimalNumber decimalNumberWithString:@"0.35"];
    
    payment.invoiceData.invoiceItems = [NSMutableArray array];
    PayPalInvoiceItem *item = [[PayPalInvoiceItem alloc] init];
    item.totalPrice = payment.subTotal;
    item.name = @"Teddy";
    [payment.invoiceData.invoiceItems addObject:item];
    [[PayPal getPayPalInst] checkoutWithPayment:payment];
}



- (void)paymentCanceled {
    
}



- (void)paymentLibraryExit {

}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)retryInit:(id)sender {
    [PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];
}
@end
