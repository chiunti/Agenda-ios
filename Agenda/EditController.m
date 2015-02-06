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
UIAlertView *alert;

@implementation EditController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initController];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [self refreshData];
}

- (void)initController{
    self.navEdit.title = currentState==Delete? @"Eliminar contacto":@"Editar contacto";
}

-(void)refreshData
{
    maUsers = [[NSMutableArray alloc] init];
    [[DBManager getSharedInstance] executeQueryWithString:@"select id, photo, name, status, song from users"];
    maUsers = [[DBManager getSharedInstance]getResultArray];
    [self.tblEdit reloadData];

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
    static NSString *CellIdentifier = @"cellEdit";
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
    [[DBManager getSharedInstance]
     executeQueryWithString:@"select id, photo, name, status, song from users where id=?"
     andParams:[[NSMutableArray alloc]
                initWithObjects:maUsers[indexPath.row][RECORD_ID], nil]];
    currentRecord = [[DBManager getSharedInstance]getResultArray][0];
    currentRecord[RECORD_IMAGE] = [UIImage imageWithData:currentRecord[RECORD_IMAGE]];
    
    if (currentState==Edit) {
        [self performSegueWithIdentifier:@"ListToEdit" sender:self];
    } else {
        
        alert = [[UIAlertView alloc] initWithTitle:@"Eliminar"
                                           message:[NSString stringWithFormat:@"¿Desea eliminar a %@", currentRecord[RECORD_NAME]]
                                          delegate:self
                                 cancelButtonTitle:@"Cancelar"
                                 otherButtonTitles:@"Eliminar", nil];
        [alert show];
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1) {
        // do something here...
        
        if ([[DBManager getSharedInstance]
         executeQueryWithString:@"delete from users where id=?"
         andParams:[[NSMutableArray alloc]
                    initWithObjects:currentRecord[RECORD_ID], nil]]) {
             [self refreshData];
         }
        
    }
}


@end
