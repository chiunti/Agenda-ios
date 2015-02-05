//
//  NewController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "NewController.h"
#import "Defaults.h"
#import "DBManager.h"

@implementation NewController

-(void)viewDidLoad{
    //self.navNew.title = currentState==Insert?@"Alta Usuario":@"Editar Usuario";
    //[self.btnImage setTitle: (currentState==Insert? @"Foto":@"") forState:UIControlStateNormal];
    if (currentState==Insert) {
        // Nuevo registro
        self.navNew.title = @"Alta Usuario";
        [self.btnImage setTitle: @"Foto" forState:UIControlStateNormal];
        currentRecord = [[NSMutableArray alloc] init];
        [currentRecord addObject:[[NSNumber alloc] initWithInt:0]] ;
        [currentRecord addObject:[[UIImage alloc] init]];
        [currentRecord addObject:@""];
        [currentRecord addObject:@""];
        [currentRecord addObject:@""];
    } else {
        // registro existente
        self.navNew.title = @"Editar Usuario";
        [self.btnImage setTitle: @"" forState:UIControlStateNormal];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.imgPhoto.image = currentRecord[RECORD_IMAGE];
    self.txtName.text   = currentRecord[RECORD_NAME];
    self.txtStatus.text = currentRecord[RECORD_STATUS];
    self.txtSong.text   = currentRecord[RECORD_SONG];
}

- (IBAction)bntSavePressed:(id)sender {
    
    if (currentState == Insert) {
        [[DBManager getSharedInstance]
         executeQueryWithString:@"insert into users (name, status, song, photo) values (?,?,?,?)" intoArray:nil
         andParams:[[NSMutableArray alloc]
                    initWithObjects:self.txtName.text,
                    self.txtStatus.text,
                    self.txtSong.text,
                    UIImagePNGRepresentation(self.imgPhoto.image),
                    nil]];
    } else {
        [[DBManager getSharedInstance]
         executeQueryWithString:@"update users set name=?, status=?, song=?, photo=? where id=?" intoArray:nil
         andParams:[[NSMutableArray alloc]
                    initWithObjects:self.txtName.text,
                    self.txtStatus.text,
                    self.txtSong.text,
                    UIImagePNGRepresentation(self.imgPhoto.image),
                    currentRecord[RECORD_ID],
                    nil]];
        [[DBManager getSharedInstance]
         executeQueryWithString:@"select id, photo, name, status, song from users where id=?" intoArray:currentRecord
         andParams:[[NSMutableArray alloc]
                    initWithObjects:currentRecord[RECORD_ID],
                    nil]];
    }
    

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
