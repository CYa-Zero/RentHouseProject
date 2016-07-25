//
//  CustomPinAnnotationView.h
//  RentHouseProject
//
//  Created by Chenyang on 7/24/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface CustomPinAnnotationView : MKAnnotationView
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *viewBtn;


@end
