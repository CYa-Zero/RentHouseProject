//
//  MyAnnotation.m
//  RentHouseProject
//
//  Created by Chenyang on 7/24/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dict withIndex:(int)index{
    self = [super init];
    if (self) {
        
        
        self.coordinate = CLLocationCoordinate2DMake([dict[@"Property Latitude"] doubleValue], [dict[@"Property Longitude"] doubleValue]);
        self.title = dict[@"Property Name"];
        self.name = dict[@"Property Name"];
        self.type = dict[@"Property Category"];
        self.annoindex = index;
    }
    return self;
}

@end
