<?php

use PHPUnit\Framework\TestCase;

require_once('src/Greeting.php');

class GreetingTest extends TestCase
{
    public function testGreetReturnsHelloWorld()
    {
        $this->assertEquals('Hello world', Greeting::greet());
    }
}
