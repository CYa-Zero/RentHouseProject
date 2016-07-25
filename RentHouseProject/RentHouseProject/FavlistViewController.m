//
//  FavlistViewController.m
//  RentHouseProject
//
//  Created by Chenyang on 7/25/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "FavlistViewController.h"
#import "CoreDataTableViewCell.h"
#import "AppDelegate.h"

@interface FavlistViewController ()
- (IBAction)back_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *Tbl_View;
@property (strong, nonatomic) NSArray*presentArray;
@property (strong, nonatomic) NSArray*inforArray;
@end

@implementation FavlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchCoreData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self fetchCoreData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchCoreData{
    NSUserDefaults*defaults = [NSUserDefaults standardUserDefaults];
    NSString*uid = [defaults valueForKey:@"kuserid"];
    AppDelegate*delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext*context=[delegate managedObjectContext];
    NSFetchRequest*fetchrequest=[[NSFetchRequest alloc] initWithEntityName:@"FAVLIST"];
    _inforArray =[[context executeFetchRequest:fetchrequest error:nil]mutableCopy];
    if ([_inforArray count]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",uid];
        _presentArray = [_inforArray filteredArrayUsingPredicate:predicate];
        [_Tbl_View reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_presentArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoreDataTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell"];
    cell.cellNameLbl.text = [[_presentArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.cellDescLbl.text = [[_presentArray objectAtIndex:indexPath.row] valueForKey:@"desc"];
    NSString *imgString = [[_presentArray objectAtIndex:indexPath.row] valueForKey:@"imgurl"];
    NSString *str = @"";
    str = [imgString stringByReplacingOccurrencesOfString:@"\\"                                                withString:@"/"];
    NSString *string = [NSString stringWithFormat:@"http://%@",str];
    NSURL *imgUrl = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    if (data) {
       cell.cellImgView.image = [UIImage imageWithData:data];
    }
    return cell;
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
