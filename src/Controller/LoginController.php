<?php

namespace App\Controller;
use App\config\Database;
use function App\src\connect;
use App\Controller\CadastroController;
use OpenSSLAsymmetricKey;
session_start();

class LoginController
{
    function gen_query_key($cpf, $lenght = 32)
    {
        $pdo = connect();
        $controller = new Database();
        $key_test = $controller->buscar_chave($pdo, $cpf);
        if ($key_test == false) {
            return random_bytes($lenght);
        } else {
            return $this->gen_query_key($cpf, $lenght);
        }
    }

    function gen_key($lenght = 32)
    {
        $key_test = random_bytes($lenght);
        return $key_test;
    }

    function cripto($plaintext, $key)
    {
        $cipher = "AES-256-CBC";

        $ivlen = openssl_cipher_iv_length($cipher);
        $iv = openssl_random_pseudo_bytes($ivlen);

        $ciphertext_raw = openssl_encrypt($plaintext, $cipher, $key, OPENSSL_RAW_DATA, $iv);

        $hmac = hash_hmac('sha256', $ciphertext_raw, $key, true);

        $ciphertext = base64_encode($iv . $hmac . $ciphertext_raw);

        return $ciphertext;
    }

    function decript($ciphertext, $key)
    {
        $cipher = "AES-256-CBC";
        $ivlen = openssl_cipher_iv_length($cipher);
        $c = base64_decode($ciphertext);
        $iv = substr($c, 0, $ivlen);
        $hmac = substr($c, $ivlen, $sha256len = 32);
        $ciphertext_raw = substr($c, $ivlen + $sha256len);
        $calchmac = hash_hmac('sha256', $ciphertext_raw, $key, true);
        if (!hash_equals($hmac, $calchmac)) {
            return false;
        }
        $original_plaintext = openssl_decrypt($ciphertext_raw, $cipher, $key, OPENSSL_RAW_DATA, $iv);
        return $original_plaintext;
    }

    public function login()
    {

        $pdo = connect();
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            if (empty($_POST['cpf']) || empty($_POST['senha'])) {
                header('Location: /login2');
                #header("Location: $url_atual");
            } else {
                $cpf = filter_input(INPUT_POST, 'cpf', FILTER_SANITIZE_SPECIAL_CHARS);
                $h_cpf = password_hash($cpf, PASSWORD_DEFAULT);
                $controller = new Database();
                $senha = filter_input(INPUT_POST, 'senha', FILTER_SANITIZE_SPECIAL_CHARS);
                $hash = $controller->buscar_chave($pdo, "usuario", $cpf, "cpf");
                $h_senha = password_hash($senha, PASSWORD_DEFAULT);
                $tabela_usuario = "usuario";
                if (password_verify($senha, $hash['senha_hash'])) {
                    $user = $controller->Login($pdo, $tabela_usuario, $cpf, $hash['senha_hash']);
                    if ($user) {
                        $_SESSION['cpf'] = $user['cpf'];
                        $_SESSION['nome'] = $user['nome'];
                        header('Location: /');
                        exit();
                    } else {
                        header('Location: /login2');
                        exit();
                    }
                } else {
                    header('Location: /login2');
                }
            }
        }
    }

    public function log_adm()
    {
        $pdo = connect();
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            if (empty($_POST['adm_email']) || empty($_POST['adm_senha'])) {
                #echo "por favor preencha todos os campos!";
                $mail = 2;
            } else {
                $email = filter_input(INPUT_POST, 'adm_email', FILTER_SANITIZE_SPECIAL_CHARS);
                $senha = $_POST['adm_senha'];
                $controller = new Database();
                $log = new LoginController();
                $unique = $controller->buscar($pdo, "administrador");
                $email_h = $controller->buscar($pdo, "chave_email_adm");
                foreach ($unique as $value) {
                    if (password_verify($senha, $value['senha_hash'])) {
                        $k_email = $controller->buscar_chave($pdo, "administrador", $value['senha_hash'], "senha_hash");
                        $user = $controller->login_adm($pdo, $k_email['email'], $value['senha_hash']);
                        if($user) {
                            $_SESSION['id_adm'] = $user['id_adm'];
                            $_SESSION['id_restaurante'] = $user['id_restaurante'];
                            header('Location: /admin2');
                            exit;
                        } else {
                            header('Location: /login2');
                        }
                    } else {
                        header('Location: /login2');
                    }
                }
            }
        }
    }
}
