<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Template\Greeting;
use Template\ItsMyClass;

echo Greeting::greet();
echo ' ';
echo ItsMyClass::greet();