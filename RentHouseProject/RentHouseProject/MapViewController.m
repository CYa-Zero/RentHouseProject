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
    userLocation.title  =@"Current Location";
    _mapView.centerCoordinate = userLocation.coordinate;
    
    //[_mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.3, 0.3)) animated:YES];
    //    如果在ViewDidLoad中调用  添加大头针的话会没有掉落效果  定位结束后再添加大头针才会有掉落效果
    [self loadData];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    /*
     
     * 大头针分两种
     
     * 1. MKPinAnnotationView：他是系统自带的大头针，继承于MKAnnotationView，形状跟棒棒糖类似，可以设置糖的颜色，和显示的时候是否有动画效果
     
     * 2. MKAnnotationView：可以用指定的图片作为大头针的样式，但显示的时候没有动画效果，如果没有给图片的话会什么都不显示
     
     * 3. mapview有个代理方法，当大头针显示在试图上时会调用，可以实现这个方法来自定义大头针的动画效果，我下面写有可以参考一下
     
     * 4. 在这里我为了自定义大头针的样式，使用的是MKAnnotationView
     
     */
    
    
    //    判断是不是用户的大头针数据模型
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc]init];
        //annotationView.image = [UIImage imageNamed:@"acc"];
        
        //        是否允许显示插入视图*********
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    
    CustomPinAnnotationView *annotationView = (CustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"otherAnnotationView"];
    if (annotationView == nil) {
        annotationView = [[CustomPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"otherAnnotationView"];
    }
    MyAnnotation *myAnnotation = annotation;
    switch ([myAnnotation.type intValue]) {
        case 1:
            annotationView.image = [UIImage imageNamed:@"pin"];
            
            break;
        case 2:
            annotationView.image = [UIImage imageNamed:@"pin"];
           
            break;
        default:
            break;
    }
    //UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //annotationView.rightCalloutAccessoryView = rightButton;
    
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
