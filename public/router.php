<?php
// router.php
$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Se o URI for para um arquivo estático (ex: .png, .jpg, .css, etc.),
// retorne FALSE para que o servidor embutido sirva o arquivo diretamente.
if (preg_match('/\.(?:png|jpg|jpeg|gif|css|js|ico)$/', $path)) {
    return false;
}

// Caso contrário, inclua o seu index.php principal (front controller).
// Isso garante que sua lógica de roteamento em web.php seja executada
// para todas as outras requisições, incluindo POST.
require __DIR__ . '/index.php';
