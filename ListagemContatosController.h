//
//  ListagemContatosController.h
//  ContatosIP67
//
//  Created by ios2736 on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface ListagemContatosController : UITableViewController<ContatoProtocol, UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property(strong, nonatomic) Contato *contatoSelecionado;

@property (strong, nonatomic) NSMutableArray *contatos;

-(void) exibeMaisAcoes: ( UIGestureRecognizer *) gesture;

-(void) ligar;
-(void) enviarEmail;
-(void) abrirSite;
-(void) mostrarMapa;
-(void) enviarMensagem; 

@end
