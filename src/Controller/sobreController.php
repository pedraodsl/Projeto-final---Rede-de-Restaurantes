<?php

namespace App\Controller;
use App\config\Database;
use function App\src\connect;

class sobreController
{
    public function sobre()
    {
        require __DIR__ . '/../../public/sobre-nos/sobre.html';
    }
}
