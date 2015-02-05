//
//  ShowController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "ShowController.h"
#import "DBManager.h"
#import "CustomizedTableViewCell.h"
#import "Defaults.h"


NSMutableArray *maUsers;

@implementation ShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initController{
    maUsers = [[NSMutableArray alloc] init];
[[DBManager getSharedInstance] executeQueryWithString:@"select id, photo, name, status, song from users" intoArray:maUsers];
}

- (IBAction)btnSharePressed:(id)sender {
}

- (IBAction)btnMorePressed:(id)sender {
}

/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [maUsers count];
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//-------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellShow";
    CustomizedTableViewCell *cell = (CustomizedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[CustomizedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSMutableArray *record = maUsers[indexPath.row];
    cell.lblName.text = record[RECORD_NAME];
    cell.lblStatus.text = record[RECORD_STATUS];
    cell.imgPhoto.image = [UIImage imageWithData:record[RECORD_IMAGE]];
    return cell;
}


//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.btnMore.enabled = (indexPath.row>0);
    self.btnShare.enabled = (indexPath.row>0);
    
}

@end
