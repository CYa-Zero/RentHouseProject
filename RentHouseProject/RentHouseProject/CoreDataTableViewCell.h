//
//  CoreDataTableViewCell.h
//  RentHouseProject
//
//  Created by Chenyang on 7/25/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImgView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellDescLbl;

@end
