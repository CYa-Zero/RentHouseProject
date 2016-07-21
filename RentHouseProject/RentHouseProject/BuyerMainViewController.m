//
//  BuyerMainViewController.m
//  RentHouseProject
//
//  Created by Chenyang on 7/21/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "BuyerMainViewController.h"

@interface BuyerMainViewController ()
- (IBAction)type_Action:(id)sender;
- (IBAction)cate_Action:(id)sender;
- (IBAction)loc_Action:(id)sender;
- (IBAction)cost_Action:(id)sender;
- (IBAction)typplot_Action:(id)sender;
- (IBAction)typflat_Action:(id)sender;
- (IBAction)typhouse_Action:(id)sender;
- (IBAction)typoffice_Action:(id)sender;
- (IBAction)typvilla_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *typSub_View;
- (IBAction)typall_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *cateSub_View;
- (IBAction)catebuy_Action:(id)sender;
- (IBAction)caterent_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *locSub_View;
- (IBAction)locconfirm_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *costSub_View;
@property (weak, nonatomic) IBOutlet UITextField *locText;
@property (weak, nonatomic) IBOutlet UITextField *costminText;
@property (weak, nonatomic) IBOutlet UITextField *costmaxText;
- (IBAction)costconfirm_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *Tbl_View;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
- (IBAction)search_Action:(id)sender;
- (IBAction)typboth_Action:(id)sender;

@end

@implementation BuyerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)type_Action:(id)sender {
}

- (IBAction)cate_Action:(id)sender {
}

- (IBAction)loc_Action:(id)sender {
}

- (IBAction)cost_Action:(id)sender {
}

- (IBAction)typplot_Action:(id)sender {
}

- (IBAction)typflat_Action:(id)sender {
}

- (IBAction)typhouse_Action:(id)sender {
}

- (IBAction)typoffice_Action:(id)sender {
}

- (IBAction)typvilla_Action:(id)sender {
}
- (IBAction)typall_Action:(id)sender {
}
- (IBAction)catebuy_Action:(id)sender {
}

- (IBAction)caterent_Action:(id)sender {
}
- (IBAction)locconfirm_Action:(id)sender {
}
- (IBAction)costconfirm_Action:(id)sender {
}
- (IBAction)search_Action:(id)sender {
}

- (IBAction)typboth_Action:(id)sender {
}
@end
