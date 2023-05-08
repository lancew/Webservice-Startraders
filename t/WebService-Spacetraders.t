use Test2::V0 -target=>'WebService::Spacetraders';
# Structural tests of the module

isa_ok($CLASS, 'WebService::Spacetraders');

can_ok($CLASS, 'token');
can_ok($CLASS, 'http');
can_ok($CLASS, 'url');

done_testing;