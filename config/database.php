<?php

namespace App\config;
use function App\src\connect;
class Database
{
    function buscar($pdo, $tabela)
    {
        $sql = "SELECT * FROM $tabela";
        $stmt = $pdo -> prepare($sql);
        $stmt -> execute();
        return $stmt -> fetchAll(PDO::FETCH_ASSOC);
    }

    function buscar_id($pdo, $tabela, $id)
    {
        $sql = "SELECT * FROM $tabela WHERE id = $id";
        $stmt = $pdo -> prepare($sql);
        $stmt -> execute();
        return $stmt -> fetch(PDO::FETCH_ASSOC);
    }

    function inserir_reserva($pdo, $tabela, $email, $cpf, $nome, $telefone)
    {
        $sql = "INSERT INTO $tabela (email, cpf, nome, telefone) VALUES($email, $cpf, $nome, $telefone)";
        $stmt = $pdo -> prepare($sql);
        $stmt -> execute();
        return $stmt -> fetchAll(PDO::FETCH_ASSOC);
    }

    function Login($pdo, $tabela, $email, $senha)
    {
        $sql = "SELECT * FROM $tabela WHERE email = '$email' AND senha = '$senha'";
        $stmt = $pdo -> prepare($sql);
        $stmt -> execute();
        return $stmt -> fetch(PDO::FETCH_ASSOC);
    }

    function inserir_usuario($pdo, $cpf, $nome, $email, $telefone, $senha)
    {
        $sql = "INSERT INTO usuario (cpf, nome, email, telefone, senha) VALUES ('$cpf', '$nome', '$email', '$telefone', '$senha') ";
        $stmt = $pdo -> prepare($sql);
        $stmt -> execute();
        return $stmt -> fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
