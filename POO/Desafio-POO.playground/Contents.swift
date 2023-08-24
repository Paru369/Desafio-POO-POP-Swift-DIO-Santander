
/* ========================      Desafio POO     ==========================
 
 Criar um projetos no playground usando o Xcode aplicando o Paradigma de Programação Orientada a Objetos
 
 Explorar os seguintes conceitos:
 [x] Controles de Fluxos
 [x] Coleções
 [x] Funções
 [x] Closures
 [x] Enums
 [x] Structs
 [x] Concorrências
 
==========================================================================*/

import UIKit
import Foundation

// Enum para representar o tipo de comida
enum TipoComida {
    case entrada
    case pratoPrincipal
    case sobremesa
}

// Struct para representar um prato de comida
struct Prato {
    var nome: String
    var tipo: TipoComida
    var preco: Double
}

// Classe para representar um restaurante + Concorrencia com DispatchQueue
class Restaurante {
    var nome: String
    var pratos: [Prato] = []
    let queue = DispatchQueue(label: "com.example.restaurant.queue", attributes: .concurrent)
    
    init(nome: String) {
        self.nome = nome
    }
    
// Função para adicionar um prato ao cardápio + Concorrencia com Async
    func adicionarPrato(nome: String, tipo: TipoComida, preco: Double) {
        let novoPrato = Prato(nome: nome, tipo: tipo, preco: preco)
        queue.async(flags: .barrier) {
            self.pratos.append(novoPrato)
        }
    }
    
// Closure para listar pratos de um tipo específico
    let listarPratos: (TipoComida) -> Void = { tipo in
        print("Pratos do tipo \(tipo):")
        for prato in restaurante.pratos where prato.tipo == tipo {
            print("- \(prato.nome) (R$ \(prato.preco))")
        }
    }
}

// Criando uma instância do restaurante
let restaurante = Restaurante(nome: "Delícias do Sabor Natureba")

// Adicionando pratos ao cardápio do restaurante
restaurante.adicionarPrato(nome: "Carpaccio de Coco Verde", tipo: .entrada, preco: 15.0)
restaurante.adicionarPrato(nome: "Tofu Grelhado", tipo: .pratoPrincipal, preco: 25.0)
restaurante.adicionarPrato(nome: "Tiramisù", tipo: .sobremesa, preco: 12.0)

// Listando pratos de cada tipo usando a closure
restaurante.listarPratos(.entrada)
restaurante.listarPratos(.pratoPrincipal)
restaurante.listarPratos(.sobremesa)

