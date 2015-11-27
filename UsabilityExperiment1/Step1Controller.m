//
//  Step1Controller.m
//  UsabilityExperiment1
//
//  Created by Sergey Lomov on 11/26/15.
//  Copyright © 2015 Sergey Lomov. All rights reserved.
//

#import "Step1Controller.h"

@interface Step1Controller ()

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@end

@implementation Step1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerLabel.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.headerLabel.alpha = 1;
    }];
}


@end
