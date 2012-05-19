//
//  FormularioContatoController.m
//  Contatos
//
//  Created by ios2736 on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormularioContatoController.h"
#import "Contato.h"
#import "ContatoProtocol.h"

@implementation FormularioContatoController
@synthesize nome;
@synthesize email;
@synthesize telefone;
@synthesize endereco;
@synthesize site;
@synthesize delegate;
@synthesize twiter;
@synthesize botaoAdicionaImagem;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Adicionar Contato";
    UIBarButtonItem *voltar = [[UIBarButtonItem alloc ] initWithTitle:@"voltar" style:UIBarButtonItemStylePlain target:self action:@selector(voltar)];
    
    UIBarButtonItem *adicionar = [[UIBarButtonItem alloc ] initWithTitle:@"adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(adicionar)];
    
    self.navigationItem.rightBarButtonItem = adicionar;
    self.navigationItem.leftBarButtonItem = voltar;
}


-(IBAction) selecionaFoto:(id) sender 
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher biblioteca", nil];
        
        [sheet showInView:self.view];
    } else {
        UIImagePickerController * picker= [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}


-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController * picker= [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    

    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            return;
    }
    
    [self presentModalViewController:picker animated:YES];
}


-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imagemSelecionada = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoAdicionaImagem setImage:imagemSelecionada forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

-(void) voltar {
    [self dismissModalViewControllerAnimated:YES];
}

-(void) adicionar {
    Contato *contato = [[Contato alloc ] init ];
    
    [contato setNome:nome.text];
    [contato setEndereco:endereco.text];
    [contato setEmail:email.text];
    [contato setTelefone:telefone.text];
    [contato setSite:site.text];
    [contato setTwiter:twiter.text];
    
    [delegate contatoAdicionado:contato];
    
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    [self setNome:nil];
    [self setEmail:nil];
    [self setTelefone:nil];
    [self setEndereco:nil];
    [self setSite:nil];
    [self setTwiter:nil];
    [self setBotaoAdicionaImagem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
