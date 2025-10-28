<?php

namespace App\src;
//salva as credenciais de acesso ao banco
try {
    $host = "localhost";
    $user = "root";
    $password = "";
    $dbname = "notebook";

    //cria o PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);

    //define como possiveis erros serão relatados
    $pdo ->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    //verifica se a conexão funcinou ou não
    echo "Connected sucessfully";
} catch (PDOException $e) {
    echo "Connection failed: ", $e->getMessage(), "\n";

}
?>
