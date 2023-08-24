
/* ========================      Desafio POP     ==========================
 
 Criar um projeto no playground usando o Xcode aplicando o Paradigma de Programação Orientada a Protocolos
 Explorar os seguintes conceitos:
 [x] Controles de Fluxos
 [x] Coleções
 [x] Funções
 [x] Closures
 [x] Enums
 [x] Structs
 [x] Concorrências
 
==========================================================================*/

import Foundation

// Enum para representar as marcas de motos
enum MarcaMoto: String {
    case yamaha
    case honda
    case ducati
    case kawasaki
    case suzuki
}

// Struct para representar uma moto esportiva
struct MotoEsportiva {
    var marca: MarcaMoto
    var modelo: String
    var velocidadeMaxima: Double
}

// Protocolo para definir uma moto esportiva
protocol MotoProtocol {
    var moto: MotoEsportiva { get }
    func acelerar()
}

// Protocolo para definir um piloto de moto
protocol PilotoMoto {
    var nome: String { get }
    func pilotar(moto: MotoProtocol) async
}

// Extensão para o protocolo MotoProtocol com implementação padrão
extension MotoProtocol {
    func acelerar() {
        print("Acelerando a \(moto.marca.rawValue) \(moto.modelo) até \(moto.velocidadeMaxima) km/h.")
    }
}

// Implementando do protocolo MotoProtocol
struct MotoImpl: MotoProtocol {
    var moto: MotoEsportiva
}

// Implementando o protocolo PilotoMoto + Concorrencia com async/await
struct PilotoMotoImpl: PilotoMoto {
    var nome: String
    
    func pilotar(moto: MotoProtocol) async {
        print("\(nome) está pilotando a \(moto.moto.marca.rawValue) \(moto.moto.modelo).")
        await moto.acelerar()
    }
}

// Criando motos esportivas
let moto1 = MotoEsportiva(marca: .yamaha, modelo: "YZF R1", velocidadeMaxima: 299.0)
let moto2 = MotoEsportiva(marca: .honda, modelo: "CBR 1000RR", velocidadeMaxima: 280.0)
let moto3 = MotoEsportiva(marca: .ducati, modelo: "Panigale V4", velocidadeMaxima: 330.0)

// Criando um array de pilotos
let pilotos: [PilotoMoto] = [
    PilotoMotoImpl(nome: "João"),
    PilotoMotoImpl(nome: "Paulo"),
    PilotoMotoImpl(nome: "Robson")
]

// Simulando a pilotagem assíncrona das motos pelos pilotos usando async/await
Task {
    for piloto in pilotos {
        for moto in [moto1, moto2, moto3] {
            await piloto.pilotar(moto: MotoImpl(moto: moto))
        }
    }
}
