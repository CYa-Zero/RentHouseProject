//
//  FavDetailViewController.m
//  RentHouseProject
//
//  Created by Chenyang on 7/27/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "FavDetailViewController.h"

@interface FavDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *favimgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;
@property (weak, nonatomic) IBOutlet UILabel *cateLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UILabel *adrLbl;
@property (weak, nonatomic) IBOutlet UILabel *adrLbl2;
- (IBAction)back_Action:(id)sender;

@end

@implementation FavDetailViewController
@synthesize favIndex;
@synthesize favList;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getInformation];
    // Do any additional setup after loading the view.
}

- (void)getInformation{
    _nameLbl.text = [[favList objectAtIndex:favIndex] valueForKey:@"name"];
    _descLbl.text = [[favList objectAtIndex:favIndex] valueForKey:@"desc"];
    _costLbl.text = [[favList objectAtIndex:favIndex] valueForKey:@"cost"];
    _typeLbl.text = [[favList objectAtIndex:favIndex] valueForKey:@"typ"];
    _adrLbl.text = [[favList objectAtIndex:favIndex] valueForKey:@"adr1"];
    _adrLbl2.text = [[favList objectAtIndex:favIndex] valueForKey:@"adr2"];
    if ([[[favList objectAtIndex:favIndex] valueForKey:@"cate"] isEqualToString:@"1"]) {
        _cateLbl.text = @"Rent";
    }
    else if ([[[favList objectAtIndex:favIndex] valueForKey:@"cate"] isEqualToString:@"2"]) {
        _cateLbl.text = @"Outright Purchase";
    }
    else {
        _cateLbl.text = @"Unknown";
    }
    NSString *imgString = [[favList objectAtIndex:favIndex] valueForKey:@"imgurl"];
    NSString *str = @"";
    str = [imgString stringByReplacingOccurrencesOfString:@"\\"                                                withString:@"/"];
    NSString *string = [NSString stringWithFormat:@"http://%@",str];
    NSURL *imgUrl = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    if (data) {
        _favimgView.image = [UIImage imageWithData:data];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_Action:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
