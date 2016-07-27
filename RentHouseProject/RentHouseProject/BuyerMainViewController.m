//
//  BuyerMainViewController.m
//  RentHouseProject
//
//  Created by Chenyang on 7/21/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "BuyerMainViewController.h"
#import "MapViewController.h"
#import "MapDetailViewController.h"

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
- (IBAction)costclear_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *typBtn;
@property (weak, nonatomic) IBOutlet UIButton *cateBtn;
@property (weak, nonatomic) IBOutlet UIButton *locBtn;
@property (weak, nonatomic) IBOutlet UIButton *costBtn;
- (IBAction)locate_Action:(id)sender;


@property (strong, nonatomic) NSString *nameStr;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *locationStr;
@property (strong, nonatomic) NSString *cateidStr;
@property (strong, nonatomic) NSArray *resultArray;
@property (strong, nonatomic) NSArray *presentArray;
@property (weak, nonatomic) IBOutlet UILabel *typLbl;
@property (weak, nonatomic) IBOutlet UILabel *cateLbl;
@property (weak, nonatomic) IBOutlet UILabel *locLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;
- (IBAction)locclear_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *costmaxLbl;
- (IBAction)back_Action:(id)sender;

@end

@implementation BuyerMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    _typeStr =@"";
    _cateidStr = @"";
    _locationStr = @"";
    _nameStr = @"";
    _typLbl.text = @"all";
    _cateLbl.text = @"both";
    _locLbl.text = @"all";
    _costLbl.text = @"0";
    _costmaxLbl.text = @"all";
    self.Tbl_View.backgroundColor = [UIColor clearColor];
    [self getResultFromServer];
    [self.Tbl_View reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getResultFromServer {
    NSString *searchStr = [NSString stringWithFormat:@"http://www.rjtmobile.com/realestate/getproperty.php?psearch&pname=%@&pptype=%@&ploc=%@&pcatid=%@",_nameStr,_typeStr,_locationStr,_cateidStr];
    NSLog(@"%@",searchStr);
    NSURL *url = [NSURL URLWithString:searchStr];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Error Information: %@",error);
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_sync(dispatch_get_main_queue(), ^{
            _resultArray = [NSArray arrayWithArray:json];
            _presentArray = _resultArray;
            [_Tbl_View reloadData];
        });
        NSLog(@"%@",_resultArray);
    }]resume];
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
    [_typSub_View setHidden:NO];
    [_cateSub_View setHidden:YES];
    [_locSub_View setHidden:YES];
    [_costSub_View setHidden:YES];
}

- (IBAction)cate_Action:(id)sender {
    [_typSub_View setHidden:YES];
    [_cateSub_View setHidden:NO];
    [_locSub_View setHidden:YES];
    [_costSub_View setHidden:YES];
}

- (IBAction)loc_Action:(id)sender {
    [_typSub_View setHidden:YES];
    [_cateSub_View setHidden:YES];
    [_locSub_View setHidden:NO];
    [_costSub_View setHidden:YES];
}

- (IBAction)cost_Action:(id)sender {
    [_typSub_View setHidden:YES];
    [_cateSub_View setHidden:YES];
    [_locSub_View setHidden:YES];
    [_costSub_View setHidden:NO];
}

- (IBAction)typplot_Action:(id)sender {
    _typLbl.text = @"plot";
    _typeStr = @"plot";
    [_typSub_View setHidden:YES];
    [self getResultFromServer];
}

- (IBAction)typflat_Action:(id)sender {
    _typLbl.text = @"flat";
    _typeStr = @"flat";
    [_typSub_View setHidden:YES];
    [self getResultFromServer];
}

- (IBAction)typhouse_Action:(id)sender {
    _typLbl.text = @"house";
    _typeStr = @"house";
    [_typSub_View setHidden:YES];
    [self getResultFromServer];
}

- (IBAction)typoffice_Action:(id)sender {
    _typLbl.text = @"office";
    _typeStr = @"office";
    [_typSub_View setHidden:YES];
    [self getResultFromServer];
}

- (IBAction)typvilla_Action:(id)sender {
    _typLbl.text = @"villa";
    _typeStr = @"villa";
    [_typSub_View setHidden:YES];
    [self getResultFromServer];
}
- (IBAction)typall_Action:(id)sender {
    _typLbl.text = @"all";
    _typeStr = @"";
    [_typSub_View setHidden:YES];
    [self getResultFromServer];
}
- (IBAction)catebuy_Action:(id)sender {
    _cateLbl.text = @"Buy";
    _cateidStr = @"2";
    [_cateSub_View setHidden:YES];
    [self getResultFromServer];
}

- (IBAction)caterent_Action:(id)sender {
    _cateLbl.text = @"Rent";
    _cateidStr = @"1";
    [_cateSub_View setHidden:YES];
    [self getResultFromServer];
}
- (IBAction)locconfirm_Action:(id)sender {
    _locLbl.text = _locText.text;
    _locationStr = _locText.text;
    [_locSub_View setHidden:YES];
    [self getResultFromServer];

}
- (IBAction)costconfirm_Action:(id)sender {
//    NSArray*prList = [NSExpression expressionForConstantValue:@"Property Cost"];
    NSPredicate *predicateMin = [NSPredicate predicateWithFormat:@"%K >= %@",@"Property Cost",_costminText.text];
    NSPredicate *predicateMax = [NSPredicate predicateWithFormat:@"%K <= %@",@"Property Cost",_costmaxText.text];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicateMin,predicateMax]];
    NSArray*sortArray = _resultArray;
    _presentArray = [sortArray filteredArrayUsingPredicate:predicate];
    [_costSub_View setHidden:YES];
    [_Tbl_View reloadData];
}
- (IBAction)search_Action:(id)sender {
    [_typSub_View setHidden:YES];
    [_cateSub_View setHidden:YES];
    [_locSub_View setHidden:YES];
    [_costSub_View setHidden:YES];
    _nameStr = _searchText.text;
    _costLbl.text = _costminText.text;
    _costmaxLbl.text = _costmaxText.text;
    [self getResultFromServer];
}

- (IBAction)typboth_Action:(id)sender {
    _cateLbl.text = @"both";
    _cateidStr = @"";
    [_cateSub_View setHidden:YES];
    [self getResultFromServer];
}

- (IBAction)costclear_Action:(id)sender {
    _presentArray = _resultArray;
    [_costSub_View setHidden:YES];
    [_Tbl_View reloadData];
}

#pragma -mark Table View Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_presentArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
    cell.textLabel.text = [[_presentArray objectAtIndex:indexPath.row] valueForKey:@"Property Name"];
    cell.backgroundColor = [UIColor clearColor];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MapDetailViewController*controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MapDetailViewController"];
    [controller setDetailArray:_resultArray];
    [controller setDetailindex:indexPath.row];
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma -mark Table View Methods end
- (IBAction)locclear_Action:(id)sender {
    [_locSub_View setHidden:YES];
    _locLbl.text = @"all";
}

- (IBAction)locate_Action:(id)sender {
    MapViewController*controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [controller setInformationArray:_presentArray];
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)back_Action:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
