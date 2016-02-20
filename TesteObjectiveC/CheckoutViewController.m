//
//  CheckoutViewController.m
//  TesteObjectiveC
//
//  Created by Tamyres Freitas on 2/3/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

#import "CheckoutViewController.h"
#import <Firebase/Firebase.h>

@interface CheckoutViewController ()


@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *nomeTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UITextField *mesTextField;
@property (weak, nonatomic) IBOutlet UITextField *anoTextField;
@property (weak, nonatomic) IBOutlet UIButton *comprarButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;


@end

@implementation CheckoutViewController

@synthesize precoLabel;
@synthesize precoName;
@synthesize segmentControl;

NSString *cardNumber;
NSString *nome;
NSString *cvv;
NSString *mes;
NSString *ano;
NSString *preco;
NSString *productName;
NSString *bandeira;
NSString *tipo;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    precoLabel.text = precoName;
    self.cardNumberTextField.delegate = self;
    self.nomeTextField.delegate = self;
    self.cvvTextField.delegate = self;
    self.mesTextField.delegate = self;
    self.anoTextField.delegate = self;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    
    
    
    
    
    // fechar teclado com toque
    UITapGestureRecognizer *dismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    dismissKeyboard.cancelsTouchesInView = NO;
    
    

    }


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField becomeFirstResponder];
    [textField resignFirstResponder];
    
    return true;
}

-(void) dismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    
    [self.view endEditing:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text == self.mesTextField.text) {
        
        
        if (textField.text.length >= 2 && range.length == 0)
            return NO;
        return YES;
    }
    
    else if (textField.text == self.anoTextField.text) {
        
        
        if (textField.text.length >= 4 && range.length == 0)
            return NO;
        return YES;
    }
    
    else if (textField.text == self.cardNumberTextField.text) {
        
        
        if (textField.text.length >= 16 && range.length == 0)
            return NO;
        return YES;
    }
 
    else if (textField.text == self.nomeTextField.text) {
        
        return YES;
    }
 
    else if (textField.text == self.cvvTextField.text) {
        
        
        if (textField.text.length >= 3 && range.length == 0)
            return NO;
        return YES;
    }
    else {
        return YES;
    }
}




- (IBAction)comprarTapped:(id)sender {
    

    cardNumber = self.cardNumberTextField.text;
    nome = self.nomeTextField.text;
    cvv = self.cvvTextField.text;
    mes = self.mesTextField.text;
    ano = self.anoTextField.text ;
    preco = self.precoName;
    productName = self.productName;
  
    
    // convertendo as strings em NSNumber do mes e ano
    NSInteger mesNumber = [mes intValue];
    NSInteger anoNumber = [ano intValue];

    
    // pegando primeiro numero do cartao
    NSString *firstString = [cardNumber substringToIndex:1];
    NSInteger firstNumber = [firstString intValue];
    
    if (firstNumber == 4) {
        bandeira = @"Visa";
    
    }
    else if (firstNumber == 5) {
        bandeira = @"Master";
    }
    else {
        
     bandeira = @"Outra Bandeira";
    }
    
    // pegando se a transferencia é debito ou credito
    if(segmentControl.selectedSegmentIndex == 0)
        
    {
        
        tipo = @"Débito";
        
    }
    
    else
        
        if(segmentControl.selectedSegmentIndex == 1)
            
        {
            tipo = @"Crédito";
            
        }

    
    // conexao com firebase
    Firebase *ref =[[Firebase alloc] initWithUrl:@"https://desafiostonetamyres.firebaseio.com"];
    
    NSDictionary *transferencia = @{
                             @"cardNumber": cardNumber,
                             @"nome": nome,
                             @"cvv": cvv,
                             @"mes": mes,
                             @"ano": ano,
                             @"preco": preco,
                             @"productName": productName,
                             @"bandeira": bandeira,
                             @"tipo": tipo
                        
                             };
    
   
    
    Firebase *transRef = [ref childByAutoId];
    
  
    
    
  // Testando validade dos dados
    
   if([cvv length] < 3) {
        
         [self alert:@"Código de segurança errado!" withMessage:@""];
    
    }
    
   else if (cardNumber == nil || nome == nil || cvv == nil || mes == nil || ano == nil) {
        
        [self alert:@"Por favor, preencha todos os campos para finalizar" withMessage:@""];
        
    }
    
    else if ([cardNumber length] != 16) {
        
        [self alert:@"Número do cartão inválido!" withMessage:@""];
    
    }
    
    else if ([ano length] < 4) {
        
        [self alert:@"Ano inválido, deve conter 4 dígitos." withMessage:@""];
    
    }
    
    else if ( mesNumber >12 || mesNumber < 1 )
    {
        
        [self alert:@"Data de validade inválida!" withMessage:@""];

    }
    
    else if ( firstNumber < 4 || firstNumber > 5)
    {
        [self alert:@"Bandeira inválida, apenas cartōes Visa ou Master!" withMessage:@""];
    }
    
    else if (anoNumber < 2016 || anoNumber > 2024) {
        
        [self alert:@"Ano inválido." withMessage:@""];
    }
 
    
    else {
        
    
        [transRef setValue:transferencia withCompletionBlock:^(NSError *error, Firebase *ref) {
        
            if (error) {
                NSLog(@"Data could not be saved.");
               
                
            } else {
                
                NSLog(@"Data saved successfully.");
                [self alert:@"Transação realizada com sucesso!" withMessage:@""];
    
            }
        }];
    
    
    }
    
}

// criando alerta
-(void) alert: (NSString*)title withMessage:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:title  message:message  preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
