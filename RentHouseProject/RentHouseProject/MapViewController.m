//
//  MapViewController.m
//  RentHouseProject
//
//  Created by Chenyang on 7/22/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "MyAnnotation.h"
#import "CustomPinAnnotationView.h"
#import "MapDetailViewController.h"
#import "FavlistViewController.h"


@interface MapViewController ()
- (IBAction)fav_Action:(id)sender;
- (IBAction)back_Action:(id)sender;
@property (nonatomic,retain) NSMutableArray *locationArray;
@end

@implementation MapViewController
@synthesize informationArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    _mapView.showsUserLocation = YES;
    [_mapView setMapType:MKMapTypeStandard];
    [_mapView setZoomEnabled:YES];
    [_mapView setScrollEnabled:YES];    // Do any additional setup after loading the view.
    
}

- (void)loadData{
    for (int index = 0;index<[informationArray count];index++) {
        NSDictionary*dict = [informationArray objectAtIndex:index];
        MyAnnotation*myAnnotationModel = [[MyAnnotation alloc] initWithAnnotationModelWithDict:dict withIndex:index];
        [self.locationArray addObject:myAnnotationModel];
    }
    [_mapView addAnnotations:self.locationArray];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MyAnnotation *point = [[MyAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.name = @"Current Location";
    [self.mapView addAnnotation:point];
    _mapView.centerCoordinate = userLocation.coordinate;
    [self loadData];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc]init];
        //annotationView.image = [UIImage imageNamed:@"acc"];
        
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    
    CustomPinAnnotationView *annotationView = (CustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"otherAnnotationView"];
    if (annotationView == nil) {
        annotationView = [[CustomPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"otherAnnotationView"];
    }
    MyAnnotation *myAnnotation = annotation;
    annotationView.image = [UIImage imageNamed:@"pin"];
    annotationView.label.text = myAnnotation.name;
    annotationView.tag = myAnnotation.annoindex;
    return annotationView;
    }

- (void)btn_Action{
    NSLog(@"hehehe");
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
   
    CGRect visibleRect = [mapView annotationVisibleRect];
    for (MKAnnotationView *view in views) {
        
        CGRect endFrame = view.frame;
        CGRect startFrame = endFrame;
        startFrame.origin.y = visibleRect.origin.y - startFrame.size.height;
        view.frame = startFrame;
        [UIView beginAnimations:@"drop" context:NULL];
        [UIView setAnimationDuration:1];
        view.frame = endFrame;
        [UIView commitAnimations];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    MapDetailViewController*controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MapDetailViewController"];
    [controller setDetailArray:informationArray];
    [controller setDetailindex:view.tag];
    
    //[self.navigationController pushViewController:controller animated:YES];
    NSLog(@"%ld",(long)view.tag);
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark lazy load

- (IBAction)fav_Action:(id)sender {
    FavlistViewController*controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FavlistViewController"];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)back_Action:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)locationArray{
    
    if (_locationArray == nil) {
        
        _locationArray = [NSMutableArray new];
        
    }
    return _locationArray;
}

@end
