//
//  MapController.m
//  UsabilityExperiment1
//
//  Created by Sergey Lomov on 11/26/15.
//  Copyright © 2015 Sergey Lomov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import "MapController.h"

@interface MapController () <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIButton *helpButton;
@property (nonatomic, weak) IBOutlet UIView *helpView;
@property (nonatomic, weak) IBOutlet UIView *helpBackgroundView;
@property (nonatomic, weak) IBOutlet UILabel *currentLocationLabel;

@property (nonatomic, strong) MapAnnotation *annotation;
@property (nonatomic, assign) BOOL animationPlaying;
@property (nonatomic, strong) CLPlacemark *currentPlacemark;

@end

@implementation MapController

static double animationDuration = 1.0;

@synthesize mapView;
@synthesize helpButton;
@synthesize helpView;
@synthesize helpBackgroundView;
@synthesize currentLocationLabel;
@synthesize annotation;
@synthesize animationPlaying;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    annotation = [[MapAnnotation alloc] init];
    
    mapView.showsCompass = NO;
    
    helpButton.layer.cornerRadius = helpButton.frame.size.width / 2;
    
    helpView.hidden = YES;
    helpView.alpha = 0;
    helpBackgroundView.hidden = YES;
    
    helpView.layer.cornerRadius = 20;
    currentLocationLabel.layer.cornerRadius = 20;
    
    animationPlaying = NO;
}

- (void)acceptLocation {
    [self.delegate mapController:self didAcceptPlacemark:self.currentPlacemark];
}

- (void)setCurrentPlacemark:(CLPlacemark *)currentPlacemark {
    _currentPlacemark = currentPlacemark;
    
    if (currentPlacemark != nil && self.navigationItem.rightBarButtonItem == nil) {
        UIBarButtonItem *accept = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Accept", nil)
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(acceptLocation)];
        self.navigationItem.rightBarButtonItem = accept;
    }
    else if (currentPlacemark == nil && self.navigationItem.rightBarButtonItem != nil)
        self.navigationItem.rightBarButtonItem = nil;
}

- (IBAction)handleLongTap:(UIGestureRecognizer *)sender {
    if (![mapView.annotations containsObject:annotation])
        [mapView addAnnotation:annotation];
    
    CGPoint point = [sender locationInView:mapView];
    annotation.coordinate = [mapView convertPoint:point toCoordinateFromView:mapView];
    
    CLGeocoder *geo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
    [geo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  if (error == nil) {
                      CLPlacemark *placemark = [placemarks objectAtIndex:0];
                      NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                      currentLocationLabel.text = locatedAt;
                      self.currentPlacemark = placemark;
                  }
                  else {
                      currentLocationLabel.text = NSLocalizedString(@"Sorry, could not locate", nil);
                  }
              }];
}

- (IBAction)showHelp:(id)sender {
    if (animationPlaying)
        return;
    
    animationPlaying = YES;
    
    helpView.hidden = NO;
    [UIView animateWithDuration:animationDuration animations:^(void) {
        helpView.alpha = 1;
    } completion:^(BOOL finished) {
        helpBackgroundView.hidden = NO;
        animationPlaying = NO;
    }];
}

- (IBAction)hideHelp:(id)sender {
    if (animationPlaying)
        return;
    
    animationPlaying = YES;
    
    helpBackgroundView.hidden = YES;
    [UIView animateWithDuration:animationDuration animations:^(void) {
        helpView.alpha = 0;
    } completion:^(BOOL finished) {
        helpView.hidden = YES;
        animationPlaying = NO;
    }];

}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [self.mapView deselectAnnotation:annotation animated:YES];
}

@end
