//
//  ContatoProtocol.h
//  Contatos
//
//  Created by ios2736 on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

// como interface em java - estabelecer um contrato

@protocol ContatoProtocol <NSObject>

-(void) contatoAdicionado: (Contato *) contato;

-(void) contatoAlteradoSucesso;

@end
