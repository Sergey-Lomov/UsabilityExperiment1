//
//  MapController.h
//  UsabilityExperiment1
//
//  Created by Sergey Lomov on 11/26/15.
//  Copyright © 2015 Sergey Lomov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapController;

@protocol MapConrollerDelegate <NSObject>

@required
- (void)mapController:(MapController *)controller didAcceptPlacemark:(CLPlacemark *)placemark;

@end



@interface MapController : UIViewController

@property (nonatomic, weak) id<MapConrollerDelegate> delegate;

@end


