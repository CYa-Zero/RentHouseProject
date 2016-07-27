//
//  CustomPinAnnotationView.m
//  RentHouseProject
//
//  Created by Chenyang on 7/24/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "CustomPinAnnotationView.h"

@implementation CustomPinAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(-9, -20, 50, 20)];
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.label];
    }
    return self;
    
}

- (void)btn_Action:(UIButton*)sender{
    NSLog(@"%litest",(long)sender.tag);
}

@end
