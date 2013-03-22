<?php
require ROOT . '/vendor/autoload.php';
require ROOT.'/app/config/config.php';

$app = new \Slim\Slim(array(
  'templates.path' => ROOT . '/app/views'
  ,'debug' => true
  ,'view' => new \Slim\Extras\Views\Twig()
));

$app->get("/", function() use($app){

  $app->render('master.html.twig');

});

$app->run();