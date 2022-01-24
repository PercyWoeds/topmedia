

<?php

use Greenter\Model\Sale\Invoice;
use Greenter\Xml\Builder\InvoiceBuilder;

$invoice = new Invoice();
$invoice->setSerie('F001');
$invoice->setCorrelativo('1');
// ...

$builder = new InvoiceBuilder();
$xml = $builder->build($invoice);

echo $xml;