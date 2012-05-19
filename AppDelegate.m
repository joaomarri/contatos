//
//  AppDelegate.m
//  Contatos
//
//  Created by ios2736 on 12/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ListagemContatosController.h"
#import "Contato.h"
@interface AppDelegate()
{
    NSMutableArray *contatos;
    
}

-(void) carregaDoList;
-(void) gravandoNoPlist;

@end

@implementation AppDelegate
@synthesize nav;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self carregaDoList];
    
    ListagemContatosController *listagem = [[ListagemContatosController alloc] init];
    nav = [[UINavigationController alloc] initWithRootViewController:listagem];
    
    listagem.contatos = contatos;
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) carregaDoList {
    
    NSMutableDictionary *arrayDeContatos;
    
    NSString *caminho;
    
    NSString *documentsDir = [  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *arquivo = [NSString stringWithFormat:@"%@/contatos.plist", documentsDir];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:arquivo]) {
        caminho = arquivo;
    } else {
        caminho = [[NSBundle mainBundle] pathForResource:@"contatos" ofType:@"plist"];
    }
    
    arrayDeContatos = [[NSMutableDictionary alloc] initWithContentsOfFile:caminho];
    contatos = [[NSMutableArray alloc] init];
    NSInteger total = arrayDeContatos.count;
    
    for (NSString *key in arrayDeContatos) {
        
        Contato *c = [[Contato alloc] init ];
        
        NSDictionary *d = [arrayDeContatos objectForKey:key];
        
        [c setNome: [d objectForKey:@"nome"]];
        [c setEmail: [d objectForKey:@"email"]];
        [c setTelefone: [d objectForKey:@"telefone"]];
        [c setEndereco: [d objectForKey:@"endereco"]];
        [c setTwiter:[d objectForKey:@"twiter"]];
        [c setSite:[d objectForKey:@"site"]];
        
        NSData *data = [d valueForKey:@"imagem"];
        UIImage *img = [UIImage imageWithData:data];
        [c setImagem: img];
        
        [contatos addObject:c];
    }
     
    
}

-(void) gravandoNoPlist {
    NSMutableDictionary *listaDeContatos = [[NSMutableDictionary alloc] init ];
    
    for (int i =0; i < contatos.count; i++) {
        Contato *contato = [contatos objectAtIndex:i];
        NSMutableDictionary *d = [[NSMutableDictionary alloc] init ];
        
        [d setValue:[contato nome] forKey:@"nome"];
        [d setValue:[contato email] forKey:@"email"];
        [d setValue:[contato telefone] forKey:@"telefone"];
        [d setValue:[contato endereco] forKey:@"endereco"];
        [d setValue:[contato site] forKey:@"site"];
        [d setValue:[contato twiter] forKey:@"twiter"];
        
        UIImage *imagem = [contato imagem];
        NSData *data = UIImageJPEGRepresentation(imagem, 1.0);
        [d setValue:data forKey:@"imagem"];
        
        [listaDeContatos setValue:d forKey:[NSString stringWithFormat:@"%i",i]];
        
    }
        NSString *caminho = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *arquivo = [NSString stringWithFormat:@"%@/contatos.plist", caminho];
        [listaDeContatos writeToFile:arquivo atomically:YES];
}

-(void) applicationWillTerminate:(UIApplication *)application
{
    [self gravandoNoPlist]; 
}

-(void) applicationDidEnterBackground:(UIApplication *)application
{
    [self gravandoNoPlist];
}

@end
