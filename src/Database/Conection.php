<?php

namespace App\src;

use PDO;
use PDOException;

function connect()
{


//salva as credenciais de acesso ao banco
    $host = "localhost";
    $user = "root";
    $password = "restaurante";
    $dbname = "db_franquia";

    try {
        //cria o PDO
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);

        //define como possiveis erros serão relatados
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


        #echo "Connected sucessfully";
        return $pdo;
    } catch (PDOException $e) {
        echo "Connection failed: ", $e->getMessage(), "\n";

    }
}



