<?php
require_once __DIR__ . '/../vendor/autoload.php';

use Template\Greeting;

echo 'Hi docker';
echo Greeting::greet();