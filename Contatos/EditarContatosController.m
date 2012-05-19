//
//  EditarContatosController.m
//  Contatos
//
//  Created by ios2736 on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditarContatosController.h"

@interface EditarContatosController() 
    @property(nonatomic, strong) Contato *contato;

-(void) preencherFormularioContato;
@end



@implementation EditarContatosController

@synthesize contato;

-(id)initWithContato:(Contato *) _contato {
    self = [super initWithNibName:@"FormularioContatoController" bundle:[NSBundle mainBundle]];
    
    if (self) {
        self.contato = _contato;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidLoad
{
    self.title = @"Editar Contato";
    
    UIBarButtonItem *alterar = [[UIBarButtonItem alloc] initWithTitle:@"Alterar" style:UIBarButtonItemStylePlain target:self action:@selector(alterar)];
    
    self.navigationItem.rightBarButtonItem = alterar;
    
    [self preencherFormularioContato];
}


-(void) preencherFormularioContato {
    [self.nome  setText:contato.nome];
    [self.email setText:contato.email];
    [self.endereco setText:contato.endereco];
    [self.site setText:contato.site];
    [self.telefone setText:contato.telefone];
    [self.twiter setText:contato.twiter];
    [self.botaoAdicionaImagem setImage:contato.imagem forState:UIControlStateNormal];
}

-(void) alterar {
    [contato setNome:self.nome.text];
    [contato setEndereco:self.endereco.text];
    [contato setEmail:self.email.text];
    [contato setTelefone:self.telefone.text];
    [contato setSite:self.site.text];
    [contato setTwiter:self.twiter.text];
    [contato setImagem:self.botaoAdicionaImagem.imageView.image];
    
    
    [self.delegate contatoAlteradoSucesso];
    [self.navigationController popViewControllerAnimated:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
