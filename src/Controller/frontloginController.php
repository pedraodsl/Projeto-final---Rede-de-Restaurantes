<?php
namespace App\Controller;
use App\config\Database;
use function App\src\connect;


class frontloginController
{
    public function flogin()
    {
        include_once('login.php');
    }
}
