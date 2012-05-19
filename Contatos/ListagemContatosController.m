//
//  ListagemContatosController.m
//  ContatosIP67
//
//  Created by ios2736 on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListagemContatosController.h"
#import "Contato.h"
#import "EditarContatosController.h"

@implementation ListagemContatosController

@synthesize contatos;
@synthesize contatoSelecionado;

// metodo para executar logica depois que o tela for carregada
-(void) viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Contatos";
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc ]
        initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:longPress];
    
    
    UIBarButtonItem *adicionar = [[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(mostraFormContato)];
    
    self.navigationItem.rightBarButtonItem = adicionar;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
   
    
}

-(void) exibeMaisAcoes: ( UIGestureRecognizer *) gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:point];
        
        Contato *contato = [contatos objectAtIndex:index.row];
        
        contatoSelecionado = contato;
        
        // opcoes que aparecem na tela quando o usuario segura o botao
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Eamil", @"Visualizar Site", @"Enviar Mensagem" ,@"Abrir Mapa" , nil];
        
        [opcoes showInView:self.view];
        
        //UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"Contato selecionado :" message://[contato nome] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        
        //[alert show];
    }
}


-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init ];
    picker.delegate = self;
    picker.allowsEditing = YES;
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self abrirSite];
            break;
        case 3:
            [self enviarMensagem];
            break;
        case 4:
            [self mostrarMapa];
            break;
        default:
            break;
    }
}

-(void) abrirApplicationComURL:(NSString *)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void) ligar {
    UIDevice *device = [UIDevice currentDevice];
    if ([device.model isEqualToString:@"IPhone"]) {
        NSString *numero = [NSString stringWithFormat:@"tel:%@", contatoSelecionado.telefone];
        
        [self abrirApplicationComURL:numero];
    } else {
        [[[UIAlertView alloc ]initWithTitle:@"Impossivel fazer ligacao :" message:@"seu dispositivo nao e um Iphone" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]; 
    }
}


-(void) abrirSite {
    NSString *url = contatoSelecionado.site;
    [self abrirApplicationComURL:url];
}

-(void) mostrarMapa {
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self abrirApplicationComURL:url];
}


-(void) enviarEmail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *enviadorEamil = [[MFMailComposeViewController alloc ]init];
        enviadorEamil.mailComposeDelegate = self;
        
        [enviadorEamil setToRecipients:[NSArray arrayWithObject:contatoSelecionado.email]];
        [enviadorEamil setSubject:@"Caelum"];
        
        [self presentModalViewController:enviadorEamil animated:YES];
    } else {
        [[[UIAlertView alloc ]initWithTitle:@"Ops :" message:@" voce nao pode enviar email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]; 
    }
}

-(void) enviarMensagem {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *enviadorMsg = [[MFMessageComposeViewController alloc ] init];
    
        enviadorMsg.messageComposeDelegate = self;
        [ self presentModalViewController:enviadorMsg animated:YES];
    } else {
        [[[UIAlertView alloc ]initWithTitle:@"Impossivel mandar mensagem :" message:@"seu dispositivo nao possui aplicativo para envio de mensagens" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]; 
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) mostraFormContato {
    
    //UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"Botao Clicado!" message:@"Isso e um UIAlertView" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    
    //[alert show];
    
    FormularioContatoController *formularioContatos = [[FormularioContatoController alloc] initWithNibName:@"FormularioContatoController" bundle:[NSBundle mainBundle]];
    
    formularioContatos.delegate = self;
    
    UINavigationController * navigationController = [[UINavigationController alloc ] initWithRootViewController:formularioContatos];
    
    
    [self presentModalViewController:navigationController animated:YES];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contatos count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:
                                      UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Contato *c = [contatos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = c.nome;
    cell.detailTextLabel.text = c.email;
    
    return cell;
}


-(void) contatoAdicionado:(Contato *)contato {
    [contatos addObject:contato];
    [self.tableView reloadData];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [contatos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *) destinationIndexPath {
    
    Contato *c = [contatos objectAtIndex:sourceIndexPath.row];
    
    [contatos removeObjectAtIndex:sourceIndexPath.row];
    
    [contatos insertObject:c atIndex:destinationIndexPath.row];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Contato *c = [contatos objectAtIndex:indexPath.row];
    EditarContatosController *editarContatos= [[EditarContatosController alloc] initWithContato:c];
    
    editarContatos.delegate = self;
    
    [self.navigationController pushViewController:editarContatos animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) contatoAlteradoSucesso {
    [self.tableView reloadData];
}


@end
