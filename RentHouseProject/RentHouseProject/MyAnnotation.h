//
//  MyAnnotation.h
//  RentHouseProject
//
//  Created by Chenyang on 7/24/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,retain) NSNumber *type;
@property int annoindex;

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dict withIndex:(int)index;


@end
