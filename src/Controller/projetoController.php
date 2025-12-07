<?php

namespace App\Controller;
use App\config\Database;
use function App\src\connect;

class projetoController
{
    public function projeto()
    {
        require __DIR__ . '/../../public/projeto/projeto.html';
    }
}
