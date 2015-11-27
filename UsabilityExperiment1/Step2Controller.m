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

@end

@implementation Step2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CardIOUtilities preload];
}

- (IBAction)presentCardScaner:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIO delegate

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
