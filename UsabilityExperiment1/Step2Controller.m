//
//  Step1Controller.m
//  UsabilityExperiment1
//
//  Created by Sergey Lomov on 11/26/15.
//  Copyright © 2015 Sergey Lomov. All rights reserved.
//

#import "Step2Controller.h"
#import "CardIO.h"

@interface Step2Controller () <CardIOPaymentViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@property (nonatomic, weak) IBOutlet UITextField *cardNumberField;
@property (nonatomic, weak) IBOutlet UITextField *expiretaionMonthField;
@property (nonatomic, weak) IBOutlet UITextField *expiretaionYearField;
@property (nonatomic, weak) IBOutlet UITextField *cvvField;

@end

@implementation Step2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CardIOUtilities preload];
    
    self.headerLabel.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.headerLabel.alpha = 1;
    }];
}

- (IBAction)presentCardScaner:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.collectExpiry = YES;
    scanViewController.scanExpiry = YES;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIO delegate

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (info.cardNumber)
        self.cardNumberField.text = info.cardNumber;
    
    if (info.expiryMonth != 0)
        self.expiretaionMonthField.text = [NSString stringWithFormat:@"%d", info.expiryMonth];
    
    if (info.expiryYear != 0)
        self.expiretaionYearField.text = [NSString stringWithFormat:@"%d", info.expiryYear];
    
    if (info.cvv != 0)
        self.cvvField.text = info.cvv;
}

@end
