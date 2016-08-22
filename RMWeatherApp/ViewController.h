//
//  ViewController.h
//  RMWeatherApp
//
//  Created by Student P_02 on 04/08/16.
//  Copyright © 2016 Rahul Mankar. All rights reserved.
//

#define kWeatherAPIKey @"069271c372b80c0cc3c5c0370e67eb2d"


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}


@end

