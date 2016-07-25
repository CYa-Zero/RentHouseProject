//
//  MapViewController.h
//  RentHouseProject
//
//  Created by Chenyang on 7/22/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController : UIViewController<MKMapViewDelegate,  CLLocationManagerDelegate>
@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;

@property(nonatomic ,strong) NSArray*informationArray;

@end
