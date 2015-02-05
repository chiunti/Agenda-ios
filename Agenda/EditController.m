//
//  EditController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "EditController.h"
#import "DBManager.h"
#import "CustomizedTableViewCell.h"
#import "Defaults.h"

NSMutableArray *maUsers;

@implementation EditController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initController];
    

}

- (void)initController{
    maUsers = [[NSMutableArray alloc] init];
    [[DBManager getSharedInstance] executeQueryWithString:@"select id, photo, name, status, song from users"];
    maUsers = [[DBManager getSharedInstance]getResultArray];
    
    self.btnEliminar.hidden = (currentState != Delete);
    self.btnEditar.hidden   = (currentState != Edit);
    self.navEdit.title = currentState==Delete? @"Eliminar contacto":@"Editar contacto";
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
    self.btnMore.enabled = true;
    self.btnShare.enabled = true;
    
    [[DBManager getSharedInstance]
     executeQueryWithString:@"select id, photo, name, status, song from users where id=?"
     andParams:[[NSMutableArray alloc]
                //                initWithObjects:[[NSNumber alloc] initWithInteger: ] ,
                //                nil]];
                initWithObjects:maUsers[indexPath.row][RECORD_ID], nil]];
    currentRecord = [[DBManager getSharedInstance]getResultArray][0];
    currentRecord[RECORD_IMAGE] = [UIImage imageWithData:currentRecord[RECORD_IMAGE]];
    
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.btnMore.enabled = false;
    self.btnShare.enabled = false;
    
}



- (IBAction)btnEliminarPressed:(id)sender {
}
@end
