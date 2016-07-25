//
//  MapDetailViewController.m
//  RentHouseProject
//
//  Created by Chenyang on 7/24/16.
//  Copyright © 2016 Chenyang. All rights reserved.
//

#import "MapDetailViewController.h"
#import "AppDelegate.h"

@interface MapDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *proname;
@property (weak, nonatomic) IBOutlet UILabel *protype;
@property (weak, nonatomic) IBOutlet UILabel *procost;
@property (weak, nonatomic) IBOutlet UILabel *procate;
@property (weak, nonatomic) IBOutlet UILabel *prodesc;
@property (weak, nonatomic) IBOutlet UILabel *proadr1;
@property (weak, nonatomic) IBOutlet UILabel *proadr2;
@property (weak, nonatomic) IBOutlet UIImageView *proimg;
- (IBAction)back_Action:(id)sender;
- (IBAction)add_Action:(id)sender;
- (IBAction)share_Action:(id)sender;

@end

@implementation MapDetailViewController
@synthesize detailArray;
@synthesize detailindex;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self labelsSet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)labelsSet{
    NSDictionary*dict = [detailArray objectAtIndex:detailindex];
    _proname.text = [dict valueForKey:@"Property Name"];
    _prodesc.text = [dict valueForKey:@"Property Desc"];
    _procost.text = [dict valueForKey:@"Property Cost"];
    _protype.text = [dict valueForKey:@"Property Type"];
    _proadr1.text = [dict valueForKey:@"Property Address1"];
    _proadr2.text = [dict valueForKey:@"Property Address2"];
    if ([[dict valueForKey:@"Property Category"] isEqualToString:@"1"]) {
        _procate.text = @"Rent";
    }
    else if ([[dict valueForKey:@"Property Category"] isEqualToString:@"2"]) {
        _procate.text = @"Outright Purchase";
    }
    else {
        _procate.text = @"Unknown";
    }
    NSString *imgString = [dict valueForKey:@"Property Image 1"];
    NSString *str = @"";
    str = [imgString stringByReplacingOccurrencesOfString:@"\\"                                                withString:@"/"];
    NSString *string = [NSString stringWithFormat:@"http://%@",str];
    NSURL *imgUrl = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    if (data) {
        _proimg.image = [UIImage imageWithData:data];
    }

}


- (IBAction)back_Action:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)add_Action:(id)sender {
    NSDictionary*dict = [detailArray objectAtIndex:detailindex];
    AppDelegate*delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext*context=[delegate managedObjectContext];
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FAVLIST"];
//    [request setPredicate:[NSPredicate predicateWithFormat:@"id = %@", [dict valueForKey:@"Property Id"]]];
//    [request setFetchLimit:1];
//    NSUInteger count = [context countForFetchRequest:request error:nil];
//    if (count == NSNotFound)
//        NSLog(@"Other Error!");
//    else if (count == 0){
    NSManagedObject*listItem=[NSEntityDescription insertNewObjectForEntityForName:@"FAVLIST" inManagedObjectContext:context];
    [listItem setValue:[dict valueForKey:@"Property Id"] forKey:@"id"];
    [listItem setValue:[dict valueForKey:@"Property Address1"] forKey:@"adr1"];
    [listItem setValue:[dict valueForKey:@"Property Address2"] forKey:@"adr2"];
    [listItem setValue:[dict valueForKey:@"Property Cost"] forKey:@"cost"];
    [listItem setValue:[dict valueForKey:@"Property Category"] forKey:@"cate"];
    [listItem setValue:[dict valueForKey:@"Property Desc"] forKey:@"desc"];
    [listItem setValue:[dict valueForKey:@"Property Image 1"] forKey:@"imgurl"];
    [listItem setValue:[dict valueForKey:@"Property Modify Date"] forKey:@"mdate"];
    [listItem setValue:[dict valueForKey:@"Property Name"] forKey:@"name"];
    [listItem setValue:[dict valueForKey:@"Property Published Date"] forKey:@"pdate"];
    [listItem setValue:[dict valueForKey:@"Property Size"] forKey:@"size"];
    [listItem setValue:[dict valueForKey:@"Property Type"] forKey:@"typ"];
    NSUserDefaults*defaults = [NSUserDefaults standardUserDefaults];
    [listItem setValue:[defaults valueForKey:@"kuserid"] forKey:@"uid"];
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Error:%@",error.localizedDescription);
    }else
    {
        NSLog(@"Added Successfully");
    }
//    }
//    else{
//        NSManagedObject*listItem=[NSEntityDescription insertNewObjectForEntityForName:@"FAVLIST" inManagedObjectContext:context];
//        [listItem setValue:[defaults valueForKey:@"kuserid"] forKey:<#(nonnull NSString *)#>]
//        NSLog(@"Already Exist!!!");
//    }
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareContent{
    
    NSString * message = [NSString stringWithFormat:@"Property Name:%@\nProperty Type:%@\nProperty Cost:%@\nProperty Categpry:%@\nProperty Description:%@\nProperty Address:%@\n%@",_proname.text,_protype.text,_procost.text,_procate.text,_prodesc.text,_proadr1.text,_proadr2.text];
    
    UIImage * image = _proimg.image;
    
    NSArray * shareItems = @[message, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
}


- (IBAction)share_Action:(id)sender {
    [self shareContent];
}
@end
