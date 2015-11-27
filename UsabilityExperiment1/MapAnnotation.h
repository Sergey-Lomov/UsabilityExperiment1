//
//  MapAnnotation.h
//  UsabilityExperiment1
//
//  Created by Sergey Lomov on 11/26/15.
//  Copyright © 2015 Sergey Lomov. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
