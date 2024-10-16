<?php

use PHPUnit\Framework\TestCase;

require_once('src/ItsMyClass.php');

class ItsMyClassTest extends TestCase
{
    public function testGreetReturnsItsMyClass()
    {
        $this->assertEquals('ItsMyClass', ItsMyClass::greet());
    }
}
