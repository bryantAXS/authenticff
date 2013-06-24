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

$app->get("/invoice", function() use($app){

  $app->render('master.html.twig', array(
    "invoice" => true
  ));

});

$app->post("/invoice", function() use($app){

  $req = $app->request();
  $token = $req->params('stripeToken');

  //FIXME: this is the test key
  Stripe::setApiKey("O8INd0AiOhSFjodZYpvrDtpnZ1slIIhS");

  try {
  $charge = Stripe_Charge::create(array(
    "amount" => 76826, // amount in cents, again
    "currency" => "usd",
    "card" => $token,
    "description" => "dad@example.com")
  );
  } catch(Stripe_CardError $e) {
    var_dump("error");
  }

  $app->render('master.html.twig', array(
    "invoice" => true
  ));

});

$app->run();