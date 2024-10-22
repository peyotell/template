<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Template\Greeting;

echo Greeting::greet();
echo ' ' . ItsMyClass::greet();