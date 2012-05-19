//
//  FormularioContatoController.h
//  Contatos
//
//  Created by ios2736 on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoProtocol.h"

@interface FormularioContatoController : UIViewController<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nome;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *telefone;

@property (weak, nonatomic) IBOutlet UITextField *endereco;

@property (weak, nonatomic) IBOutlet UITextField *site;

@property(strong, nonatomic) id<ContatoProtocol> delegate; 

@property (weak, nonatomic) IBOutlet UITextField *twiter;

@property (weak, nonatomic) IBOutlet UIButton *botaoAdicionaImagem;
- (IBAction)selecionaFoto:(id)sender;


@end
