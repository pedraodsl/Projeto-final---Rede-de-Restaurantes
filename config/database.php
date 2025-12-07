<?php

namespace App\config;
use function App\src\connect;
use PDO;


class Database
{
    function buscar($pdo, $tabela)
    {

        $sql = "SELECT * FROM $tabela";
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    function insert($pdo, $tabela, $campo1, $campo2, $dado, $dado2)
    {
        $sql = "INSERT INTO $tabela ($campo1, $campo2) VALUES (?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt -> execute([$dado, $dado2]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    function buscar_id($pdo, $tabela, $campo, $id)
    {

        $sql = "SELECT * FROM $tabela WHERE $campo = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function inserir_reserva($pdo, $tabela, $email,$nome, $telefone, $data, $hora)
    {

        $sql = "INSERT INTO $tabela (email, nome_completo, telefone, data, hora ) VALUES(?, ?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$email, $nome, $telefone, $data, $hora]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    function Login($pdo, $tabela, $cpf, $senha)
    {
        $sql = "SELECT * FROM $tabela WHERE cpf = ? AND senha_hash = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$cpf, $senha]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function admin($pdo, $tabela, $email, $senha)
    {
        $tabela = "administrador";
        $sql = "SELECT * FROM ? WHERE email = '?' AND senha = '?'";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$tabela, $email, $senha]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function inserir_usuario($pdo, $cpf, $nome, $senha)
    {
        $tabela = "usuario";
        $sql = "INSERT INTO $tabela (cpf, nome, senha_hash) VALUES (?, ?, ?) ";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$cpf, $nome, $senha]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    function val_cadastro($pdo, $cpf, $senha)
    {
        $tabela = "usuarios";
        $sql = "SELECT * FROM ? WHERE cpf = '?' AND senha = '?'";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$tabela, $cpf, $senha]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function buscar_id_extrangeiro($pdo, $tabela, $id)
    {
        $dest = "restaurante";
        $reference_a = "a";
        $reference_b = "r";
        $sql = "SELECT $reference_a.*, $reference_b.* FROM ? a JOIN ? r ON a.id_restaurante = r.id_restaurante WHERE a.id_adm = [?]";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$tabela, $dest, $id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function inserir_chave($pdo, $chave, $cpf)
    {
        $dest = "usuario_chave";
        $sql = "INSERT INTO ? (cpf, chave_criptografada) VALUES ('?', '?')";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$dest, $cpf, $chave]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function buscar_chave($pdo, $tabela, $senha, $campo)
    {
        $dest = $tabela;
        $camp = $campo;
        $sql = "SELECT * FROM $dest WHERE $camp = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$senha]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function buscar_user($pdo, $senha)
    {
        $tabela = "administrador";
        $sql = "SELECT * FROM  $tabela  WHERE senha_hash = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$senha]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function login_adm($pdo, $email, $senha)
    {
        $tabela = "administrador";
        $sql = "SELECT * FROM $tabela WHERE email = ? AND senha_hash = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$email, $senha]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function transaction($pdo, $nome_rest, $cod, $cpf, $email, $senha, $cidade, $nome_adm, $key)
    {
        $tabela_pai = "restaurante";
        $tabela_filho = "produto";
        $tabela_filho2 = "chave_adm";
        try {
            $pdo->beginTransaction();
            $stmt_pai = $pdo->prepare("INSERT INTO $tabela_pai (nome, cod) VALUES (?, ?)");
            $stmt_pai->execute([$nome_rest, $cod]);
            $ultimo_id_restaurante = $pdo->lastInsertId();
            $stmt_filho = $pdo->prepare("INSERT INTO $tabela_filho (id_produto, nome, email, senha_hash, cpf) VALUES (?, ?, ?, ?, ?)");
            $stmt_filho->execute([$ultimo_id_restaurante, $nome_adm, $email, $senha, $cpf]);
            $ultimo_id_adm = $pdo->lastInsertId();
            $stmt_filho2 = $pdo->prepare("INSERT INTO $tabela_filho2 ( id_adm, chave_criptografia ) VALUES ( ?, ?)");
            $stmt_filho2->execute([$ultimo_id_adm, $key]);
            $pdo->commit();
        } catch (\PDOException $e) {
            $pdo->rollBack();
            die("Erro ao inserir dados: " . $e->getMessage());
        }
    }

    function key_transaction($pdo, $cpf, $nome, $senha, $key)
    {
        $tabela_pai = "usuario";
        $tabela_filho = "usuario_chave";
        try {
            $pdo->beginTransaction();
            $stmt_pai = $pdo->prepare("INSERT INTO $tabela_pai (cpf, nome, senha_hash) VALUES (?, ?, ?) ");
            $stmt_pai->execute([$cpf, $nome, $senha]);
            $ultimo_id_usuario = $pdo->lastInsertId();
            $stmt_filho = $pdo->prepare("INSERT INTO $tabela_filho (cpf, senha_hash, chave_criptografia) VALUES (?, ?, ?) ");
            $stmt_filho->execute([$cpf, $senha, $key]);
            $pdo->commit();
        } catch (\PDOException $e) {
            $pdo->rollBack();
            die ("Erro ao inserir dados: " . $e->getMessage());
        }
    }

    function insert_prato($pdo, $id_rest, $id_admin, $nome, $preco)
    {
        $tabela = "produto";
        $sql = "INSERT INTO $tabela (id_restaurante, id_administrador, nome, preco) VALUES (?, ?, ?, ?)";
        $stmt = $pdo->prepare($sql);
        return $stmt->execute([$id_rest, $id_admin, $nome, $preco]);
        #return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    function clientes($pdo)
    {
        $tabela = "agendamento";
        $sql = " SELECT COUNT(*) FROM $tabela WHERE DATE(data) = CURDATE()";
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchColumn();
    }

    function inserir_compra($pdo, $valor_total)
    {
        $tabela = "compra";
        $sql = "INSERT INTO $tabela (valor_total) VALUES (?)";
        $stmt = $pdo->prepare($sql);
        return $stmt->execute([$valor_total]);
    }

    function grafico($pdo)
    {
        $tabela = "compra";
        $sql = "SELECT SUM(valor_total) FROM $tabela";
        $stmt = $pdo->prepare($sql);
        $stmt->execute();
        return $stmt->fetchColumn();
    }

}
