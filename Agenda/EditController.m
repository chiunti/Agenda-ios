//
//  EditController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "EditController.h"
#import "Defaults.h"
@implementation EditController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.btnEliminar.hidden = (currentState != Delete);
    self.btnEditar.hidden   = (currentState != Edit);
    self.navEdit.title = currentState==Delete? @"Eliminar contacto":@"Editar contacto";
}

@end
