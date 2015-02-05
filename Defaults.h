//
//  Defaults.h
//  Agenda
//
//  Created by Chiunti on 04/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <Foundation/Foundation.h>

// constantes para el arreglo currenRecord

#define RECORD_ID     0
#define RECORD_IMAGE  1
#define RECORD_NAME   2
#define RECORD_STATUS 3
#define RECORD_SONG   4

//definicion de estados de la agenda
typedef enum{Insert,Delete,Edit,Show,Idle} agendaState;

// declaracion de estado de la agenda
agendaState currentState;

// declaracion de arreglo con el registro actual
NSMutableArray *currentRecord;

@interface Defaults : NSObject

@end
