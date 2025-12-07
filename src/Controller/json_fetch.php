<?php

namespace App\Controller;
use App\config\Database;
use function App\src\connect;


function buscar() {
    $pdo = connect();
    $controller = new Database();
    $dados = $controller -> buscar($pdo, "produto");
    return $dados;
}


// 1. Chamar a função para obter os dados
$dados_pratos = buscar();

// 2. Opcional: Processar com foreach se necessário, senão json_encode aceita o array direto
$resultados = [];
foreach ($dados_pratos as $prato) {
    // Adicione lógica extra aqui se precisar
    $resultados[] = $prato;
}

// 3. Definir o cabeçalho para JSON
header('Content-Type: application/json');

// 4. Codificar os dados para JSON e imprimir
echo json_encode($resultados);

