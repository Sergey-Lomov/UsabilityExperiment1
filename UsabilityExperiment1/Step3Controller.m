//
//  Step3Controller.m
//  UsabilityExperiment1
//
//  Created by Sergey Lomov on 11/26/15.
//  Copyright © 2015 Sergey Lomov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Step3Controller.h"

@interface Step3Controller ()

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@property (nonatomic, weak) IBOutlet UITextField *addressLine1Field;
@property (nonatomic, weak) IBOutlet UITextField *addressLine2Field;
@property (nonatomic, weak) IBOutlet UITextField *countyField;
@property (nonatomic, weak) IBOutlet UITextField *stateField;
@property (nonatomic, weak) IBOutlet UITextField *regionField;
@property (nonatomic, weak) IBOutlet UITextField *cityField;
@property (nonatomic, weak) IBOutlet UITextField *postcodeField;

@end

@implementation Step3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerLabel.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.headerLabel.alpha = 1;
    }];
}

-(void)mapController:(MapController *)controller didAcceptPlacemark:(CLPlacemark *)placemark {
    [self.navigationController popViewControllerAnimated:YES];
    
    NSDictionary *addressDictionary = placemark.addressDictionary;
    if (addressDictionary[@"FormattedAddressLines"]) {
        self.addressLine1Field.text = addressDictionary[@"FormattedAddressLines"][0];
        if ([addressDictionary[@"FormattedAddressLines"] count] > 1)
            self.addressLine2Field.text = addressDictionary[@"FormattedAddressLines"][1];
    }
    
    if (addressDictionary[@"Country"])
        self.countyField.text = addressDictionary[@"Country"];
    
    if (addressDictionary[@"State"])
        self.stateField.text = addressDictionary[@"State"];
    
    if (addressDictionary[@"SubAdministrativeArea"])
        self.regionField.text = addressDictionary[@"SubAdministrativeArea"];
    
    if (addressDictionary[@"City"])
        self.cityField.text = addressDictionary[@"City"];
    
    if (addressDictionary[@"ZIP"])
        self.postcodeField.text = addressDictionary[@"ZIP"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[MapController class]])
        [((MapController *)segue.destinationViewController) setDelegate:self];
}

@end
