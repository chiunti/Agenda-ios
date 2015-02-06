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

UIAlertView *alertError, *alertGuardar;

@implementation NewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initController];
}
-(void)initController
{
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

    alertError = [[UIAlertView alloc] initWithTitle:@"Corregir"
                                       message:@"Verifique que todos los campos tengan datos"
                                      delegate:self
                             cancelButtonTitle:@"Aceptar"
                             otherButtonTitles:nil];
    alertGuardar = [[UIAlertView alloc] initWithTitle:@"Datos guardados"
                                            message:nil
                                           delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:nil];

}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [self.scrollView setContentOffset:CGPointMake(0, kbSize.height) animated:YES];
}
//called when the text field is being edited
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender
{
    sender.delegate = self;
}


// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    CGImageRef cgref = [currentRecord[RECORD_IMAGE] CGImage];
    CIImage    *cim  = [currentRecord[RECORD_IMAGE] CIImage];
    if ( !( cim==nil&&cgref==NULL) ) {
         [self.btnImage setTitle: @"" forState:UIControlStateNormal];
    }
    self.imgPhoto.image = currentRecord[RECORD_IMAGE];
    self.txtName.text   = currentRecord[RECORD_NAME];
    self.txtStatus.text = currentRecord[RECORD_STATUS];
    self.txtSong.text   = currentRecord[RECORD_SONG];
}

- (IBAction)bntSavePressed:(id)sender {
    BOOL showAlert = false;
    CGImageRef cgref = [currentRecord[RECORD_IMAGE] CGImage];
    CIImage    *cim  = [currentRecord[RECORD_IMAGE] CIImage];

    showAlert = (showAlert|| [self.txtName.text length]==0 );
    showAlert = (showAlert|| [self.txtStatus.text length]==0 );
    showAlert = (showAlert|| [self.txtSong.text length]==0 );
    
    if (cim==nil&&cgref==NULL) {
        self.btnImage.layer.borderColor = [[UIColor redColor] CGColor];
        showAlert = true;
    } else {
        self.btnImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    
    if ([self.txtName.text length]==0) {
        showAlert = true;
        self.txtName.layer.borderWidth = 1;
        self.txtName.layer.borderColor = [[UIColor redColor] CGColor];
    } else {
        self.txtName.layer.borderWidth = 0;
    }
    if ([self.txtStatus.text length]==0) {
        showAlert = true;
        self.txtStatus.layer.borderWidth = 1;
        self.txtStatus.layer.borderColor = [[UIColor redColor] CGColor];
    } else {
        self.txtStatus.layer.borderWidth = 0;
    }
    if ([self.txtSong.text length]==0) {
        showAlert = true;
        self.txtSong.layer.borderWidth = 1;
        self.txtSong.layer.borderColor = [[UIColor redColor] CGColor];
    } else {
        self.txtSong.layer.borderWidth = 0;
    }
    
    
    if (showAlert) {
        [alertError show];
        return;
    }
    
    
    if (currentState == Insert) {
        [[DBManager getSharedInstance]
         executeQueryWithString:@"insert into users (name, status, song, photo) values (?,?,?,?)"          andParams:[[NSMutableArray alloc]
                    initWithObjects:self.txtName.text,
                    self.txtStatus.text,
                    self.txtSong.text,
                    UIImagePNGRepresentation(self.imgPhoto.image),
                    nil]];
    } else {
        [[DBManager getSharedInstance]
         executeQueryWithString:@"update users set name=?, status=?, song=?, photo=? where id=?"
         andParams:[[NSMutableArray alloc]
                    initWithObjects:self.txtName.text,
                    self.txtStatus.text,
                    self.txtSong.text,
                    UIImagePNGRepresentation(self.imgPhoto.image),
                    currentRecord[RECORD_ID],
                    nil]];
        [[DBManager getSharedInstance]
         executeQueryWithString:@"select id, photo, name, status, song from users where id=?"
         andParams:[[NSMutableArray alloc]
                    initWithObjects:currentRecord[RECORD_ID],
                    nil]];
        currentRecord = [[DBManager getSharedInstance]getResultArray][0];
    }
    

    [self dismissViewControllerAnimated:YES completion:nil];
    [alertGuardar show];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(dismissAlert) userInfo:nil repeats:false];
}

-(void)dismissAlert
{
    [alertGuardar dismissWithClickedButtonIndex:0 animated:YES];
}
@end
